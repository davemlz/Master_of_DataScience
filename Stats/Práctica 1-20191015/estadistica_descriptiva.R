### FUNCIONES ###
#################

#Funciones de estadistica descriptiva en R
############################################

x<-c( 1.11,  1.71, -0.98, -0.83, -0.13,  0.61)

#sumar todos los elementos de a
sum(x)

#buscar el maximo/minimo
max(x)
min(x)

#longitud de a
length(x)

#ordenar
sort(x)

#buscar elementos 
which(x==1.71)
which(x!=1.71)
which(x>0.2)
which(x>0.2 | x==-0.98)
which(x>0.2 & x<1.5)


#media
mean(x)

#mediana
median(x)


#varianza muestral
var(x)

#desviacion tipica muestral
sd(x)

#Recorrido intercuartilico
IQR(x)

#cuartiles
quantile(x)

#percentil (cuantil) p
p<-0.5
quantile(x,p)



#REPRESENTACION GRAFICA#
########################
########################


#Ventanas/dispositivos activos
###############################
###############################



#Activar una nueva ventana:
x11()

#Ver los dispositivos activos e inactivos:
dev.list()


#Para cerrar un dispositivo escribimos:
dev.off()

#o bien si queremos cerrar uno en concreto como por ejemplo el 2:
dev.off(2)


#GRAFICAS BASICAS 
##################


#Diagrama de barras   (Datos cuantitativos discretos y datos cualitativos)
#####################

# > barplot(altura_de_las_barras,etiqueta_para_cada_barra, etiqueta_eje_x, etiqueta_eje_y)


#Ejemplo1: nos dan los datos
datos<-c("A","A","A","A","B","B","B","AB","0","0","0","0","0","0")

#Tenemos que calcular las frecuencias absolutas:
table(datos)

barplot(table(datos),xlab="grupos sanguineos", ylab="frecuencia absoluta")


#Ejemplo2: nos dan las frecuencias absolutas como dato

valores_variable<-c("A","B","AB","0")
frecuencia_absoluta<-c(40,15,5,45)

barplot(frecuencia_absoluta,names.arg=valores_variable,xlab="grupos sanguineos", ylab="frecuencia absoluta")




#Diagrama de sectores (Datos cuantitativos discretos y datos cualitativos)
#####################

# > pie(frecuencia,etiquetas para sectores)

#Ejemplo:

pie(frecuencia_absoluta,labels=valores_variable)





#Histograma  (Datos cuantitativos continuos)
############

# > hist(datos,xlab="etiqueta_eje_x",ylab="etiqueta_eje_y")

#Ejemplo:
datos<-rnorm(100,175,10)

hist(datos,xlab="altura, cm",ylab="frecuencia absoluta")




#Diagrama de cajas  (Comparación de datos continuos)
##################
#
# > boxplot(datos_1,datos_2,ylab="etiqueta_eje_y",names=c("nombre datos 1","nombre datos 2"))
#

#Ejemplo:
A<-c(120.43, 224.19, 203.90, 157.36, 216.45, 196.84, 232.99, 239.55, 190.58, 284.15)
B<-c(290.15, 254.39, 280.03, 277.90, 315.90, 234.90, 305.56, 374.15, 384.64, 335.67)
boxplot(A,B,ylab="y",names=c("A","B"))




#DIAGRAMA DE DISPERSION  (Relacionar dos variables cuantitativas)
#######################

# > plot(x,y,xlab="etiqueta_eje_x", ylab="etiqueta_eje_y", type="p")

#por defecto usa type="p"
#type="b"    Dibuja puntos y lineas

#Ejemplo:
datos_Altura<-rnorm(100,175,10)
datos_Peso<-rnorm(100,70,7)

plot(datos_Peso,datos_Altura,xlab="Peso, kg", ylab="Altura, cm")





#DIAGRAMA DE LINEAS  (Relacionar dos variables cuantitativas)
####################

# > plot(x,y,xlab="etiqueta_eje_x", ylab="etiqueta_eje_y", type="l",lwd=1)


#Ejemplo:

year <- c(1987, 1993, 1997, 2001, 2007)
y_M <- c(7.1, 9.3, 12.0, 12.1, 15.1)

plot(year,y_M,xlab="Year",ylab="Obesity Men, %", type="l",lwd=1.5)







#OPCIONES AVANZADAS PARA GRAFICAS# 
##################################

# ver  ?par
# ver página 69 en R-intro.pdf 

# > plot(x,y,col="color",lty="tipo_de_linea",pch="tipo de punto",main="titulo",cex.main=taman~o_titulo,xlab="etiqueta_eje_x",ylab="etiqueta_eje_y",cex.lab=taman~o_etiquetas)

#Ejemplo:


#Titulo#
########
#
#Se puede utilizar para todas las graficas
#

plot(datos_Peso,datos_Altura,xlab="Peso, kg", ylab="Altura, cm",main="Relación Peso-Altura")

#Color#
#######
plot(datos_Peso,datos_Altura,xlab="Peso, kg", ylab="Altura, cm",col="red")
#o bien
plot(datos_Peso,datos_Altura,xlab="Peso, kg", ylab="Altura, cm",col=2)

plot(datos_Peso,datos_Altura,xlab="Peso, kg", ylab="Altura, cm",main="Relación Peso-Altura",col.main=2)

#Tipo de Punto#
###############

#Cambiamos tipo de punto con la opcion pch
#Hay 26 opciones desde 0 hasta 25
plot(datos_Peso,datos_Altura,xlab="Peso, kg", ylab="Altura, cm",pch=2)
#o bien
plot(datos_Peso,datos_Altura,xlab="Peso, kg", ylab="Altura, cm",pch="x")


#Tipo de Linea#
###############

#cambiar tipo de linea con lty

#Ejemplo:

year <- c(1987, 1993, 1997, 2001, 2007)
y_M <- c(7.1, 9.3, 12.0, 12.1, 15.1)
y_W<- c(8.9, 9.6, 13.1, 13.6, 14.3)

plot(year,y_M,xlab="Year",ylab="Obesity Men, %",type="l",lty=2)


#Tamaños#
##########

#Cambiamos taman~os con el factor multiplicador cex

#Taman~o punto
plot(year,y_M,xlab="Year",ylab="Obesity Men, %",pch=2,cex=4)

#Taman~o titulo
plot(year,y_M,xlab="Year",ylab="Obesity Men, %",main="Obesity in Spain",cex.main=2)

#Taman~o etiquetas ejes
plot(year,y_M,xlab="Year",ylab="Obesity Men, %",cex.lab=1.5)


#Limites de los ejes#
#####################

#xlim = c(limite_inferior_eje_x, limite_superior_eje_x)
#ylim = c(limite_inferior_eje_y, limite_superior_eje_y)

#Ejemplo:
plot(year,y_M,xlab="Year",ylab="Obesity Men, %",type="l",xlim=c(1980, 2010))

plot(year,y_M,xlab="Year",ylab="Obesity Men, %",type="l",ylim=c(0,20))

plot(year,y_M,xlab="Year",ylab="Obesity Men, %",type="l",xlim=c(1980, 2010), ylim=c(0,20))



#Agregar lineas#
################

# > lines(datos_x,datos_y,lty=4)

#Ejemplo:
plot(year,y_M,xlab="Year",ylab="Obesity, %",type="l")

#Agregamos linea

lines(year,y_W,xlab="Year",ylab="Obesity, %",lty=4)



#Agregar Leyenda#
#################

# > legend(posicion_x, posicion_y, tipo de punto, texto)
legend(1987,15,lty=c(1,4),c("Obesity Men","Obesity Women"))

#o bien
legend("topleft",lty=c(1,4),c("Obesity Men","Obesity Women"))






#Agregar puntos#
################

# > points(datos_x,datos_y,pch=3)

#Ejemplo:

plot(year,y_M,xlab="Year",ylab="Obesity, %",pch=2)

#Agregamos puntos con points

points(year,y_W,xlab="Year",ylab="Obesity, %",pch=3)




#Graficas con varios paneles#
#############################

#para hacer una grafica con m*n paneles par(mfrow=c(m,n))

# > par(mfrow=c(m,n))
#Despues ejecutar las m*n graficas

#Ejemplo:

#Grafica 2*1

par(mfrow=c(2,1)) 
plot(year,y_M,xlab="Year",ylab="Obesity Men, %",pch=2)
plot(year,y_W,xlab="Year",ylab="Obesity Women, %",pch=3)

#Margenes exteriores
par(omi=c(0,0,0,0))

#Margenes interiores
par(mai=c(1.02,0.82,0.82,0.42))



#Diagrama de Barras avanzado#
#############################

# > barplot(altura de las barras,etiqueta para cada barra, etiqueta eje y, color, limites eje y, titulo)

#Ejemplo:
#Añadimos color y ampliamos el limite del eje y, y titulo

barplot(frecuencia_absoluta,names.arg=valores_variable,ylab="frecuencia absoluta",col=c(1,2,3,4),ylim=c(0,50),main="Frecuencia Grupos Sanguineos")



#Diagrama de Sectores avanzado#
###############################

# > pie(frecuencia,etiquetas para sectores,colores)

#Ejemplo:
#Añadimos color y titulo

pie(frecuencia_absoluta,labels=valores_variable,col=c(1,2,3,4),main="Frecuencia Grupos Sanguineos")





#Histograma avanzado#
#####################


#Ejemplo:
#Añadimos color y titulo, ampliamos limites de los ejes

hist(datos_Altura,xlab="altura, cm",ylab="frecuencia absoluta",main="Alturas de 55 Mujeres",col="green",xlim=c(140,190),ylim=c(0,20))




#Diagrama de puntos para comparar muestras
###########################################
A<-c(120.43, 224.19, 203.90, 157.36, 216.45, 196.84, 232.99, 239.55, 190.58, 284.15)
B<-c(290.15, 254.39, 280.03, 277.90, 315.90, 234.90, 305.56, 374.15, 384.64, 335.67)

plot(1:2,c(mean(A),mean(B)) ,xlab="",ylab="Altura, cm" ,xlim=c(0,3),ylim=c(0,400), xaxt='n',bty="n", type='b',col="red",lwd=1.2)
stripchart(A,vertical=T, method = 'jitter', jitter = 0.1, cex = 0.8,pch = 16, col = "darkgrey",add=T,at=1)
stripchart(B,vertical=T, method = 'jitter', jitter = 0.1, cex = 0.8,pch = 16, col = "darkgrey",add=T,at=2)
axis(1, at=1:2, labels=c("A","B"),line=2.4)



#Region de confianza sombreada#
###############################

x <- 1:10
y.low <- c(120.43, 224.19, 203.90, 157.36, 216.45, 196.84, 232.99, 239.55, 190.58, 284.15)
y.high <- c(290.15, 254.39, 280.03, 277.90, 315.90, 234.90, 305.56, 374.15, 384.64, 335.67)

plot(x,y.high,type = 'n', ylim = c(100, 400), ylab = "Y", xlab = "X")
lines(x, y.low, col = "black")
lines(x, y.high, col = "black")

polygon(c(x, rev(x)), c(y.high, rev(y.low)), col = "grey80", border = NA)






#GUARDAR FIGURA EN UN ARCHIVO
##############################

#ES UN PROCESO QUE CONSTA DE 3 PASOS 
#HAY QUE HAY QUE EJECUTAR CADA UNO DE ELLOS IMPRESCINDIBLEMENTE


#PASO 1

#Primero seleccionamos el nombre del archivo en el que queremos guardar la figura.
#El dispositivo activo pasa a ser el archivo

pdf("nombre_del_archivo") 

#Ejemplo:

pdf(filename="ejemplo.pdf")         



#PASO 2

#Volvemos a generar la grafica que queremos guardar
#Como el dispositivo activo es el archivo, no vemos la grafica pero es enviada al archivo

#Ejemplo

hist(datos_Altura,xlab="altura, cm",ylab="frecuencia absoluta",main="Alturas de 55 Mujeres",col="green",xlim=c(140,190),ylim=c(0,20))


#PASO 3

#Escribimos dev.off() hasta ver el mensaje "null device"
#De esta forma desactivamos el archivo como dispositivo y finaliza el proceso correctamente

dev.off()



