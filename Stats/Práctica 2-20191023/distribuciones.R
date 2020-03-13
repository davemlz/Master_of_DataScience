

#DISTRIBUCIONES DE PROBABILIDAD
################################
################################
################################



#DISTRIBUCION UNIFORME CONTINUA
###############################
###############################

#Funcion de distribucion P(Variable <= x) en el intervalo [a,b]
###############################################################
#F(x) = (x-a)/(b-a)

# > punif(x,a,b)



#Función de densidad f(x) en el intervalo [a,b] 
###############################################
#f(x) = 1/(b-a)

# > dunif(x,a,b)

#Nota: NO ES UNA PROBABILIDAD

#Ejemplo: Un tren tiene la llegada programada en los próximos 5 minutos. Cual es la probabilidad de que esperemos 3 minutos o menos?

punif(3,0,5)




#DISTRIBUCION BINOMIAL
######################
######################



#Función de Probabilidad: P(Variable=x) con probabilidad p y tamaño muestal n:
###############################################################################
# p(x) = choose(n,x) p^x (1-p)^(n-x)

# > dbinom(x, n, p)



#Función de distribución: Probabilidad acumulada P(Variable <= x) con probabilidad p y tamaño muestal n: 
########################################################################################################


# > pbinom(x, n, p)





#Ejemplo:
#Lanzamos 5 veces una moneda. ¿Probabilidad de sacar 4 caras?

x<-4
n<-5
p<-0.5

dbinom(x,n,p)

#Lanzamos 5 veces una moneda. ¿Probabilidad de sacar 4 caras o menos?

pbinom(x,n,p)







#DISTRIBUCION DE POISSON
########################
########################


#Funcion de probabilidad P(Variable=x) con media lambda 
########################################################

#Poisson: p(x) = lambda^x exp(-lambda)/x!

# > dpois(x,lambda)


#Funcion de distribucion P(Variable <= x) con media lambda :
#############################################################

# > ppois(x,lambda)


#Ejemplo: El número medio de accidentes por año un una carretera es 3. ¿Probabilidad de que haya 7 el próximo año?

lambda<-3
x<-7
dpois(x,lambda)

# ¿Probabilidad de que haya 7 o menos el próximo año?
ppois(x,lambda)






#DISTRIBUCION NORMAL
####################
####################


#Funcion de distribucion P(Variable <= x) con media = mu y desviacion tipica = sigma :
######################################################################################

# > pnorm(x,mu,sigma)


#Función de densidad f(x) con media = mu y desviacion tipica = sigma 
#####################################################################
#f(x) = 1/(sqrt(2 pi) sigma) e^-((x - mu)^2/(2 sigma^2))

# > dnorm(x,mu,sigma)

#Nota: NO ES UNA PROBABILIDAD



#Ejemplo: En una población la altura media es 1.75m  y la desviación típica 0.1m
#¿Probabilidad de que una persona de la población mida menos de 1.60m?

x<-1.60
mu<-1.75
sigma<-0.1

pnorm(1.60,1.75,0.1)

#¿Probabilidad de que una persona de la población mida más de 2.20m?

1-pnorm(2.2,1.75,0.1)



# PERCENTILES DE LA DISTRIBUCION NORMAL
######################################
# Percentil x(p) es un numero tal que P[Variable <= x(p)]= p

# Percentil p de la normal de media mu y desviacion tipica sigma:
# qnorm(p,mu,sigma)

#Ejemplo: En una población la altura media es 1.75m  y la desviación típica 0.1m
#Calcula la altura por debajo de la cual se encuentra el 5% de la población.

p<-0.05
mu<-1.75
sigma<-0.1

qnorm(p,mu,sigma)



