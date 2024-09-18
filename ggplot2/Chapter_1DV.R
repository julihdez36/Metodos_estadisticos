#-------------------------------------------------------------#
# Zahir Llerena                                               #
# email: arlington.llerena@uexternado.edu.co                  # 
# Data visualization using ggplot2 library with R: Chapter 1  #
#-------------------------------------------------------------#

#### Chapter 1
### Data Preparation

# R is an platform for data analysis, capable of creating almost any type of graph. 
# This course helps you create the most popular visualizations - 
# from quick and dirty plots to publication-ready graphs. 
# The text relies heavily on the ggplot2 package for graphics, but other approaches are covered as well.


### Prequisites

## Setup

# In order to create the graphs in this guide, you'll need to install some 
# optional R packages. To install all of the necessary packages, run the 
# following code in the RStudio console window.


my_packages <- c("ggplot2", "dplyr", "tidyr", "tidyverse", "mosaicData", "ggstatsplot",
                 "VIM", "scales", "treemapify", "gapminder", "ggmap", "choroplethr", "Rcmdr",
                 "choroplethrMaps", "CGPfunctions", "ggcorrplot", "visreg", "gcookbook", 
                 "forcats", "survival", "survminer", "ggalluvial", "ggridges", "GGally", 
                 "superheat", "waterfalls", "factoextra", "networkD3", "ggthemes", 
                 "hrbrthemes", "ggpol", "ggbeeswarm", "broom", "coefplot", "dotwhisker",
                 "gapminder", "GGally", "ggjoy", "ggrepel", "gridExtra", "DescTools",
                 "interplot", "margins", "maps", "mapproj", "mapdata", "psych", "ggExtra",
                 "MASS", "quantreg", "scales", "survey", "srvyr", "Hmisc", "nycflights13",
                 "viridis", "viridisLite", "devtools", "AER", "car", "carData", "patchwork")

install.packages(my_packages, repos = "http://cran.rstudio.com")

### Introduction 

rm(list = ls())

options(prompt = "Zahir>", continue = " + ")
options(repos = c(CRAN = "http://cran.rstudio.com"))

update.packages()

## 1.1 Setting folder access

setwd("G:\\Mi unidad\\R_Work\\ggplot2_course") 
getwd()

list.files(path = ".")

dir(path = "G:\\Mi unidad\\R_Work\\ggplot2_course")


## Syntax storage

savehistory(file = "saveGGplot2_1")

#### ADMINISTRATION AND MANAGEMENT OF A DATABASE

library(tidyverse)
library(dplyr)

# You are going to learn the five key dplyr functions
# that allow you to solve the vast majority of your data-manipulation
# challenges:

# select:	select variables/columns
# filter:	select observations/rows
# mutate: transform or recode variables
# summarize:	summarize data
# group_by:	identify subgroups for further processing

# These can all be used in conjunction with group_by(), which
# changes the scope of each function from operating on the entire
# dataset to operating on it group-by-group. These six functions provide
# the verbs for a language of data manipulation.

library(AER)
data("CPS1985", package = "AER"); CPS1985

help(CPS1985)


# Cross-section data originating from the May 1985 Current Population Survey by 
# the US Census Bureau (random sample drawn for Berndt 1991).

View(CPS1985)

head(CPS1985); tail(CPS1985)
str(CPS1985); names(CPS1985)
class(CPS1985); mode(CPS1985)

library(DescTools)
Abstract(CPS1985)

object.size(CPS1985)
na.omit(CPS1985)


summary(CPS1985)

## 1.2.1 Selecting variables

# keep the variables wage, age and gender

library(dplyr)

newdata <- select(CPS1985, wage, age, gender); head(newdata)

# keep the variables name and all variables
# between age and gender inclusive

newdata <- select(CPS1985, wage, age:gender); head(newdata)

# keep all variables except education and gender

newdata <- select(CPS1985, -education, -gender); head(newdata)


## 1.2.2 Selecting observations

library(dplyr)

# select females

newdata <- filter(CPS1985, gender == "female"); head(newdata) 

View(newdata)


# select females that are from sector manufacturing

levels(CPS1985$sector)
sort(table(CPS1985$sector))

newdata <- filter(CPS1985, gender == "female" & sector == "manufacturing"); head(newdata)
View(newdata)

# select individuals that are from
# services, sales, or worker

newdata <- filter(CPS1985, occupation == "services" | occupation == "sales" | occupation == "worker")
head(newdata)
View(newdata)

# this can be written more succinctly as

newdata <- filter(CPS1985, occupation %in% c("services", "sales", "worker")); head(newdata)


## 1.2.3 Creating/Recoding variables

# The mutate function allows you to create new variables or transform existing ones.
# To convert the wage that is in dollars to Colombian pesos and to Euro


newdata <- mutate(CPS1985, Ingreso_P = wage*3799.01, Ingreso_E = wage*0.8415036); head(newdata) # 1 euro = 4514.55 pesos COP

summary(CPS1985)

library(dplyr)

# Create a categorical variable that allows identifying wage above the median

newdata <- mutate(CPS1985, indicador_w = ifelse(wage > median(CPS1985$wage), "higt", "low"))
head(newdata) 

View(newdata)

class(newdata$indicador_w)

# Select office occupations and assign them the notation "Oficina"

newdata <- mutate(CPS1985, Office_w = ifelse(occupation %in% c("office", "services", "management"), "Oficina", "Otros"))
head(newdata) 

View(newdata)

## Selecting age greater than 44 years and less than 28

newdata <- mutate(CPS1985, Edad_U = ifelse(age < 28 | age > 44, NA, age))
head(newdata) 

## 1.2.4 Summarizing data

library(dplyr)

# calculate mean wage and experience

newdata <- summarize(CPS1985, mean_W = mean(wage, na.rm = TRUE), mean_E = mean(experience, na.rm = TRUE))
newdata

# calculate mean wage by occupation

table(CPS1985$occupation)

newdata <- group_by(CPS1985, occupation); newdata


# The summarize function can be used to reduce multiple values down to a single value (such as a mean). 
# It is often used in conjunction with the by_group function, to calculate statistics by group.


newdata <- summarize(newdata, mean_W = mean(wage, na.rm = TRUE), mean_Ed = mean(education, na.rm = TRUE))
newdata


## 1.2.5 Using pipes

# Packages like dplyr and tidyr allow you to write your code in a compact format using the pipe %>% operator.

# The pipe, %>%, comes from the magrittr package by Stefan Milton Bache. 

library(magrittr)

# Packages in the tidyverse load %>% for you automatically, so you don't usually load magrittr explicitly.

# Pipes are a powerful tool for clearly expressing a sequence of multiple operations.

# %>%:
# %$%:
# %<>%:
# %.%:
# %>>%:
# %<%: 
# %T>%

mean(CPS1985$wage)

# function(argument), can be rewritten as follows: argument %>% function()
# f(x, y) can be rewritten as x %>% f(y)
# f(x, y) can be rewritten as y %>% f(x, .)
# f(y, z = x) can be rewritten as x %>% f(y, z = .)

library(dplyr)

# calculate the mean wage for women by sector

newdata <- filter(CPS1985, gender == "female"); head(newdata)
newdata <- group_by(newdata, sector); head(newdata)
newdata <- summarize(newdata, mean_W = mean(wage, na.rm = TRUE)); newdata


# this can be written as

newdata <- CPS1985 %>% filter(gender == "female") %>%  group_by(sector) %>%
  summarize(mean_W = mean(wage, na.rm = TRUE))

newdata


# Other selection variants

by_occupation <- group_by(CPS1985, occupation)

summarize(by_occupation , media_O = mean(wage, na.rm = TRUE))

tapply(CPS1985$wage, CPS1985$occupation, mean)


by_occ.sec <- group_by(CPS1985, occupation, sector)
summarize(by_occ.sec , media_OS = mean(wage, na.rm = TRUE))

tapply(CPS1985$wage, list(CPS1985$occupation, CPS1985$sector), mean)


### ANOTHER EXAMPLE 

library(tidyverse)
library(nycflights13)

# nycflights13
# This data frame contains all 336,776 flights that departed from New York City in 2013.
# The data comes from the US: https://www.transtats.bts.gov/DatabaseInfo.asp?DB_ID=120&Link=0


nycflights13::flights

help(flights)
?flights

head(flights); tail(flights)
names(flights); colnames(flights) 
class(flights); mode(flights)
dim(flights)

View(flights)

str(flights)

library(DescTools)
Abstract(flights)

object.size(flights)
complete.cases(flights)
na.omit(flights)
na.exclude(flights)

# You might notice that this data frame prints a little differently from
# other data frames you might have used in the past: it only shows the
# first few rows and all the columns that fit on one screen. (To see the
# whole dataset, you can run View(flights), which will open the
# dataset in the RStudio viewer).

View(flights)

# It prints differently because it's a tibble

### dplyr Basics

# You are going to learn the five key dplyr functions
# that allow you to solve the vast majority of your data-manipulation
# challenges:

# - Pick observations by their values (filter()).
# - Reorder the rows (arrange()).
# - Pick variables by their names (select()).
# - Create new variables with functions of existing variables (mutate()).
# - Collapse many values down to a single summary (summarize()).

# These can all be used in conjunction with group_by(), which
# changes the scope of each function from operating on the entire
# dataset to operating on it group-by-group. These six functions provide
# the verbs for a language of data manipulation.

# All verbs work similarly:

# 1. The first argument is a data frame.
# 2. The subsequent arguments describe what to do with the data-frame, 
# using the variable names (without quotes).

# 3. The result is a new data frame.

# Together these properties make it easy to chain together multiple
# simple steps to achieve a complex result.


### Filter Rows

# filter() allows you to subset observations based on their values.

# The first argument is the name of the data frame. The second and
# subsequent arguments are the expressions that filter the data frame.
# For example, we can select all flights on January 1st with:

filter(flights, month == 1, day == 1)


# When you run that line of code, dplyr executes the filtering operation
# and returns a new data frame. dplyr functions never modify
# their inputs, so

jan1 <- filter(flights, month == 1, day == 1)

(dec25 <- filter(flights, month == 12, day == 25))


### Comparisons
# To use filtering effectively, you have to know how to select the observations
# that you want using the comparison operators

# R provides the standard suite: >, >=, <, <=, != (not equal), and == (equal).

filter(flights, month = 1)

### Logical Operators

filter(flights, month == 11 | month == 12)

nov_dec <- filter(flights, month %in% c(11, 12)); nov_dec

# Another option 

subset(flights, subset = month %in% c(11,12))

subset(flights, subset = month %in% c(11,12), select = -year)

flights[flights$month == 11 | flights$month == 12, -1]


# De Morgan law:
# !(x & y) is the same as !x | !y, and !(x | y) is the same as !x & !y.

# For example, if you wanted to find flights
# that weren't delayed (on arrival or departure) by more than two
# hours, you could use either of the following two filters:


filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

# Whenever you start using complicated, multipart expressions in filter(), 
# consider making them explicit variables instead. That makes
# it much easier to check your work. You'll learn how to create new
# variables shortly.


# filter() only includes rows where the condition is TRUE; it
# excludes both FALSE and NA values


### Arrange Rows with arrange()

# arrange() works similarly to filter() except that instead of selecting
# rows, it changes their order. It takes a data frame and a set of column
# names (or more complicated expressions) to order by.

arrange(flights, year, month, day)
arrange(flights, desc(arr_delay))
View(arrange(flights, desc(arr_delay)))

### Select Columns with select()

# It's not uncommon to get datasets with hundreds or even thousands
# of variables. In this case, the first challenge is often narrowing in on
# the variables

# Select columns by name

select(flights, year, month, day)


# Select all columns between year and day (inclusive)

select(flights, year:day)

# Select all columns except those from year to day (inclusive)

select(flights, -(year:day))

select(flights, !(year:day))

# There are a number of helper functions you can use within select():

# - starts_with("abc") matches names that begin with abc
# - ends_with("xyz") matches names that end with xyz
# - contains("ijk") matches names that contain ijk
# - matches("(.)\\1") selects variables that match a regular expression.
# - num_range("x", 1:3) matches x1, x2, and x3.

select(flights, !ends_with("delay"))

select(flights, starts_with("dep") & ends_with("delay"))

select(flights, starts_with("dep") | ends_with("delay"))

select(flights, contains("time"))
select(flights, contains("TIME"))


# select() can be used to rename variables, but it's rarely useful
# because it drops all of the variables not explicitly mentioned.
# Instead, use rename(), which is a variant of select() that keeps all
# the variables that aren't explicitly mentioned:

rename(flights, tail_num = tailnum) # Original name is tailnum

str(flights)
str(rename(flights, tail_num = tailnum))


# Another option is to use select() in conjunction with the everything() helper

select(flights, time_hour, air_time, everything())

# This is useful if you have a handful of variables
# you'd like to move to the start of the data frame


### Add New Variables with mutate()

# Besides selecting sets of existing columns, it's often useful to add
# new columns that are functions of existing columns.

# mutate() always adds new columns at the end of your dataset so
# we'll start by creating a narrower dataset so we can see the new variables.

flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time)

head(flights_sml)

summary(flights_sml)


newdata <- mutate(flights_sml, Distancia = ifelse(distance > 872, "far", "near"))
newdata

newdata <- mutate(flights_sml, Distance = ifelse(distance < 502 | distance > 1389, "lejos", "centrado"))
newdata

summary(flights)

table(flights$origin)
levels(flights$origin)

View(mutate(flights, Origen = ifelse(origin %in% c("EWR", "JFK"), "importantes", "no-importantes")))


table(flights$dest)
levels(flights$dest)

(flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time))


mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60)

# Note that you can refer to columns that you've just created:
# The new variable is added to the initial database - flights_sml - .


mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours)

# If you only want to keep the new variables, use transmute():

transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours)


### Useful Creation Functions
# There are many functions for creating new variables that you can
# use with mutate(). The key property is that the function must be
# vectorized: it must take a vector of values as input, and return a vector
# with the same number of values as output.

View(flights)

transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100
)

### Grouped Summaries with summarize() 

# The last key verb is summarize(). It collapses a data frame to a single
# row:

summarize(flights, delay = mean(dep_delay, na.rm = TRUE))

#-----------------------------------------------------------------------------
library(tidyverse)
library(dplyr)

select(flights, dep_delay)

flights %>% select(dep_delay)


colMeans(select(flights, dep_delay), na.rm = TRUE) 

colSums(flights %>% select(dep_delay), na.rm = TRUE) %>% abs()


#-----------------------------------------------------------------------------

by_day <- group_by(flights, year, month, day)

head(by_day)

summarize(by_day, delay = mean(dep_delay, na.rm = TRUE))

flights_o <- group_by(flights, origin)


summarize(flights_o, mean_dist = mean(distance, na.rm = TRUE), mean_h = mean(hour, na.rm = TRUE))


#### The end

#### Thanks you...!!!


# Syntax storage

savehistory(file = "saveGGplot2_1")





































































































