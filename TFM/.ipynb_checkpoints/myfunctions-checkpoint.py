import numpy as np
import ee
import folium
import pandas as pd

def foliumLayer(image,centerx,centery,parameters = {},layer_name = "layer"):
    
    folium_map = folium.Map(location = [centery,centerx],zoom_start = 13,tiles = 'openstreetmap')
    
    mapIdDict = image.getMapId(parameters) # convertir imagen a id de visualizacion
    
    tile = folium.TileLayer(tiles = mapIdDict['tile_fetcher'].url_format,
                            attr = 'Map Data &copy; <a href="https://earthengine.google.com/">Google Earth Engine</a>',
                            overlay = True,
                            name = layer_name)
    
    tile.add_to(folium_map)
    
    folium_map.add_child(folium.LayerControl())
    
    return folium_map

def clip_images(image):
        
    return image.clip(ROI).copyProperties(image,["system:time_start"]) # retornar imagenes recortadas

def clouds_shadows_mask(image):
    
    shadows_mask = image.select('SCL').eq(3).Not() # pixeles que no son sombra
    clouds_mask = image.select('SCL').lt(7).Or(image.select('SCL').gt(9)) # pixeles que no son nubes
    empirical_clouds_mask = image.select('B2').lte(1500) # Pixeles que no son nubes
    clouds_mask = clouds_mask.And(empirical_clouds_mask) # Pixeles que no son nubes
    mask = shadows_mask.And(clouds_mask) # pixeles que no son ni sombra ni nubes
    
    return image.updateMask(mask).copyProperties(image,["system:time_start"]) # retornar imagenes enmascaradas

def collectS2Images(interestDate,deltaDays,ROI,clipImages = True):
        
    interestDate = np.datetime64(interestDate)
    initialDate = np.datetime_as_string(interestDate - np.timedelta64(deltaDays,'D'))
    finalDate = np.datetime_as_string(interestDate + np.timedelta64(deltaDays,'D'))
    
    IC = ee.ImageCollection("COPERNICUS/S2_SR").filterDate(initialDate,finalDate).filterBounds(ROI)
    
    if clipImages:
        
        def clip_images(image):        
            return image.clip(ROI).copyProperties(image,["system:time_start"]) # retornar imagenes recortadas
        
        IC = IC.map(clip_images)
    
    return IC

def reflectance(image):
        
    return ee.Image(image.multiply(0.0001).copyProperties(image,["system:time_start"]))

def automaticWaterMask(image,ROI,index = "GNDVI",seedSpacing = 20,gridType = "square",compactness = 1,connectivity = 8,scale = 10,k = 3,pTrain = 0.8):

    print("Determinando de máscara de agua...")
    
    print("******************************")    
    if index == "GNDVI":
        idx = image.normalizedDifference(['B8','B3'])
    elif index == "NDWI":
        idx = image.normalizedDifference(['B3','B8'])
    
    seeds = ee.Algorithms.Image.Segmentation.seedGrid(seedSpacing,gridType)    
    SNIC = ee.Algorithms.Image.Segmentation.SNIC(image = ee.Image.cat([image.select(['B2','B3','B4','B8']),idx]),                                             
                                                 compactness = compactness,
                                                 connectivity = 8,                                                 
                                                 seeds = seeds)
    SNIC = SNIC.select(['B2_mean','B3_mean','B4_mean','B8_mean','nd_mean','clusters'], ['B2','B3','B4','B8','idx','clusters'])
    
    nseeds = seeds.reduceRegion(reducer = ee.Reducer.count(),geometry = ROI,scale = scale).getInfo()['seeds']
    ntrain = round(nseeds*pTrain)
    if ntrain > 10000:
        ntrain = 10000
    #elif ntrain < 1000:
    #    ntrain = 1000
    #ntrain = 5000
    objectPropertiesImage = SNIC.select(['B2','B3','B4','B8','idx'])
    X_train = objectPropertiesImage.sample(scale = scale,numPixels = ntrain,region = ROI,geometries = True)
    kmeans = ee.Clusterer.wekaKMeans(k)
    kmeans = kmeans.train(X_train)
    clusterImage = objectPropertiesImage.cluster(kmeans)
    
    values = []
    for i in range(k):
        cluster_mask = clusterImage.eq(i)
        idx_clusterMasked = idx.updateMask(cluster_mask)
        mean_value = idx_clusterMasked.reduceRegion(reducer = ee.Reducer.mean(),geometry = ROI,scale = 10)
        values.append(mean_value.getInfo()['nd'])
        print("---> Avance:",round((i+1)*100/(k),2),"% <---")
        
    if index == "GNDVI":
        cluster_water = np.array(values).argmin().item()
    elif index == "NDWI":
        cluster_water = np.array(values).argmax().item()    

    print("Proceso finalizado")
    water_mask = clusterImage.eq(cluster_water)
    
    return water_mask, idx, SNIC, X_train, clusterImage, ntrain, nseeds

def depthCumulativeCost(waterMask,ROI,scale = 10,maxDistance = 1000):

    water_poly = waterMask.reduceToVectors(geometry = ROI,scale = scale,eightConnected = False)
    water_poly = water_poly.filter(ee.Filter.eq('label',1))

    coords = water_poly.geometry().coordinates().getInfo()
    lines = []
    for i in range(len(coords)):
        for j in range(len(coords[i])):
            lines.append(ee.Geometry.LineString(coords[i][j]))

    allLines = ee.FeatureCollection(lines)

    sources = ee.Image().toByte().paint(allLines, 1)
    sources = sources.updateMask(sources)

    cumulativeCost = waterMask.cumulativeCost(source = sources,maxDistance = maxDistance).updateMask(waterMask)
    
    return cumulativeCost

def loadBathymetry(filePath,delimeter = "/t",usecols = (2,3,5),startLine = 7):

    f = open(filePath)
    textList = f.readlines()[startLine:]

    outF = open("bathyTemp.txt","w")
    for line in textList:
        line = line.replace(",",".")
        outF.write(line)    
    outF.close()

    bathy = np.loadtxt("bathyTemp.txt",delimiter = delimeter,usecols = usecols)
    
    return bathy

def pixelDataFromCoordinates(image,coords,coordsCols = [0,1],batchSize = 5000,scale = 10,joinData = True,toPandas = True):
    
    extractedData = []

    k = 0

    print("Comenzando la extracción de datos...")
    while k <= coords.shape[0]:

        print("******************************")
        print("Creando nuevo batch...")
        pointFeatures = []

        initial = k
        print("Inicia en",initial)

        if k + batchSize > coords.shape[0]:
            final = coords.shape[0]
        else:
            final = k + batchSize
        print("Finaliza en",final)

        print("Realizando extracción...")
        for i in range(initial,final):
            pointFeatures.append(ee.Geometry.Point([coords[i,coordsCols[0]],coords[i,coordsCols[1]]]))

        fromList = ee.FeatureCollection(pointFeatures)

        imageDictionary = image.reduceRegions(collection = fromList,reducer = ee.Reducer.first(),scale = scale)

        features = imageDictionary.getInfo()['features']

        for i in range(len(features)):
            extractedData.append(list(features[i]['properties'].values()))

        print("Extracción finalizada")
        print("---> Avance:",round(final*100/coords.shape[0],1),"% <---")

        k = k + batchSize
    
    if joinData:
        extractedData = np.concatenate((coords,np.array(extractedData)),axis = 1)
    
    if toPandas:
        extractedData = pd.DataFrame(extractedData)
    
    return extractedData

def clouds_shadows_mask_gaps(image):
    
    shadows_mask = image.select('SCL').eq(3).Not() # pixeles que no son sombra
    clouds_mask = image.select('SCL').lt(7).Or(image.select('SCL').gt(9)) # pixeles que no son nubes
    empirical_clouds_mask = image.select('B2').lte(1500) # Pixeles que no son nubes
    clouds_mask = clouds_mask.And(empirical_clouds_mask) # Pixeles que no son nubes
    mask = shadows_mask.And(clouds_mask) # pixeles que no son ni sombra ni nubes
    
    return mask.Not() # retornar todo lo que sea nube

def fillGaps(imageCollection,imageReduced):

    gaps_mask = imageCollection.map(clouds_shadows_mask_gaps).product().toByte()

    kernelList = [[1,1,1],[1,0,1],[1,1,1]]
    kernel = ee.Kernel.fixed(3,3,kernelList,-1,-1,False)

    imageUnmasked = imageReduced.unmask()

    imageConvolved = imageReduced.focal_median(kernel = kernel,iterations = 50)

    imageFilled = imageConvolved.multiply(gaps_mask).add(imageUnmasked)
    
    return imageFilled

def imageConfusionMatrix(truthImage,predictedImage,ROI,scale = 10):
    
    print("Generando Matriz de Confusión...")
    print("******************************")
    predictedImage = predictedImage.multiply(10)
    confusion_image = truthImage.add(predictedImage)

    TN = confusion_image.eq(0)
    TN = TN.updateMask(TN).reduceRegion(ee.Reducer.count(),ROI,scale = scale).getInfo()['nd']
    print("---> Avance: 25 % <---")

    FN = confusion_image.eq(1)
    FN = FN.updateMask(FN).reduceRegion(ee.Reducer.count(),ROI,scale = scale).getInfo()['nd']
    print("---> Avance: 50 % <---")

    FP = confusion_image.eq(10)
    FP = FP.updateMask(FP).reduceRegion(ee.Reducer.count(),ROI,scale = scale).getInfo()['nd']
    print("---> Avance: 75 % <---")

    TP = confusion_image.eq(11)
    TP = TP.updateMask(TP).reduceRegion(ee.Reducer.count(),ROI,scale = scale).getInfo()['nd']
    print("---> Avance: 100 % <---")
    
    print("Proceso finalizado")
    
    return [TP,FP,TN,FN], confusion_image

def preprocessingPipeline(images,ROI,masking = True,gapFilling = True,calculateReflectance = True,smoothing = True):    
    
    print("Iniciando preprocesamiento...")
    original = images
    
    if type(images) == ee.imagecollection.ImageCollection:        
        if masking:
            print("Enmascarando nubes y sombras")
            images = images.map(clouds_shadows_mask)
        images = images.median().select(['B2','B3','B4','B8']).clip(ROI)
        if gapFilling:
            print("Rellenando vacíos")
            images = fillGaps(original,images)
        if calculateReflectance:
            print("Calculando reflectancia")
            images = reflectance(images)
        if smoothing:
            print("Filtrando imagen")
            images = images.focal_median(radius = 1,kernelType = "square")
    
    elif type(images) == ee.image.Image:        
        if masking:
            print("Enmascarando nubes y sombras")
            images = clouds_shadows_mask(images)
        images = images.select(['B2','B3','B4','B8']).clip(ROI)
        if gapFilling:
            print("Rellenando vacíos")
            images = fillGaps(original,images)
        if calculateReflectance:
            print("Calculando reflectancia")
            images = reflectance(images)
        if smoothing:
            print("Filtrando imagen")
            images = images.focal_median(radius = 1,kernelType = "square")
    
    return images