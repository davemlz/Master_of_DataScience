#TEST DE HIPOTESIS CON VALOR DE REFERENCIA#
###########################################
###########################################


#Test de hipotesis sobre una media de una población normal#
###########################################################

#t.test(datos, mu = media_hipotesis_nula)


#Hipotesis alternativa bilateral  mu! = mu_0
############################################

#1) Definimos hipótesis y elegimos alpha=0.05

#H_0: mu=181
#H_1 mu distinto de 181 

#2) Calculamos valor-p:

altura = rnorm(20,181,7)

t.test(altura, mu=183.8)

#3) Comparamos alpha y valor-p

#p-value = 0.088 > alpha => NO rechazamos H_0


#Hipotesis alternativa unilateral (caso 1)  mu > mu_0
#####################################################


#1) Definimos hipótesis y elegimos alpha=0.05

#H_0: mu=181
#H_1 mu > 181 


#2) Calculamos valor-p:

t.test(altura, mu=181, alternative="greater")

#3) Comparamos alpha y valor-p

#p-value = 0.9561 > alpha => NO rechazamos H_0


#Hipotesis alternativa unilateral (caso 2) mu < mu_0
#####################################################


#1) Definimos hipótesis y elegimos alpha=0.05

#H_0: mu=181
#H_1 mu < 181 

#2) Calculamos valor-p:

t.test(altura, mu=181, alternative="less")

#3) Comparamos alpha y valor-p

#p-value = 0.04392 < alpha => Rechazamos H_0




#COMPARACION DE MEDIAS ENTRE DOS GRUPOS#
########################################

#usamos estos datos como ejemplo en los siguientes comandos:
A<-c(145,149,130,162,165,160,141)
B<-c(133,144,140,150,143,146,138)


#COMPARACION DE MEDIAS  (TEST DE WELCH)

#H_0: medias iguales
#H_1: medias diferentes

t.test(A,B)


#COMPARACION DE MEDIAS PARA DATOS EMPAREJADOS

#H_0: medias iguales
#H_1: medias diferentes

t.test(A,B,paired=TRUE)



