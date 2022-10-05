#Questo è il primo script che useremo a lezione
#install library("raster")

library(raster)

#settaggio cartella di lavoro(wd=working directory)
setwd("C:/lab/") #windows
#richiamo le immagini con la funzione brich
#import
l2011 <- brich("p224r63_2011.grd")

