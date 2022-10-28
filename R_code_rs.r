#Questo è il primo script che useremo a lezione
#install library("raster")

library(raster)

#settaggio cartella di lavoro(wd=working directory)
setwd("C:/lab/") #windows
#richiamo le immagini con la funzione brich
#import
l2011 <- brick("pp224r63_2011")
l2011
#faccio il plot dell'immagine
plot(l2011)
#colorRampPalette per editare la legenda del plot

colorRampPalette
cl <- colorRampPalette(c("black","grey","light grey")) (100) #100 rappresentano il num di colori intermedi
plot(l2011, col=cl)

