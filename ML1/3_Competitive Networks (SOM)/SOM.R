library(stats)
? kmeans
km<-kmeans(iris[,-5],3,nstart=1)
summary(km)
## Point center of two attributes
plot(iris[,c(1,3)],col=km$cluster)
points(km$centers[,c(1,3)],col=1:3,cex=5)
confusionMatrix(as.numeric(iris[,5]),km$cluster)
library(RSNNS)
? som
inputs <- normalizeData(iris[,1:4], "norm")
model <- som(inputs, mapX=10, mapY=10, maxit=500,
             calculateActMaps=TRUE, targets=iris[,5])
plotActMap(model$labeledMap,col=rev(topo.colors(12)))
par(mfrow=c(1,1))
for(i in 1:ncol(inputs))
  plotActMap(model$componentMaps[[i]],col=rev(topo.colors(12)))

wine.data.url = "https://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data"

wine.data = read.table(url(wine.data.url),sep = ",",dec = ".")

inputs = normalizeData(wine.data[,-1],"norm")

model = som(inputs,mapX = 20,mapY = 20,maxit = 500,calculateActMaps = TRUE,targets = wine.data[,1])

plotActMap(model$labeledMap,col=rev(topo.colors(12)))
