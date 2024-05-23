
# GEIH 2023 ---------------------------------------------------------------


# Caracteristicas generales -----------------------------------------------

install.packages('data.table')
library(data.table)

setwd('C:/Users/Julian/Desktop/Ciencia de datos/GEIH/GEIH 2023')
l_file <- list.files(recursive = T,full.names = T)

# Nombre del archivo
file1 <- "Características generales, seguridad social en salud y educación.CSV"

# Filtrar los elementos que contienen el nombre deseado

grep(file1,l_file) #Busca el patrón que le pida
length(grep(file1,l_file)) #Valido que sean 12 archivos

files <- l_file[grep(file1,l_file)] #Archivos area

lista_df <- list()

meses <- list.files(full.names = F)[-3]

for (i in meses) {
  #Construimos ruta del archivo caracteristigas generales
  ruta_archivo <- file.path(i, "CSV", "Características generales, seguridad social en salud y educación.CSV")
  #Leemos el archivo 
  data_tab <- fread(ruta_archivo)
  #Lo guardamos en una lista
  lista_df[[i]] <- data_tab
}

# Filtremos las variables de interés

colnames(lista_df[[4]])

var_names <- c("DIRECTORIO","SECUENCIA_P","ORDEN","HOGAR","MES","CLASE",
               "FEX_C18","DPTO","P3271","P6040","P2057","P6080","P6070",
               "P6160","P3042","P3042S1","P3038")
length(var_names)

lista_df <- lapply(lista_df, function(dt) dt[, ..var_names])

#Consolidamos nuestro df final
gen_23 <- rbindlist(lista_df)

#Guardemos la base

write.csv(gen_23, file = "C:/Users/Julian/Desktop/Ciencia de datos/GEIH/gen_23.csv")


# Ocupados ----------------------------------------------------------------

file2 <- 'No ocupados.CSV'
file3 <- 'Ocupados.CSV'

# Filtrar los elementos que contienen el nombre deseado

grep(file3,l_file) #Busca el patrón que le pida
length(grep(file3,l_file)) #Valido que sean 12 archivos

files_oc <- l_file[grep(file3,l_file)]

lista_oc <- list()

for (i in meses) {
  #Construimos ruta del archivo caracteristigas generales
  ruta_archivo <- file.path(i, "CSV", file3)
  #Leemos el archivo 
  data_tab <- fread(ruta_archivo)
  #Lo guardamos en una lista
  lista_oc[[i]] <- data_tab
}

colnames(lista_oc[[2]])

var_oc <- c("DIRECTORIO","SECUENCIA_P","ORDEN","HOGAR","MES","CLASE",
            "FEX_C18","DPTO","P6440", "P6450","P6460","P6400","P6426",
            "P6430","P3045S1","P6500","P6800","P3069","RAMA2D_R4","INGLABO", 
            "RAMA4D_R4","OFICIO_C8")

length(var_oc)

lista_oc <- lapply(lista_oc, function(dt) dt[, ..var_oc])

#Consolidamos nuestro df final
ocu_23 <- rbindlist(lista_oc)

# Cargamos el conjunto de datos
#write.csv(ocu_23, file = "C:/Users/Julian/Desktop/Ciencia de datos/GEIH/ocu_23.csv")

