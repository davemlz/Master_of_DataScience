require(ggplot2)
require(raster)
require(rasterVis)
require(rgeos)
require(gstat)
require(mapview)
require(caret)

# require(phylin)
# detach("package:phylin")

options(digits = 10)

toSHP_transform = function(table,to_crs){
  
  if(ncol(table) == 2){names(table) = c("x","y")}
  if(ncol(table) == 3){names(table) = c("x","y","z")}
  coordinates(table) = ~ x + y
  proj4string(table) = CRS("+proj=longlat +datum=WGS84")
  shp = spTransform(table,to_crs)
  
  return(shp)
  
}

interpolate_idw = function(bathymetry,wmt,wmp,coords_wmt,coords_wmp,path = "C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Bat_data/IDW/",name = "Reservoir",k = 10,p = 3.5){
  
  shp_bathymetry = toSHP_transform(bathymetry,crs(wmp))
  shp_wmt = toSHP_transform(coords_wmt,crs(wmp))
  shp_wmp = toSHP_transform(coords_wmp,crs(wmp))
  
  flds = createFolds(shp_bathymetry$z,k = k,list = FALSE)
  
  error = rep(NA,k)
  
  for(i in 1:k){
    
    predicted = idw(z ~ 1,shp_bathymetry[!(flds == i),],shp_bathymetry[(flds == i),],idp = p)$var1.pred
    error[i] = RMSE(predicted,shp_bathymetry$z[(flds == i)])
    
  }
  
  interpolated_wmp = idw(z ~ 1,shp_bathymetry,shp_wmp,idp = p)
  interpolated_wmt = idw(z ~ 1,shp_bathymetry,shp_wmt,idp = p)
  
  r_wmp = rasterize(interpolated_wmp,wmp,"var1.pred")
  r_wmt = rasterize(interpolated_wmt,wmt,"var1.pred")
  
  shapefile(shp_bathymetry,paste0(path,name,"_",p,"_bat.shp"))
  
  writeRaster(r_wmp,paste0(path,name,"_",p,"_wmp.tif"))
  writeRaster(r_wmt,paste0(path,name,"_",p,"_wmt.tif"))
  
  df_wmp = spTransform(interpolated_wmp,CRS("+proj=longlat +datum=WGS84"))
  df_wmt = spTransform(interpolated_wmt,CRS("+proj=longlat +datum=WGS84"))
  
  write.table(df_wmp,paste0(path,name,"_",p,"_wmp.csv"),row.names = FALSE)
  write.table(df_wmt,paste0(path,name,"_",p,"_wmt.csv"),row.names = FALSE)
  
  return(error)
  
}

wmp = raster("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/Maps/WMp_Alto_Lindoso.tif")
wmt = raster("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/Maps/WMt_Alto_Lindoso.tif")
depth = read.table("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Bat_data/Bat_wl_Alto_Lindoso.csv",sep = ",")
toInterpolate_wmp = read.table("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Bat_data/Coords_wmp_Alto_Lindoso.csv",sep = ",")
toInterpolate_wmt = read.table("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Bat_data/Coords_wmt_Alto_Lindoso.csv",sep = ",")

error_idw = interpolate_idw(depth,wmt,wmp,toInterpolate_wmt,toInterpolate_wmp,name = "Alto_Lindoso")
mean(error_idw)
sd(error_idw)

wmp = raster("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/Maps/WMp_Bubal.tif")
wmt = raster("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/Maps/WMt_Bubal.tif")
depth = read.table("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Bat_data/Bat_wl_Bubal.csv",sep = ",")
toInterpolate_wmp = read.table("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Bat_data/Coords_wmp_Bubal.csv",sep = ",")
toInterpolate_wmt = read.table("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Bat_data/Coords_wmt_Bubal.csv",sep = ",")

error_idw = interpolate_idw(depth,wmt,wmp,toInterpolate_wmt,toInterpolate_wmp,name = "Bubal",p = 4)
mean(error_idw)
sd(error_idw)

wmp = raster("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/Maps/WMp_Canelles.tif")
wmt = raster("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/Maps/WMt_Canelles.tif")
depth = read.table("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Bat_data/Bat_wl_Canelles.csv",sep = ",")
toInterpolate_wmp = read.table("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Bat_data/Coords_wmp_Canelles.csv",sep = ",")
toInterpolate_wmt = read.table("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Bat_data/Coords_wmt_Canelles.csv",sep = ",")

error_idw = interpolate_idw(depth,wmt,wmp,toInterpolate_wmt,toInterpolate_wmp,name = "Canelles")
mean(error_idw)
sd(error_idw)

wmp = raster("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/Maps/WMp_Grado.tif")
wmt = raster("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Results/water_mask/Maps/WMt_Grado.tif")
depth = read.table("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Bat_data/Bat_wl_Grado.csv",sep = ",")
toInterpolate_wmp = read.table("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Bat_data/Coords_wmp_Grado.csv",sep = ",")
toInterpolate_wmt = read.table("C:/Users/Dave Mont/Desktop/Master_of_DataScience/TFM/Bat_data/Coords_wmt_Grado.csv",sep = ",")

error_idw = interpolate_idw(depth,wmt,wmp,toInterpolate_wmt,toInterpolate_wmp,name = "Grado")
mean(error_idw)
sd(error_idw)
