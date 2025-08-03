
setwd('C:/Users/Julian/Desktop/Cursos/Cursos Github/Metodos_estadisticos/Probability')
getwd()


# historia: https://www.youtube.com/watch?v=Z-GNl_5dMWk&list=PLQKbRolWHfJUcqHod5-Q_tY0IDdPTK8Xo&index=5&ab_channel=DanielCervantesFiloteo
# 
# 1992. Lenguaje estadístico basado en S.
# Es un lenguaje de programación funcional. La idea es hacer funciones y ejecutarlas.
# Es libre open source.

exp(1) # esto nos da el número e
log(2,exp(1)) # logaritmo natural

cos(pi); sin(pi); tan(pi) # Funciones trigonométricas


?exp() # Para pedir ayudas
help('if') # otra forma de pedir ayuda, util para estructuras de control

# Parte 2

# Creación de vectores

# Función c

x <-  c(2,5,1,9) 
x

x[3] # entrada 3 del vector x

x[6] # Marca NA porque no hay un valor asignado
x[6] <- 10 # agregando un valor a un espacio no asignado
x[5] <- 3

# La función 'c' también crea vectores con otras clases de datos

x <- c('1','Hola','True')

# En un vector todos los elementos deben tener la misma clase
# Si mezclamos tipos, asumirá el tipado mas amplio

x <- c(1,2,3,4,'h') 

# 'c' también podría combinar vectores

x = c(1,2,3,4)
y = c(4,5,6,7,2)
z = c(x,y)


# En 'c' puedo meter operaciones 

x = c(sin(pi),log(exp(1)),5^3,y)
x


# Funciones ':','seq','rep'
# Crean vectores con indicaciones sencillas

1:10; -8:5
7:1
2*2:20

# seq para secuencias mas complejas

seq(from = 6, to = 90, by = 3)

seq(0,1,.01) # caratcter posicional de los parámetros


# Función rep

rep(3,times = 8)
rep(1:7,2)

# Operaciones con vectores


x = 1:6
x + 2 # suma vectorizada

(1:100)^2

y = 6:1
x+y

# Qué pasa si sumo vectores de diferente dimensión
z = rnorm(10)
z+x # La suma se realiza, pero nos advierte el problema

# Las demás operaciones funcionan analogamente

x %*% y # producto punto
t(x) # longitud del vector
length(x) # longitud del vector
prod(x) # producto de los elementos del vector


# Busqueda bajo condiciones

z[c(2,3,5)]
z[2:5]

z[c(TRUE,  TRUE,  TRUE,  TRUE, FALSE,  TRUE,  TRUE,  TRUE,  TRUE,  TRUE)]
z[z<.5]

# Arreglos y matrices

matrix(1:4,nrow = 2, byrow = T)

# Matriz 5x5 de cero entradas

C = matrix(rep(0,25), nrow = 5)
C

matrix(0,5,5)

# Las operaciones con matrices funcionana anlogamente a los vectores

A + 2
A * 2
A * A # producto punto a punto

A %*% A # Producto matricial

# Funciones aplicadas a matrices

dim(A); dim(C)
cos(A)
max(A); sum(A)


# Graficas ----------------------------------------------------------------

x = 1:10
plot(x)
plot(x^2, type = 'l')
plot(x^2, type = 's', col = 'purple', lwd = 2)
plot(x^2, type = 'h', col = 'violetred2', lwd = 3)


x = seq(-pi,pi,len = 70)
plot(x, sin(x), type = 'l', ylim = c(-1.2,2),xlim = c(-5,5), 
     col = 'violetred2',
     lty =2) # tipo de linea

# Graficos de bajo nivel (sobre las graficas originales, alto nivel)

points(x,cos(x),
       pch = 8, # Tipo de punto
       col = 4)

lines(x,tan(x),
     type = 'p',
     lty = 1,
     pch = 4,
     col = 6)

# Podemos poner texto en las gráficas
title('Funciones trigonométricas',
      cex.main = 2.1, # tamaño de la letra
      )

legend(-5,2,
       c('sin','cos','tan'),
       col = c(2,4,6),
       lty = c(2,NA,1),
       pch = c(NA,7,4))
