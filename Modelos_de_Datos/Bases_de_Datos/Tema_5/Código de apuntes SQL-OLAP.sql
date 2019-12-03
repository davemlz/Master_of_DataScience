---------------------------------------------------------------------------------------------------------
-- Consultas en los apuntes del tema OLAP: funciones ventana
-- 
-- Máster en Data Science 
-- M1967 - Modelos de Datos y Sistemas de Información 2018-2019
-- DIego García Saiz
-----------------------------------------------------------------------------------------------------------

-- *NOTA: LOS RESULTADOS DE EJECUCIÓN DE LAS SIGUIENTES CONSULTAS PUEDEN DAR RESULTADOS UN POCO DIFERENTES A LOS MOSTRADOS EN LAS SLIDES

-- Slide 106
select fdim.anio,
    sum(vh.beneficio) beneficioAnio
    from fechadim fdim inner join ventasHechos vh on fdim.idfecha = vh.idfecha
    group by (fdim.anio);


select fdim.anio, vh.idproducto, vh.idusuario, beneficio,
    sum(vh.beneficio) over (partition by fdim.anio) as beneficioAnio
    from fechadim fdim inner join ventasHechos vh on fdim.idfecha = vh.idfecha;
    



-- Slide 107
SELECT  idventa,  beneficio,
rank()  over  (order  by  beneficio  desc)  as  rank,  
dense_rank()  over  (order  by  beneficio  desc)  as  dense_rank, 
cume_dist()  over  (order  by  beneficio  desc)  as  cume_dist FROM  ventasHechos
ORDER  BY  beneficio  desc;



-- Slide 108
SELECT  idventa,  categoria,  beneficio,
rank()  over  (partition  by  categoria  order  by  beneficio  desc)  as  rank,  
dense_rank()  over  (partition  by  categoria  order  by  beneficio  desc)  as  dense_rank, 
cume_dist()  over  (partition  by  categoria  order  by  beneficio  desc)  as  cume_dist 
FROM  ventasHechos  vh  INNER  JOIN  productoDIM  pd  on  vh.idproducto  =  pd.idproducto
ORDER  BY  categoria,  beneficio  desc;



-- Slide 109
SELECT  fdim.anio,  vh.idproducto,  vh.idusuario,  beneficio,  sum(vh.beneficio)  OVER  (PARTITION  BY  fdim.anio)  as  sumaPorAnio, avg(vh.beneficio)  OVER  (PARTITION  BY  fdim.anio)  as  mediaPorAnio, count(*)  OVER  (PARTITION  BY  fdim.anio)  as  transaccionesPorAnio, max(vh.beneficio)  OVER  (PARTITION  BY  fdim.anio)  as  maxPorAnio, min(vh.beneficio)  OVER  (PARTITION  BY  fdim.anio)  as  minPorAnio
FROM  fechaDim  fdim  INNER  JOIN  ventasHechos  vh  ON  fdim.idfecha  =  vh.idfecha;



-- SLide 110
SELECT  fdim.anio,  pd.categoria,  ud.regionUsuario,  vh.idproducto,  vh.idusuario,  beneficio, avg(vh.beneficio)  OVER  (PARTITION  BY  fdim.anio)  as  mediaPorAnio,
avg(vh.beneficio)  OVER  (PARTITION  BY  pd.categoria)  as  mediaPorCat, avg(vh.beneficio)  OVER  (PARTITION  BY  ud.regionUsuario)  as  mediaPorEst
FROM  fechaDim  fdim  INNER  JOIN  ventasHechos  vh  ON  fdim.idfecha  =  vh.idfecha INNER  JOIN  productoDim  pd  ON  pd.idproducto=vh.idproducto
INNER  JOIN  usuarioDim  ud  ON  ud.idusuario=vh.idusuario;



-- Slide 111
SELECT  fdim.anio,  pdim.categoria,  sum(vh.beneficio)  as  beneficioAnioCategoria, sum(sum(vh.beneficio))  OVER  (PARTITION  BY  pdim.categoria  ORDER  BY  fdim.anio)  as sumaPorAnio
FROM  fechaDim  fdim  INNER  JOIN  ventasHechos  vh  ON  fdim.idfecha  =  vh.idfecha INNER  JOIN  productoDim  pdim  ON  pdim.idproducto  =  vh.idproducto
GROUP  BY  fdim.anio,  pdim.categoria;



-- Slide 112
SELECT  fdim.anio,  pdim.categoria,  sum(vh.beneficio)  as  beneficioAnioCat,
sum(sum(vh.beneficio))  OVER  (PARTITION  BY  pdim.categoria  ORDER  BY  fdim.anio)  as  sumaPorAnio, avg(sum(vh.beneficio))  OVER  (PARTITION  BY  pdim.categoria  ORDER  BY  fdim.anio)  as  avgPorAnio, max(sum(vh.beneficio))  OVER  (PARTITION  BY  pdim.categoria  ORDER  BY  fdim.anio)  as  maxPorAnio FROM  fechaDim  fdim  INNER  JOIN  ventasHechos  vh  ON  fdim.idfecha  =  vh.idfecha
INNER  JOIN  productoDim  pdim  ON  pdim.idproducto  =  vh.idproducto
GROUP  BY  fdim.anio,  pdim.categoria;



-- Slide 113
SELECT  fdim.anio,  sum(vh.beneficio)  as  beneficioAnio, rank()  OVER  (ORDER  BY  sum(vh.beneficio))  as  rank
FROM  fechaDim  fdim  INNER  JOIN  ventasHechos  vh  ON  fdim.idfecha
=  vh.idfecha
GROUP  BY  fdim.anio
ORDER  BY  rank;


-- Slide 114
select vh.idventa, beneficio,
    avg(beneficio) over (order by vh.idventa rows between 1 preceding and 1 following) as mediaAntPso
    from ventasHechos vh
    order by vh.idventa;



-- Slide 115
select vh.idventa, beneficio,
    avg(beneficio) over (order by vh.idventa rows between 1 preceding and 0 following) as mediaAnt
    from ventasHechos vh
    order by vh.idventa;



-- Slide 116
select vh.idventa, beneficio,
    avg(beneficio) over (order by vh.idventa rows between 0 preceding and 2 following) as mediaAnt
    from ventasHechos vh
    order by vh.idventa;
    


-- Slide 117
select vh.idventa, beneficio,
    avg(beneficio) over (order by vh.idventa rows between 0 preceding and 2 following) as mediaAnt
    from ventasHechos vh
    order by vh.idventa;



-- Slide 118
SELECT  vh.idproducto,	sum(beneficio)  as  beneficioPorProd,
avg(sum(vh.beneficio))  OVER  (ORDER  BY  idproducto  rows between 0 preceding and 2 following)  as mediaConAnt
FROM  fechaDim  fdim  INNER  JOIN  ventasHechos  vh  ON  fdim.idfecha  =  vh.idfecha
GROUP  BY  vh.idproducto ORDER  BY  idproducto;



-- Slide 119
SELECT  vh.idproducto,    sum(beneficio)  as  beneficioPorProd,
avg(sum(vh.beneficio))  OVER  (ORDER  BY  idproducto  ROWS  BETWEEN  1  PRECEDING  AND  0  FOLLOWING)  as  mediaConAnt, avg(sum(vh.beneficio))  OVER  (ORDER  BY  idproducto  ROWS  BETWEEN  0  PRECEDING  AND  1  FOLLOWING)  as  mediaConPos, avg(sum(vh.beneficio))  OVER  (ORDER  BY  idproducto  ROWS  BETWEEN  2  PRECEDING  AND  2  FOLLOWING)  as
mediaCon2Ant2Pos, sum(sum(vh.beneficio))  OVER  (ORDER  BY  idproducto  ROWS  BETWEEN  9  PRECEDING  AND  0  FOLLOWING)  as  sumaAcumulada FROM  fechaDim  fdim  INNER  JOIN  ventasHechos  vh  ON  fdim.idfecha  =  vh.idfecha
GROUP  BY  vh.idproducto ORDER  BY  idproducto;
