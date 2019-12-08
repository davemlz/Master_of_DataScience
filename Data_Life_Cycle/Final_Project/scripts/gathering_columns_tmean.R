# PAQUETE PARA MANEJO DE DATOS
require(tidyr)

# DIRECTORIO ACTUAL DE TRABAJO
wd = getwd()

# PATH DE LOS DATOS
data_path = file.path(wd,"Data_Life_Cycle/Final_Project/data")

# FILE NAME
data_name = "tmean.csv"
path_file = file.path(data_path,data_name)

# NEW FILE NAME
new_data = "tmean_gathered.csv"
new_path_file = file.path(data_path,new_data)

# LEER DATOS EN UN DATA FRAME CON ENCODING UTF-8 (LEE LAS TILDES)
# LOS DATOS DE TEMPERATURA ESTAN REPARTIDOS EN COLUMNAS
# EL FORMATO DEL NOMBRE DE ESTAS COLUMNAS ES "'MOD'-AÑO-SEMESTRE"
df = read.csv(path,fileEncoding = "utf-8")

# CAMBIAR COLUMNAS DE TEMPERATURA A FILAS EN DOS COLUMNAS
# SE ELIGEN LAS COLUMNAS QUE COMIENCEN CON "MOD"
# LA PRIMERA COLUMNA SE LLAMA "SEMESTRE"
# SE ELIMINA EL PREFIJO "MOD" DE LOS DATOS DE LA NUEVA FILA
# EL NOMBRE DE LA NUEVA COLUMNA PARA LA TEMPERATURA ES "TMEAN"
df = pivot_longer(data = df,
                  cols = starts_with("MOD"),
                  names_to = "SEMESTRE",
                  names_prefix = "MOD",
                  values_to = "TMEAN")

# GUARDAR NUEVO DATA FRAME CON ENCODING UTF-8
write.table(df,new_path_file,sep = ",",row.names = FALSE,fileEncoding = "utf-8")