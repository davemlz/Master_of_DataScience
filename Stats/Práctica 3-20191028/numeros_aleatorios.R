#GENERACION DE NUMEROS ALEATORIOS UNIFORMES:
############################################
#Generador Congruencial Lineal
###############################

# r_i+1 = (a*r_i + b) mod m

#Ejemplo:
#########
a<-5  #multiplicador
m<-37 #modulo 
b<-0  #incremento
r0<-1 #semilla

#Inicializamos vector de numeros aleatorios
num_aleatorios<-rep(0,m)

#Semilla en posicion 1
num_aleatorios[1]<-r0

#Numero de puntos a representar, N
#Generamos la secuencia entera
N<-m
for( i in 2:N){

num_aleatorios[i]<-(a*num_aleatorios[i-1]+b) %% m

}
num_aleatorios  #Numeros aleatorios posibles 0,1, ... m-1
num_aleatorios/m  #Numeros aleatorios estandarizados aleatorios en (0,1)

#Grafica de los pares (r_i, r_i+1): Efecto Marsaglia
####################################################
plot(num_aleatorios[1:N-1]/m,num_aleatorios[2:N]/m)



# Ejemplo 2 Generador Congruencial Lineal MALO
##############################################

a<-781
m<-1000
b<-387
r0<-1

N<-500

num_aleatorios<-rep(0,N)
num_aleatorios[1]<-r0

for( i in 2:N){

num_aleatorios[i]<-(a*num_aleatorios[i-1]+b) %% m

}
num_aleatorios
num_aleatorios/m

plot(num_aleatorios[1:N-1]/m,num_aleatorios[2:N]/m,pch="x",cex=0.5)



# Ejemplo 3 Generador Congruencial Lineal BUENO
################################################

a<-16807
m<-2^31-1
b<-0
r0<-1

N<-500

num_aleatorios<-rep(0,N)
num_aleatorios[1]<-r0

for( i in 2:N){

num_aleatorios[i]<-(a*num_aleatorios[i-1]+b) %% m

}
num_aleatorios
num_aleatorios/m
x11()
plot(num_aleatorios[1:N-1]/m,num_aleatorios[2:N]/m,pch="x",cex=0.5)





#Generacion de numeros aleatorios uniformes con R
#################################################

#runif(n) 
#genera n numeros aleatorios entre 0 y 1

runif(10)

#runif(n,min, max)
#genera n numeros aleatorios entre min y max

#Ejemplo: 18 numeros aleatorios uniformes entre 0 y 10
runif(18,0,10)

#Ejemplo Generador Mersenne-Twister en R:
##########################################

numeros_R<-runif(N)
plot(numeros_R[1:N-1],numeros_R[2:N])


#Seleccion de la semilla
###########################

# > set.seed(semilla)

#Ejemplo:

runif(10)
runif(10)

set.seed(-1214438024)
runif(10)

set.seed(-1214438024)
runif(10)

