bat = read.table("TFM/bathymetric_data",fill = TRUE,skip = 7,dec = ",")[,1:6]

colnames(bat) = c("Fecha","Hora","Longitud","Latitud","Ping","Profundidad")

plot(bat$Longitud,bat$Latitud,pch = ".")
