# Atajos en R -------------------------------------------------------------
# ctrl+shift+c = vuelve comentario las lineas indicadas
# ctrl+alt+flecha = me permite moverme entre pestanas de script
# ctrl+shift+r = inserta una seccion
# ctrl+shift+a = ordena todo el código seleccionado


#La librería ggplot2 es un paquete de visualización de datos 
#para el lenguaje R que implementa lo que se conoce como la 
#“Gramática de los Gráficos”, que no es más que una representación
#esquemática y en capas de lo que se dibuja en dichos gráficos, 
#como lo pueden ser los marcos y los ejes, el texto de los mismos,
#los títulos, así como, por supuesto, los datos o la información 
#que se grafica, el tipo de gráfico que se utiliza, los colores,
#los símbolos y tamaños, entre otros.


# Gráfico de barras (barplot) ---------------------------------------------

head(mtcars)

ggplot(data = mtcars, aes(x=gear))+geom_bar()

#Se incorporan capas y elementos deseados con el operador +
ggplot(data = mtcars, aes(x=gear))+geom_bar(color = 'darkslategray',
                                            fill='steelblue')+
  xlab("Número de velocidades")+
  ylab("Cantidades")+
  ggtitle("Gráfico de barras") 

#Cambiemos la orientación de los ejes

ggplot(data = mtcars, aes(x = gear)) + 
  geom_bar(color = 'darkslategray', fill = 'steelblue') + 
  xlab("Número de Velocidades") + 
  ylab("Cantidades") + 
  ggtitle("Gráfico de Barras") +
  coord_flip() #cambio de la orientacion de los ejes

#Mas colores
ggplot(data = mtcars, aes(x = gear, fill = as.factor(gear))) + 
  geom_bar() + 
  xlab("Número de Velocidades") + 
  ylab("Cantidades") + 
  ggtitle("Gráfico de Barras") +
  labs(fill = "Velocidades") #esto da el titulo de la leyenda

# Cambiemos el fondo con el tema

ggplot(data = mtcars, aes(x = gear, fill = as.factor(gear))) + 
  geom_bar() + 
  xlab("Número de Velocidades") + 
  ylab("Cantidades") + 
  ggtitle("Gráfico de Barras") +
  labs(fill = "Velocidades") + 
  theme_light()

# Histograma (Histogram) y densidad (density plot) ------------------------

head(diamonds) #diamantes

ggplot(data = diamonds)+
  geom_histogram(aes(x = carat), binwidth = 0.1, fill = 'steelblue')+
  xlab("Carat")+ylab("Frecuencia absoluta")+
  ggtitle("Distribución de la variable carat")+
  theme_light()+xlim(0,2.5)
  #binwidth ancho de la barra. bins=numero de barras

#Intentando hacerlo con el método de sturges

a<-hist(diamonds$carat) #La librería base de r los tien
summary(a) # acá me indica cuántos son
br<-a$breaks #creo el objeto

ggplot(data = diamonds)+
  geom_histogram(aes(x = carat), breaks=br, fill = 'steelblue', color="black")+
  xlab("Carat")+ylab("Frecuencia absoluta")+
  ggtitle("Distribución de la variable carat")+
  theme_light()

#Histograma con segmentación categórica -------------
windows()
ggplot(diamonds) + 
  geom_histogram(bins = 50, aes(x = carat, fill = cut)) + #el relleno en función de una catagórica
  xlab("Carat") + 
  ylab("Frecuencia") + 
  ggtitle("Distribución de la variable Carat") +
  theme_light()

#Borde negro de las barras
ggplot(diamonds) + 
  geom_histogram(bins = 50, aes(x = carat, fill = cut), color = 'black') + 
  xlab("Carat") + 
  ylab("Frecuencia") + 
  ggtitle("Distribución de la variable Carat") +
  theme_minimal()

#Proporciones por categorías

ggplot(diamonds) + 
  geom_histogram(bins = 50, aes(x = carat, fill = cut), color = 'black', position = 'fill') + 
  xlab("Carat") + 
  ylab("Frecuencia") + 
  ggtitle("Proporciones del tipo de Corte según variable Carat") +
  theme_minimal()

#Si queremos ver las distribuciones por separado se incorpora
#La función facet_grid
ggplot(diamonds) + 
  geom_histogram(bins = 50, aes(x = carat, fill = cut), color = 'black') + 
  facet_grid(cut~., scales = 'free') +
  #la variable ‘cut’ en cada fila, el resto en las columnas
  #scales = 'free' lo que produce es que cada histograma 
  #por separado se reescala de manera automática
  xlab("Carat") + 
  ylab("Frecuencia") + 
  ggtitle("Distribución de la variable Carat para los distintos Cut") +
  theme_minimal()

# Gráficos de densidad--------------

ggplot(diamonds) + 
  geom_density(aes(x = carat), fill = 'steelblue') + 
  xlab("Carat") + 
  ylab("Frecuencia") + 
  ggtitle("Distribución de la variable Carat (Densidad)") +
  theme_minimal()

ggplot(diamonds) + 
  geom_density(aes(x = carat, fill = cut), position = 'stack') + 
  xlab("Carat") + 
  ylab("Frecuencia") + 
  ggtitle("Distribución de la variable Carat (Densidad)") +
  theme_minimal()
#Por separado
ggplot(diamonds) + 
  geom_density(aes(x = carat, fill = cut), position = 'stack') + 
  facet_grid(cut~., scales = 'free') +
  xlab("Carat") + 
  ylab("Frecuencia") + 
  ggtitle("Distribución de la variable Carat (Densidad) para los distintos Cut") +
  theme_minimal()

# Gráficos de dispersión (Scatterplot) --------------------------------------------------

head(mtcars)
ggplot(data = mtcars, aes(x = mpg, y = drat)) + 
  geom_point() +
  xlab('mpg') + 
  ylab('drat') +
  ggtitle('Relación entre mpg y drat') + 
  theme_light()

ggplot(data = mtcars, aes(x = mpg, y = drat)) + 
  geom_point(color="red", fill = 'red', size = 4, shape = 18,
             alpha = 0.5) +
  xlab('mpg') + 
  ylab('drat') +
  ggtitle('Relación entre mpg y drat') + 
  theme_light()

#shape=forma del simbolo
#color=bordes, fill relleno
#size=tamanio
# alpha=transparencia

ggplot(data = mtcars, aes(x = mpg, y = drat)) + 
  geom_point(color = 'slateblue', size = 4, alpha = 0.6) +
  geom_smooth(color = 'red') +
  xlab('mpg') + 
  ylab('drat') +
  ggtitle('Relación entre mpg y drat') + 
  theme_light()

ggplot(data = mtcars, aes(x = mpg, y = drat)) +
  geom_point(aes(color = gear), size = 4, alpha = 0.7) +
  xlab('mpg') + 
  ylab('drat') +
  ggtitle('Relación entre mpg y drat') + 
  theme_light()



# Boxplots y violin plot --------------------------------------------------
library(palmerpenguins)
data("penguins")
str(penguins)
table(penguins$species)

ggplot(data = penguins,aes(x=species,y=bill_length_mm ))+
  geom_point(aes(color=species), size=1,alpha=.7)+
  ggtitle("Longitud pinguinos")+xlab(label = 'Especie')+
  ylab(label = 'Longitud')+theme_light()

#Para ver los gráficos no sólo en una dimensión usamos geom_jitter

ggplot(data = penguins,aes(x = species,y=bill_length_mm))+
  geom_jitter(aes(color=species),size=1,alpha=.7)+
  ggtitle("Longitud pinguinos")+xlab(label = 'Especie')+
  ylab(label = 'Longitud')+theme_light()

#Incorporemos un gráfico de cajas

ggplot(data = penguins,aes(x = species,y = bill_length_mm))+
  geom_jitter(aes(color=species),size=1,alpha=.7)+
  geom_boxplot(aes(color=species),alpha=.7)+
  ggtitle("Longitud pinguinos")+xlab(label = 'Especie')+
  ylab(label = 'Longitud')+theme_light()

#Gráficos de violin

ggplot(data = penguins,aes(x = species,y = bill_length_mm))+
  geom_jitter(aes(color=species),size=1,alpha=.7)+
  geom_violin(aes(color=species, fill=species),alpha=.2,)+
  ggtitle("Longitud pinguinos")+xlab(label = 'Especie')+
  ylab(label = 'Longitud')+theme_light()

ggplot(data = penguins,aes(x = species,y = bill_length_mm))+
  geom_jitter(aes(color=species),size=1,alpha=.7)+
  geom_violin(aes(color=species, fill=species),alpha=.2,)+
  geom_boxplot(alpha=.7, color='gray')+
  ggtitle("Longitud pinguinos")+xlab(label = 'Especie')+
  ylab(label = 'Longitud')+theme_light()


# Correlogramas -----------------------------------------------------------

library(ggcorrplot)
round(cor(mtcars),2) #Libreri base

ggcorrplot(round(cor(mtcars),1), method = 'circle',type = 'lower',
           lab=TRUE)+ggtitle('Correlograma mtcars')+
  theme(legend.position = 'none')


#https://r-graph-gallery.com/
#https://rpubs.com/rdelgado/429190

