library(raster)
library(RStoolbox) # for image viewing and variability calculation
library(ggplot2) # for ggplot plotting
library(patchwork) # multiframe with ggplot2 graphs


setwd("C:/lab/") # Windows

mini91 <- brick("atacama_28_12_1991.jpg")
mini18 <- brick("atacama_4_1_2018.jpg")

par(mfrow=c(2,1))
plotRGB(mini91, r=1, g=2, b=3, stretch="lin")
plotRGB(mini18, r=1, g=2, b=3, stretch="lin")

#minifiles <- list.files(pattern="atacama")
#minifiles
#import <- lapply(minifiles,raster)
#import

# Classifying the mine data
miniC91 <-unsuperClass(mini91, nClasses=4)
cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(miniC91$map, col=cl)


miniC18 <-unsuperClass(mini18, nClasses=4)
cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(miniC18$map, col=cl)
