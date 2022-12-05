library(raster)
library(RStoolbox)

setwd("C:/lab/")

K2015 <- brick("Kamchatka_Pre_2015.jpg")
plotRGB(K2015, r=1, g=2, b=3, stretch="lin")

K2016 <- brick("Kamchatka_Post_2016.jpg")
plotRGB(K2016, r=1, g=2, b=3, stretch="lin")
