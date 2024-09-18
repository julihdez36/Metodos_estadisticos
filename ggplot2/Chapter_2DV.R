#-------------------------------------------------------------#
# Zahir Llerena                                               #
# email: arlington.llerena@uexternado.edu.co                  # 
# Data visualization using ggplot2 library with R: Chapter 2  #
#-------------------------------------------------------------#
# Chapter 2
# Introduction to ggplot2


# Prequisites

# Introduction 

rm(list = ls())

options(prompt = "Zahir>", continue = " + ")
options(repos = c(CRAN = "http://cran.rstudio.com"))

update.packages()

# 2.0 Setting folder access

setwd("G:\\Mi unidad\\R_Work\\ggplot2_course") 
getwd()

list.files(path = ".")

dir(path = "G:\\Mi unidad\\R_Work\\ggplot2_course")


# Syntax storage

savehistory(file = "saveGGplot2_2")

## 2.1 A worked example
# This section provides an brief overview of how the ggplot2 package works.

# load data
library(mosaicData)

# The example uses data from the 1985 Current Population Survey to explore 
# the relationship between wages (wage) and experience (expr).

data(CPS85, package = "mosaicData"); View(CPS85)

help(CPS85)
names(CPS85)
str(CPS85)

library(DescTools)
Abstract(CPS85)

library(tidyverse)
library(ggplot2)

# Analysis of the qplot() function

# Bar graphic

# Bar diagrama

qplot(x = sector, colour = sector, data = CPS85)
qplot(x = sector, fill = sector, data = CPS85)


qplot(x = sector, y = wage, geom = "jitter", alpha = I(0.3), data = CPS85)

# Basic plot
summary(CPS85)

qplot(CPS85$exper, CPS85$wage)
qplot(CPS85$exper, CPS85$wage, color = CPS85$sex)

qplot(exper, wage, data = CPS85)


# Add line
qplot(exper, wage, geom = c("point", "line"), data = CPS85)

# Smoothing

qplot(exper, wage, geom = c("point", "smooth"), data = CPS85)

qplot(exper, wage, geom = c("point", "smooth"), color = sex, data = CPS85) # color = factor(sex)

qplot(exper, wage, geom = c("point", "smooth"), colour = hispanic, data = CPS85)


qplot(x = exper, y = wage, geom = c("point", "smooth"), method = "lm", data = CPS85)

summary(lm(CPS85$wage ~ CPS85$exper))

# Change the size of points according to
# the values of a continuous variable

qplot(exper, wage, size = wage, data = CPS85)

# Change point shapes by groups

qplot(exper, wage, size = wage, shape = sex, data = CPS85)


# Scatter plot with texts
# The argument label is used to specify the texts to be used for each points:


qplot(educ, wage, label = rownames(CPS85), geom = c("point", "text"), 
      hjust = 0, vjust = 0, data = CPS85)

qplot(x = educ, y = wage, alpha = I(0.2), data = CPS85)


# Basic box plot from data frame

levels(CPS85$sector)
summary(CPS85$sector)

qplot(sector, wage, geom = "boxplot", data = CPS85)
qplot(sector, wage, geom = "boxplot", fill = sex,  data = CPS85)


# Change the color by groups:
# Box plot from a data frame
# Add jitter and change fill color by group


qplot(sector, wage, geom = c("boxplot", "jitter"), fill = sector, data = CPS85)

qplot(wage, sector, geom = c("boxplot", "jitter"), fill = sector, data = CPS85)

qplot(south, wage, geom = "dotplot", stackdir = "center", binaxis = "y",
      color = south, fill = south,  binwidth = 1, data = CPS85)

# Violin plot
qplot(south, wage, geom = "violin", trim = FALSE, data = CPS85)
qplot(south, wage, fill = married, colour = sex, geom = "violin", trim = FALSE, data = CPS85)

qplot(sector, wage, colour = sector,  geom = "violin", trim = FALSE, data = CPS85)


# Hist

qplot(x = wage, binwidth = 2, data = CPS85)


qplot(x = wage, geom = "freqpoly", group = sector, colour = sector, data = CPS85)


qplot(x = wage, geom = "density", group = sector,
      colour = sector, fill = sector,
      alpha = I(0.5), data = CPS85)


# The functions in the ggplot2 package build up a graph in layers. 
# We'll build a a complex graph by starting with a simple graph and 
# adding  elements, one at a time.

# The first function in building a graph is the ggplot function. It specifies the:

# - data frame containing the data to be plotted
# - the mapping of the variables to visual properties of the graph. 
#   The mappings are placed within the aes function (where aes stands for aesthetics).


ggplot(data = CPS85,
  mapping = aes(x = exper, y = wage))


# Why is the graph empty? We specified that the exper variable should be mapped 
# to the x-axis and that the wage should be mapped to the y-axis.


## 2.1.2 geoms

# Geoms are the geometric objects (points, lines, bars, etc.) that can be placed on a graph.


ggplot(data = CPS85,
  mapping = aes(x = exper, y = wage)) +
    geom_point()   # add points


# delete outlier
library(dplyr)

plotdata <- filter(CPS85, wage < 40)

# redraw scatterplot

ggplot(data = plotdata,
       mapping = aes(x = exper, y = wage)) +
  geom_point()


# Make points blue, larger, and semi-transparent

# A number of parameters (options) can be specified in a geom_function. 
# Options for the geom_point function include color, size, and alpha. 
# These control the point color, size, and transparency, respectively. 
# Transparency ranges from 0 (completely transparent) to 1 (completely opaque). 
# Adding a degree of transparency can help visualize overlapping points.


ggplot(data = plotdata,
  mapping = aes(x = exper, y = wage)) +
    geom_point(color = "cornflowerblue", alpha = 0.7, size = 3)


# Next, let's add a line of best fit. We can do this with the geom_smooth function. 
# Options control the type of line (linear, quadratic, nonparametric),


# add a line of best fit.

ggplot(data = plotdata,
  mapping = aes(x = exper, y = wage)) +
    geom_point(color = "cornflowerblue", alpha = 0.7, size = 3) +
    geom_smooth(method = "lm", col = "red")

### 2.1.3 grouping

# In addition to mapping variables to the x and y axes, variables can be mapped to the color, 
# shape, size, transparency, and other visual characteristics of geometric objects. 

# indicate sex using color

ggplot(data = plotdata,
  mapping = aes(x = exper, y = wage, color = sex)) +
  geom_point(alpha = 0.7, size = 3) +
  geom_smooth(method = "lm", se = FALSE, size = 1.5) # (se = FALSE) was added to suppresses the CI

### 2.1.4 scales

# Scales control how variables are mapped to the visual characteristics of the plot. 
# Scale functions (which start with scale_) allow you to modify this mapping.

# modify the x and y axes and specify the colors to be used

library(scales)

ggplot(data = plotdata,
  mapping = aes(x = exper, y = wage, color = sex)) +
  geom_point(alpha = 0.7, size = 3) +
  geom_smooth(method = "lm", se = FALSE, size = 1.5) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5), label = scales::dollar) +
  scale_color_manual(values = c("indianred3", "cornflowerblue"))

# Here is a question. Is the relationship between experience, wages and sex the same for each job sector? 
# Let's repeat this graph once for each job sector in order to explore this.


### 2.1.5 facets

# Facets reproduce a graph for each level a given variable (or combination of variables). 
# reproduce plot for each level of job sector

ggplot(data = plotdata,
  mapping = aes(x = exper, y = wage, color = sex)) +
  geom_point(alpha = 0.7) + geom_smooth(method = "lm", se = FALSE) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5), label = scales::dollar) +
  scale_color_manual(values = c("indianred3", "cornflowerblue")) +
  facet_wrap( ~ sector, nrow = 2)


ggplot(data = plotdata,
       mapping = aes(x = exper, y = wage, color = sex)) +
  geom_point(alpha = 0.7) + geom_smooth(method = "lm", se = FALSE) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5), label = scales::dollar) +
  scale_color_manual(values = c("indianred3", "cornflowerblue")) +
  facet_grid(south ~ sector) # To facet your plot on the combination of two variables


# It appears that the differences between mean and women depend on the job sector under consideration

### 2.1.6 labels

# Graphs should be easy to interpret and informative labels are a key element in achieving this goal.
# Additionally, a custom title, subtitle, and caption can be added.

ggplot(data = plotdata,
  mapping = aes(x = exper, y = wage, color = sex)) +
  geom_point(alpha = 0.7) + geom_smooth(method = "lm", se = FALSE) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5), label = scales::dollar) +
  scale_color_manual(values = c("indianred3", "cornflowerblue")) +
  facet_wrap(~ sector) +
  labs(title = "Relationship between wages and experience",
       subtitle = "Current Population Survey",
       caption = "source: http://mosaic-web.org/",
       x = " Years of Experience",
       y = "Hourly Wage",
       color = "Gender")


# Now a viewer doesn't need to guess what the labels expr and wage mean, or where the data come from.

### 2.1.7 themes

## Finally, we can fine tune the appearance of the graph using themes. 
# Theme functions (which start with theme_) control background colors, fonts, 
# grid-lines, legend placement, and other non-data related features of the graph.

# use a minimalist theme

ggplot(data = plotdata,
  mapping = aes(x = exper, y = wage, color = sex)) +
  geom_point(alpha = 0.6) + geom_smooth(method = "lm", se = FALSE) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5), label = scales::dollar) +
  scale_color_manual(values = c("indianred3", "cornflowerblue")) +
  facet_wrap(~ sector) + 
  labs(title = "Relationship between wages and experience",
       subtitle = "Current Population Survey",
       caption = "source: http://mosaic-web.org/",
       x = " Years of Experience",
       y = "Hourly Wage",
       color = "Gender") + theme_minimal()
  
theme_test()             #  to analyze the different options below
  
  
theme_gray()
theme_minimal()
theme_bw()
theme_linedraw()
theme_light()
theme_dark()
theme_classic()
theme_void()
theme_test()


#### 2.2 Placing the data and mapping options

# Plots created with ggplot2 always start with the ggplot function. 
# In the examples above, the data and mapping options were placed in this function. 
# In this case they apply to each geom_ function that follows.



# placing color mapping in the ggplot function
ggplot(plotdata,
  aes(x = exper, y = wage, color = sex)) +
  geom_point(alpha = 0.7, size = 3) +
  geom_smooth(method = "lm", formula = y ~ poly(x,2), se = FALSE, size = 1.5)


# placing color mapping in the geom_point function
ggplot(plotdata, aes(x = exper, y = wage)) +
  geom_point(aes(color = sex), alpha = 0.7, size = 3) +
  geom_smooth(method = "lm", formula = y ~ poly(x,2), se = FALSE, size = 1.5)



#### 2.3 Graphs as objects

# prepare data

data(CPS85 , package = "mosaicData")
plotdata <- CPS85[CPS85$wage < 40, ]

# create scatterplot and save it
myplot <- ggplot(data = plotdata, aes(x = exper, y = wage)) +
  geom_point()

# print the graph
myplot

# make the points larger and blue
# then print the graph
myplot <- myplot + geom_point(size = 3, color = "blue")
myplot

# print the graph with a title and line of best fit
# but don't save those changes
myplot <- myplot + geom_smooth(method = "lm") +
  labs(title = "Mildly interesting graph")

# print the graph with a black and white theme
# but don't save those changes
myplot + theme_bw()


## Common Main Title for Multiple Plots Using ggplot2 & patchwork Packages

# First, we need to install and load the ggplot2 package:

library(patchwork)

# Next, we can create several different plot objects as shown below:

ggp1 <- ggplot(plotdata, aes(x = exper, y = wage, color = sex)) +           
  geom_point(alpha = 0.7, size = 2) + geom_smooth(method = "lm", se = FALSE, size = 1.5) 

ggp2 <- ggplot(plotdata, aes(x = wage,  fill = sex, color = sex)) +
  geom_density()

ggp3 <- ggplot(plotdata, aes(x = exper, color = sex)) +
  geom_histogram()

ggp4 <- ggplot(plotdata, aes(y = wage, color = sex)) +
  geom_boxplot()


# Now, we can use the syntax and functions provided by the patchwork package to draw multiple 
# ggplot2 graphs with a common legend as shown below:


ggp_all <- (ggp1 + ggp2) / (ggp3 + ggp4) +    # Create grid of plots with title
  plot_annotation(title = "My Multiplot Title") & theme(plot.title = element_text(hjust = 0.5))

ggp_all   



#### The end

#### Thanks you...!!!

# Syntax storage

savehistory(file = "saveGGplot2_2")










