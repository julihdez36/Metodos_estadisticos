# Sesion 2

rm(list = ls()) # Borra todo el ambiente

# Función if

x = 3

if(x < 9){y=9} # Si se cumple, realiza la expresión {}

if(x>6){y=-1}

a = 3
if(a<7){
  x=6}else{
    x=7} 

# Eventualmente podemos quitar los {}

if(a<7) x=6 else x=1

#Aunque ejecute, hay que tener cuidado. En su lugar podemo usar ifelse

ifelse(a<7,6,1)



# Ciclos: for y while -----------------------------------------------------

# Ciclo 'for'

x = 1:10

for(i in x){
  print(x[i]^2)} # Para sacar el cuadrado

# En R las funciones están a vectorizadas, así que se puede hacer

x^2

# Hagamos una sucesión de este tipo
# x = (x1,x2,x3...) --> y = (x1,x1+x2,x2+x3,...)

x = 1:100
n = length(x)

y = c(x[1]) #x1

for(i in 2:n){
  y[i] = x[i-1] + x[i] # define las siguientes entradas
}

print('La seucesión final es:'); y


# Cosnturyamos ahora la sucesión de Fibonacci
# 1,1,2,3,5,8,13,21,...
# y[n] = y[n-1] + y[n-2]

n = 50
y = c(1,1)
for(i in 3:n){
  y[i] = y[i-1] + y[i-2]
}
y

# Suma armónica: 1 + 1/2 + 1/3 + ... + 1/n = ?

n=10000
suma = 0
for(i in 1:n){
  suma = suma + (1/i)
}

suma


# Sacar solamento los pares de un vector
x = 1:10

for(i in x){
  if(x[i] %% 2 == 0){
    print(x[i])
  }
}


### Función while

x = 0
cota = 9

while(x<cota){
  print(x)
  x = x+1
}

n_ite = 0

while(x <9){
  print(x)
  x = x-1
  
  n_ite = n_ite+1
  if(n_ite == 100){
    break
  }
}


# Funciones ---------------------------------------------------------------

# Area de un rectangulo

area_rect = function(b,h){b*h}
area_rect(2,2)

