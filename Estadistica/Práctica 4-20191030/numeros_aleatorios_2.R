#Generacion de numeros aleatorios siguiendo una distribucion dada
##################################################################
##################################################################

#Metodo de la funcion de distribucion inversa 
#############################################

# X = F^{-1} (U) sigue distribución F(x)
# siendo U ~ U[0,1] y F^{-1}(u) = inf{x | F(x) >= u}

#Ejemplo:

#Generar numeros distribuidos con f(x)=sin(x) entre 0 y pi/2

#Dibujamos f(x):
curve(sin(x),0,pi/2)

#Calculamos F(x)= 0 para x<0; F(x)= 1-cos(x) para 0<= x <= pi/2; F(x)= 1 para x> pi/2 

#Calculamos la inversa:
#F^{-1}(u)= acos(1-u) 

#Simulamos:
x<-acos(1-runif(1000000))

#Dibujamos histograma y funcion densidad:
hist(x,breaks=seq(0,pi/2,length=20),freq=F)
curve(sin(x),0,pi/2,add=T,col=2)

####################################################################################################



#Metodo del rechazo
###################

#Generamos M números uniformes (x_i,y_i) i=1,2,...,M  en un recinto que contenga a f(x). Aceptamos si y_i < f(x_i) => Las x_i de los N números aceptados se distribuyen con función densidad f(x).

#Ejemplo:

#Generar numeros distribuidos con f(x)=1-|1-x| con 0 <= x <= 2

#Dibujamos f(x):
curve(1-abs(1-x),0,2)

#Simulamos en el recinto 0<= x <= 2, 0 <= y <=1

M<-1000

X <- runif(M, 0, 2)
Y <- runif(M)

#Dibujamos los puntos simulados (Usar pocos puntos sino ignorar)
plot(X,Y) 
#Superponemos f(x)
curve(1-abs(1-x),0,2, add=T)

#Aceptamos si y_i < f(x_i):
X_aceptados <- X[which(Y < (1 - abs(1 - X)))]
Y_aceptados <- Y[which(Y < (1 - abs(1 - X)))]

#Dibujamos los puntos aceptados (Usar pocos puntos sino ignorar)
plot(X_aceptados,Y_aceptados)
#Superponemos f(x)
curve(1-abs(1-x),0,2, add=T)

#Dibujamos histograma y funcion densidad:
hist(X_aceptados,20,freq=F)
curve(1-abs(1-x),0,2, add=T)


####################################################################################################



#Generacion de numeros aleatorios normales: Método Box-Müller
#############################################################

#Si generamos dos números normales  Z1, Z2:


Z1<-rnorm(100000)
Z2<-rnorm(100000)

plot(Z1,Z2) #Usar pocos puntos sino ignorar

#Veamos la distribucion del angulo del vector que une con el origen:

bines<-seq(-pi/2,pi/2,length=100)
hist(atan(Z2/Z1),bines)

#Veamos la distribucion del modulo del vector:
hist(Z1^2+Z2^2,200,freq=F)
curve(dexp(x,1/2),0,20,add=T,col=2)


#Utilizando estas propiedades podemos recorrer el camino inverso:
#Generamos un número uniforme y otro exponencial y los combinamos para obtener dos números normales:

U1<-runif(100000)
U2<-runif(100000)

Z1 <- sqrt(-2*log(U1)) * cos(2*pi*U2) 
Z2 <- sqrt(-2*log(U1)) * sin(2*pi*U2) 

hist(Z1,200,freq=F)
curve(dnorm(x),-4,4,add=T,col=2)

hist(Z2,200,freq=F)
curve(dnorm(x),-4,4,add=T,col=2) 

