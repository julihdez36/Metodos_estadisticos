
# ----------ggplot2---------------
library(ggplot2)
data(mtcars) 
str(mtcars)
df <- mtcars[, c("mpg", "cyl", "wt")]
head(df)

# Use data from numeric vectors
x <- 1:10; y = x*x
# Basic plot
qplot(x,y)
# Add line
qplot(x, y, geom = c("point", "line"))
# Use data from a data frame
qplot(mpg, wt, data = mtcars)

qplot(mpg, wt, data = mtcars, geom = c("point", "smooth"))

# ----------------- Geometría de puntos------------

# Linear fits by group
qplot(mpg, wt, data = mtcars, color = factor(cyl),
      geom = c("point", "smooth"))

# Change scatter plot colors
# Points can be colored according to the values of a
# continuous or a discrete variable.
# The argument colour is used.
# Change the color by a continuous numeric variable
qplot(mpg, wt, data = mtcars, colour = cyl) #Estos me gustan
qplot(x = hp, y = wt, data = mtcars, geom = c("point","smooth"),
      method = "lm")

# Change the color by groups (factor)
df <- mtcars
df[, "cyl"] <- as.factor(df[, "cyl"])
qplot(mpg, wt, data = df, colour = cyl)
# Add lines
qplot(mpg, wt, data = df, colour = cyl, geom = c("point", "line"))
qplot(mpg, wt, data = df, colour = factor(cyl))

# Change the size of points according to
# the values of a continuous variable
qplot(mpg, wt, data = mtcars, size = mpg)
# Change point shapes by groups
qplot(mpg, wt, data = mtcars, shape = factor(cyl))
# Scatter plot with texts
# The argument label is used to specify the texts to be used for each points:
qplot(mpg, wt, data = mtcars, label = rownames(mtcars),
      geom = c("point", "text"), hjust = 0, vjust = 0)
qplot(x = mpg, y = wt, size = cyl, colour = hp, data = mtcars)

qplot(x = mpg, y = wt, alpha = I(0.4), data = mtcars)
qplot(x = carat, y = price, alpha = I(0.02), data = diamonds)


#-------------- Box plots --------------

# Basic box plot from a numeric vector
x <- "1"
y <- rnorm(100)
qplot(x, y, geom = "boxplot")
# Basic box plot from data frame
head(PlantGrowth)
qplot(group, weight, data = PlantGrowth, #cuali primero, depsues cuanti
      geom = c("boxplot"))

# Change the color by groups:
# Box plot from a data frame
# Add jitter and change fill color by group
qplot(group, weight, data = PlantGrowth,
      geom = c("boxplot", "jitter"), fill = group)
# Dot plot
qplot(group, weight, data = PlantGrowth,
      geom = "dotplot", stackdir = "center", binaxis = "y",
      color = group, fill = group)

# Dot plot
qplot(group, weight, data = PlantGrowth,
      geom = c("dotplot"), stackdir = "center", binaxis = "y")
# Violin plot
qplot(group, weight, data = PlantGrowth,
      geom = c("violin"), trim = FALSE)

# --------Diagramas de barras e histográmas-------------

head(diamonds)
str(diamonds)
qplot(x = clarity, data = diamonds)
qplot(x = color, y = price/carat, geom = "jitter",
      alpha = I(0.08), data = diamonds)

# Histograma con bin especifico
qplot(x = carat, binwidth = 0.25, data = diamonds)

# Grafica de barras apilado
qplot(x = clarity, data = diamonds, geom = "bar", fill = cut,
      position = "stack")

# Grafico de lineas con frecuencias por clases
qplot(x = carat, geom = "freqpoly", group = cut, colour = cut,
      data = diamonds)

# Grafico de densidad de area
qplot(x = carat, geom = "density", group = factor(cut),
      colour = factor(cut), fill = factor(cut),
      alpha = I(0.5), data = diamonds)
