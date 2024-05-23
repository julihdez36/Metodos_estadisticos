# Series temporales


# Librerías ---------------------------------------------------------------


# fpp3 carga datos y algunos paquetes de interés como tidyverse

#install.packages('fpp3')
library(fpp3)

#Objetos tsibble: un tibble (tidy data frames) con una estructura temporal
# Parte de la librería tsibble

y <- tsibble(
  Year = 2015:2019,
  Observation = c(123, 39, 78, 52, 110),
  index = Year
)
plot(y, type='l')

# Es importante leer el encabezado que nos da detalles de la serie
# # A tsibble: 5 x 2 [1Y]

#Podemos cambiar la frecuencia

z <- data.frame(Month = c('2019 Jan','2019 Feb','2019 Mar','2019 Apr',
                          '2019 May'),
                Observation = c(50,23,34,30,25))
z

yearmonth(z$Month) #Los lee como meses

z <- z %>% mutate(Month = yearmonth(Month)) %>% #lo convertimos a meses 
  as_tsibble(index = Month) #trasnformo en tsibble y señalo la indexación
z
#A tsibble: 5 x 2 [1M]

#Funciones de tiempo: yearquarter(),yearweek(),ymd()


# Key variables -----------------------------------------------------------

#Puedo almacenar varias series temporales en un objeto
#Esto lo hacemos a través de las variables llave

#Veamos por ejemlo los tiempos de carrera más rápidos para carreras en pista
olympic_running ## A tsibble: 312 x 4 [4Y] # Key: Length, Sex [14]

# Esta nos dice, por ejemplo, que contiene 14 series de tiempo

table(olympic_running$Length)
table(olympic_running$Sex)
table(olympic_running$Length,olympic_running$Sex)

olympic_running %>%  distinct(Length) #7 longitudes
olympic_running %>%  distinct(Sex) #2 sexos


#dplyr es la mejor manera de manejar los datos

olympic_running %>% filter(Length == 100 & Sex == 'men') 

olympic_running %>% filter(Sex == 'men') %>% 
  summarise(Promedio_tiempo = mean(Time))

olympic_running %>%
  filter(Sex == 'men') %>%
  group_by(Length) %>%
  summarise(Promedio_tiempo = mean(Time))


# Gráficos en series de tiempo --------------------------------------------

olympic_running %>% filter(Length == 1500 & Sex == 'men') %>% 
  ggplot(aes(x = Year, y = Time)) +
  geom_line() +
  labs(title = "Serie de tiempo discontinua",
       x = "Year", y = "Time")+theme_light()

# carga semanal de pasajeros en clase económica de las aerolíneas Ansett 
# entre las dos ciudades más grandes de Australia.

data(ansett) 
table(ansett$Class,ansett$Airports)

ansett %>% filter(Airports == "MEL-SYD", Class == "Economy") %>% 
  select(-c('Airports','Class'))

melsyd_economy <- ansett %>% filter(Airports == "MEL-SYD",Class == "Economy") %>% 
                  select(-c('Airports','Class'))

ggplot(data = melsyd_economy, aes(x= Week, y=Passengers))+
  geom_line()+labs(title = 'Clase económica Ansett Airlines',
                   subtitle = "Melbourne-Sydney",
                   y = 'Pasajeros (mil)')+theme_light()

#Gráficos nativos de r
plot(melsyd_economy, type = 'l')

#Con ggplot
colnames(melsyd_economy)

ggplot(data = melsyd_economy, aes(x= Week, y=Passengers))

ggplot(data = melsyd_economy, aes(x= Week, y=Passengers))+geom_line()

ggplot(data = melsyd_economy, aes(x= Week, y=Passengers))+
  geom_line()+labs(title = 'Clase económica Ansett Airlines',
                   subtitle = "Melbourne-Sydney",
                   y = 'Pasajeros (mil)')+theme_light()



# Descomposición con series temporales ------------------------------------

# empleo en el sector minorista de EE. UU.

us_employment
unique(us_employment$Series_ID) %>% length() #148 series
range(us_employment$Month)

us_retail_employment <-  us_employment %>% 
  filter(year(Month) >= 1990, Title == "Retail Trade") %>% 
  select(-Series_ID)

ggplot(data = us_retail_employment,aes(x = Month,y = Employed))+
  geom_line()+labs(title = 'Empleo total en el comercio minorista de EE. UU.',
                   subtitle = 'Personas (miles)')+theme_light()

# Descomposición STL (Seasonal and Trend decomposition using Loess):

dcmp <- us_retail_employment %>% 
  model(stl = STL(Employed)) #Aplicar descomposición

components(dcmp) # Visualizar componentes (forma aditiva)

#Visualización de componentes

components(dcmp) %>% 
  as_tsibble() %>% 
  autoplot(Employed, colour="gray") +
  geom_line(aes(y=trend), colour = "#D55E00") +
  labs(title = 'Empleo total en el comercio minorista de EE. UU.',
       subtitle = 'Personas (miles)') + theme_light()

components(dcmp) %>%  autoplot() + theme_light()

# Datos ajustados estacionalmente
colnames(components(dcmp))

components(dcmp) %>% 
  as_tsibble() %>% 
  autoplot(Employed, colour = "gray") +
  geom_line(aes(y=season_adjust), colour = "#0072B2") +
  labs(y = "Persons (thousands)",
       title = "Total employment in US retail")


# Media movil -------------------------------------------------------------

levels(global_economy$Country)

global_economy %>% 
  filter(Country == "Colombia")  %>% 
  autoplot(Exports) +
  labs(y = "% of GDP", title = "Total exportaciones colombia")

# Media movil de orden 5

col_exports <- global_economy %>% 
  filter(Country == "Colombia") %>% 
  mutate(
    `5-MA` = slider::slide_dbl(Exports, mean,
                               .before = 2, .after = 2, .complete = TRUE)
  )

col_exports %>% 
  autoplot(Exports) +
  geom_line(aes(y = `5-MA`), colour = "#D55E00") +
  labs(y = "% del PBI",
       title = "Exportaciones totales en colombia")+theme_light()


# Descomposición clásica --------------------------------------------------

us_retail_employment <-  us_employment %>% 
  filter(year(Month) >= 1990, Title == "Retail Trade") %>% 
  select(-Series_ID)

us_retail_employment %>% 
  model(classical_decomposition(Employed, type = "additive")) %>% 
  components() %>%    autoplot()


# Descomposición STL ------------------------------------------------------

us_retail_employment %>% 
  model(STL(Employed ~ trend(window = 7) +season(window = "periodic"),
        robust = TRUE)) %>% 
  components() %>% 
  autoplot()


# Autocorrelación ---------------------------------------------------------

aus_production

recent_production <- aus_production  %>% 
  filter(year(Quarter) >= 2000)

recent_production %>% 
  ACF(Beer) %>% 
  autoplot() + labs(title="Australian beer production")+theme_light()


# Pronóstico --------------------------------------------------------------

#Calculamor PIB per cápita

gdppc <- global_economy %>% 
  mutate(GDP_per_capita = GDP / Population)

# Visualizamos

gdppc %>% 
  filter(Country == "Colombia") %>% 
  autoplot(GDP_per_capita) +
  labs(y = "$US", title = "PIB per capita de Colombia")+
  theme_light()

#Especificamos

TSLM(GDP_per_capita ~ trend())

# Estimamos

fit <- gdppc %>% 
  model(trend_model = TSLM(GDP_per_capita ~ trend()))

fit %>% 
  forecast(h = "3 years") %>% 
  filter(Country == "Colombia") %>% 
  autoplot(gdppc) +
  labs(y = "$US", title = "PIB per capita de Colombia")+
  theme_light()
  

# Estacionaridad y diferenciación -----------------------------------------

library(gridExtra)

google_2015 <- gafa_stock %>% 
  filter(Symbol == "GOOG", year(Date) == 2015)

p1 <- google_2015 %>%   
        autoplot(Close) + labs(subtitle = "Acciones de Google (precio de cierre)")
p2 <- google_2015 %>%  
        autoplot(difference(Close)) + 
  labs(subtitle = "Variación en el precio de cierre de las acciones de Google")

grid.arrange(p1, p2, ncol = 2)

# Correlograma AFC (parece ruido blanco)

google_2015  %>%  ACF(difference(Close)) %>% 
  autoplot() + labs(subtitle = "Changes in Google closing stock price")


# ARIMA -------------------------------------------------------------------

global_economy %>% 
  filter(Code == "EGY") %>% 
  autoplot(Exports) +
  labs(y = "% of GDP", title = "Egyptian exports")+
  theme_light()

library(urca)
fit <- global_economy  %>% filter(Code == "EGY") %>% 
  model(ARIMA(Exports))

report(fit)

fit %>%  forecast(h=10) %>% 
  autoplot(global_economy) +
  labs(y = "% of GDP", title = "Egyptian exports")+
  theme_light()
