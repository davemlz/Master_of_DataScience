Biuse Casaponsa
casaponsa@ifca.unican.es

Material de la clase:
shorturl.at/eizJV
https://drive.google.com/open?id=1xlBW3LkNADHIbI-xPOdoN_FSuKGpGSk_

* SepComponentes.pdf  # teoria
* SepComponentes.m4v  # video con presenación
* CompSepLab2020_Exercice.ipynb  # notebook ejercicio, con algunos ejemplos de leer mapas
* Tenéis también los data sets para entrenar la red
                                PLANCK_Signal_dataset.txt
                                PLANCK_Singal_labels.txt
                                PLANCK+HASLAM_Signal_dataset.txt
                                PLANCK+HASLAM_Signal_labels.txt

* En Datos/ hay los datos simulados para testear vuestros modelos 
                                DataPLANCK.fits    # haceis predicciones con esto
                                ParamsPLANCK.fits  # True params, comparáis vuestras predicciones con esto
                                DataPLANCK+HASLAM.fits    # haceis predicciones con esto
                                ParamsPLANCK+HASLAM.fits  # True params, comparáis vuestras predicciones con esto


Motivación: 
-------------------------

-  El fondo cósmico de microondas está compuesto de los fotones (de la luz) más lejanos que podemos detectar y
nos da mucha información sobre como es nuestro Universo. Nos proporcionan una foto del Universo cuando éste acababa de empezar
300,000 años, pensad que ahora nuestro Universo tiene unos 14,000,000,000 años. Es una radiación muy interesante y de la que se extrae la información más
importante hasta la fecha para entender nuestro Universo: edad, cantidad de materia, cantidad energía oscuar, velocidad de expansión... 

El problem es que como estamos dentro de nuestra galaxia, y hay procesos que emiten en microondas, al poner un detector tengo la suma
de distintas señales. Y quiero separarlas. Aplicaré algun método de separación de componentes, para estudiar por un lado la galaxia y por otro esta señal que nos llega del pasado 

Es un tema muy interesante, en el que se pone mucho esfuerzo, aquí os propongo resolverlo, en un caso simplificado, (con menos comoponentes de las que en realidad hay y más simples).

Práctica: 
------------------
Data sets --> señal, parametros que caracterizan las distintas componentes
 
 -Tenéis 2: s eñal :  con PLANCK (9 frecuancias) y PLANCK+HASLAM (10 frecuencias)   y  labels: 4 parametros que caracterizan 3 componentes. 

 - Y luego teneís un kaggle de challenge donde he añadido 4 frecuencias más (cuantas más frecuencias más datos y mejor separación) 
   https://www.kaggle.com/c/component-separation-with-nn

