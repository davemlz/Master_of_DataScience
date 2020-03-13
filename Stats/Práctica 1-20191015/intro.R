#INTRODUCCION a R#
##################

# Este archivo es un archivo de texto con comandos, llamado SCRIPT
###################################################################
#
# Las lineas que comienzan con "#" son comentarios
# El script completo se ejecuta desde la linea de comandos con 
#
# > source("archivo_script.R") 
# > source("archivo_script.R",echo=TRUE)
#
#
#Para consultar la ayuda de "funcion": ?funcion
#Para buscar funcion asociada a palabra clave: apropos("palabra clave")
#

# R Como Calculadora
#######################

#Suma, resta, multiplicacion, division y potenciacion

2+2

3-1

2*4

7/8

2^3

# raiz cuadrada, logaritmo, exponenciacion, seno, coseno, tangente

sqrt(2)

log(3)

exp(1)

sin(pi/2)

cos(pi/3)

tan(pi/4)

### TIPOS DE DATOS EN R ###
###########################
###########################


###  VARIABLES 
###############

# Tipos de Variable
######################

#Numerico

x<-3.914


#Caracter

nombre <- "Pedro"

#Logico

ejes <- TRUE
ejes <- FALSE


#Definir variable
#################

k<-1

#Nombres largos y tabulador
nombre_largo <- 45


### VECTORES
#############

#Definir vector
###############

#funcion concatenar:
#c() 

a<-c(2,4,5,1,2,10)

nombres <-c("Maria", "Pedro", "Alberto")

#Extraer elementos de un vector

a[3]
nombres[3]
a[c(1,4)]

#Definir vector en forma de secuencia
######################################

x<- 1:10
xx<- seq(1,10,0.1)

#Definir un vector con elementos repetidos
###########################################

x<-rep(3,7)


#Operaciones con vectores
##########################
a^2
2+k*a
1/a
sqrt(a)

b<-c(9,3,4,1,5,2)

a*b
a/b

#concatenar vectores
#####################
ab<-c(a,b)



### MATRICES ###
################

#Definir matriz
###############

# > matrix(data, nrow, ncol, byrow=F)


#data 	datos que forman la matriz 
#nrow 	número de filas de la matriz
#ncol 	número de columnas de la matriz
#byrow 	Los datos se colocan por filas o por columnas según se van leyendo. Por defecto se colocan por columnas.


#Ejemplo:
m<-matrix(c(2,8,5,4,6,2),nrow=3,ncol=2,byrow=TRUE)

#Extraer un elemento de una matriz
m[1,2]

#Extraer una columna de una matriz
m[,1]

#Extraer una fila de una matriz
m[2,]

#Extraer varios elementos de una matriz
m[2,1:2]


#Definir matriz a partir de vectores
####################################

a<-c(2,4,5,1,2,10)
b<-c(9,3,4,1,5,2)

m1<-rbind(a,b)
m2<-cbind(a,b) 

#Operaciones con matrices
##########################

#multiplicacion matricial
m%*%m1

#elemento a elemento
m1*t(m2)


#TABLAS#
########

# Generar Tabla a partir de un vector
# > table(vector)

#Ejemplo:

colores<-c("Azul","Azul","Rojo","Azul","Rojo","Azul")

table(colores)


# Generar Tabla a partir de dos vectores
# > table(vector1,vector2)

#Ejemplo:

colores<-c("Azul","Azul","Rojo","Azul","Rojo","Azul")
defectos <-c("No", "Si", "Si", "Si", "No", "Si")
table(defectos,colores)


### DATA FRAME ###
##################

Altura<-c(175,192,168,155,164,179)
Peso<-c(77,100,78,60,72,88)
Sexo<-c("M","V","V","M","M","V")

datos<-data.frame(Altura,Peso,Sexo)

#Visualizar Columnas
datos$Altura
datos$Peso
datos$Sexo

#Seleccionar datos
with(datos, Altura<170)
with(datos, Altura[Altura<170])


### MISSING VALUES ###
######################

x<-c(1,6,9,2,NA)
is.na(x)
!is.na(x)
y<-x[!is.na(x)]




### LECTURA Y ESCRITURA DE DATOS EN FORMATO ASCII Y CSV ###
###########################################################

#Guardar datos en un archivo
############################

# > write(nombre_vector,file="nombre_archivo.dat",ncolumns=1)

#Ejemplo:

write(b,file="b.dat",ncolumns=1)

write(m1,file="m1.dat",ncolumns=2)

write.table(datos,"datos.dat")

write.csv(datos,"datos.csv")

#Leer datos de un archivo
#########################

# > nombre_vector <- scan("nombre_archivo.dat")

#Ejemplo:
b_copy <- scan("b.dat")

m1_copy <- matrix(scan("m1.dat"),nrow=2,ncol=6,byrow=FALSE)

datos_copy <- read.table("datos.dat",header=TRUE)

datos_csv<- read.csv("datos.csv")


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

#Recorrido intercuartílico
IQR(x)

#cuartiles
quantile(x)

#percentil (cuantil) p
p<-0.5
quantile(x,p)







#DEFINIR NUESTRAS PROPIAS FUNCIONES
###################################

# > name <- function(arg_1, arg_2, ...) expression

#Ejemplo

suma <- function(a, b){
 a+b 
}
suma(2,5)


#CARGAR FUNCIONES
##################
# > source("archivo_funcion.R")

#Ejemplo

source("skewness.R")
source("kurtosis.R")

skewness(x)
kurtosis(x)



### PROGRAMAR ###
#################

#for (counter in vector) {commands}

#Ejemplo:

cuadrados<-rep(0,50)

for (i in 1:50 ) {
cuadrados[i]<-i^2
}


