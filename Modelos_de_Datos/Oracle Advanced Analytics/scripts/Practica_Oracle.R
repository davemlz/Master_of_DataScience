library(ORE)

# DAVID MONTERO LOAIZA

# 1. Conectar a la base de datos
ore.connect(user = "ruser", host = "130.61.215.115",
            password = "ruser",
            service_name = "pdb1.sub12041412512.bdcevcn.oraclevcn.com",all=TRUE) 

# 2. Cargar la tabla ONTIME_S: Datos de compañías de vuelos
head(ONTIME_S)

# 3. Realizar una agregación para calcular el número de vuelos por destino
vuelosDestino = aggregate(ONTIME_S$DEST,by = list(ONTIME_S$DEST),FUN = length)
names(vuelosDestino) = c('Destino','Nvuelos')
head(vuelosDestino)

# 4. Calcular cuál es la desviación estándar del retraso de llegada de vuelo para cada aerolínea por destino:
# Utilizar los campos DEST, ARRDELAY, UNIQUECARRIER
sdDelay = aggregate(ONTIME_S$ARRDELAY,by = list(ONTIME_S$DEST,ONTIME_S$UNIQUECARRIER),FUN = sd,na.rm = TRUE)
names(sdDelay) = c('Destino','Aerolinea','sdDelay')
head(sdDelay)

# 5. Realizar una regresión linear para calcular el retraso de llegada: Utilizar ore.lm
lmModel = ore.lm(ARRDELAY ~ DISTANCE + DEPDELAY,ONTIME_S)
summary(lmModel)

# 6. Construir un modelo linear por destino para predecir el retraso de llegada: Utilizar GroupApply.
lmFunction = function(data){
  
  lm(ARRDELAY ~ DISTANCE + DEPDELAY,data)
  
}

modelList = ore.groupApply(X = ONTIME_S,INDEX = ONTIME_S$DEST,lmFunction)

# 7. Realizar un scoring de retraso de llegada: Utilizar ore.predict o predict
pred = ore.predict(lmModel, ONTIME_S)

# 8. Utilizar representaciones gráficas para demostrar los resultados
plot(ONTIME_S$ARRDELAY,pred,xlab = "Ground Truth",ylab = "Prediction",main = "Arrival Delay Prediction")

# 9. Desplegar el código de regresión linear del punto 6 dentro la base de datos:
# Utilizar ore.scriptCreate
ore.scriptCreate("lmModel",modelList)

ore.disconnect()

# Enviar la practica a olivier.perard@oracle.com