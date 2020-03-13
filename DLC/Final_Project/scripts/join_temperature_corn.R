# PAQUETE PARA MANEJO DE DATOS
require(tidyr)
require(dplyr)

# DIRECTORIO ACTUAL DE TRABAJO
wd = getwd()

# PATH DE LOS DATOS
data_path = file.path(wd,"Data_Life_Cycle/Final_Project/data")

# FILE NAME
temperature_file = "tmean_gathered.csv"
path_temperature = file.path(data_path,temperature_file)

# NEW FILE NAME
maiz_file = "Cadena_Productiva_Maiz_-_Area__Produccion_Y_Rendimiento.csv"
path_maiz = file.path(data_path,maiz_file)

# LEER DATOS
df_t = read.csv(path_temperature,fileEncoding = "utf-8")
df_m = read.csv(path_maiz,fileEncoding = "utf-8")

# CREAR PRIMARY KEY CON EL CODIGO DEL MUNICIPIO Y EL PERIODO
df_t$PK = paste0(df_t$DPTOMPIO,df_t$SEMESTRE)
df_m$PK = paste0(df_m$CÓD..MUN.,df_m$PERIODO)

# HACER UN JOIN
df = inner_join(df_t,df_m,by = "PK")

# ELIMINAR DATOS DE PRODUCCION IGUALES A CERO
df = df[df$Producción.t. != 0,]

# HACER PROMEDIO DE LOS DATOS DE INTERES
df = df %>% group_by(COD_DPTO) %>% summarise(rto = sum(Rendimiento.t.ha.),
                                       prod = sum(Producción.t.),
                                       tm = sum(TMEAN),
                                       area = length(AREA_HA))

# HACER PROMEDIO DE LOS DATOS DE INTERES
df2 = df %>% group_by(COD_DPTO) %>% summarise(rto = mean(Rendimiento.t.ha.),
                                             prod = mean(Producción.t.),
                                             tm = mean(TMEAN,na.rm = TRUE))


require(ggplot2)

ggplot(df2,aes(x = tm,y = rto)) + geom_point()

model = lm(prod ~ poly(tm,3,raw = TRUE),df2)
model = lm(prod ~ exp(tm),df2)
summary(model)
co = model$coefficients
plot(df2$tm,df2$prod)
curve(co[1] + co[2]*x + co[3]*x^2 + co[4]*x^3,col = "red",xlim = c(0,30),add = TRUE)
