# GENERACION DE NUMEROS ALEATORIOS CON R
#########################################


#Generacion de numeros aleatorios uniformes
###########################################

#runif(n) 
#genera n numeros aleatorios entre 0 y 1

runif(10)

#runif(n,min, max)
#genera n numeros aleatorios entre min y max

#Ejemplo: 18 numeros aleatorios uniformes entre 0 y 10
runif(18,0,10)



#Generacion de numeros aleatorios binomiales
############################################
#rbinom(n, size, p)
#genera n numeros aleatorios de una binomial con parametros n, p

#Ejemplo:
rbinom(5,10,0.2)



#Generacion de numeros aleatorios de poisson
#############################################

#Poisson: p(x) = lambda^x exp(-lambda)/x!


#rpois(n, lambda)
#genera n numeros aleatorios de poisson con media lambda

#Ejemplo:
rpois(20, 2.5)




#Generacion de numeros aleatorios normales
############################################

#normal:   f(x) = 1/(sqrt(2 pi) sigma) e^-((x - mu)^2/(2 sigma^2))

#rnorm(n)
#genera n numeros aleatorios normales de media 0 y desviacion tipica 1

#rnorm(n,mu,sigma)
#genera n numeros aleatorios normales de media = mu  y desviacion tipica = sigma

rnorm(30,1.75,0.2)





# MUESTREO ALEATORIO SIMPLE 
############################


#Sin reposicion
#################

# > sample(x)


#Ejemplo: Extraer 3 números al azar entre 0 y 10.

x<-0:10
n<-3
sample(x,n)


#Con reposicion
################

# > sample(x,replace=TRUE)

#Ejemplo: Extraer 68 números al azar entre 0 y 10.

x<-0:10
n<-68
sample(x,n,replace=TRUE)

