library(raster)
library(RStoolbox)

setwd("C:/lab/")

marzo<- brick("09_03_2016_099021_02_T1.jpg")
maggio<- brick("12_05_2016_99021_02_T1.jpg")
luglio<- brick("15_07_2016_99021_02_T1.jpg")
settembre<- brick("01_09_2016_99021_02_T1.jpg")

cl<-colorRampPalette(c('purple','darkblue','red','orange','yellow','green'))(100) 
par(mfrow=c(2,2))
plotRGB(marzo, col=cl, main="marzo_2016")
plotRGB(maggio, col=cl, main="maggio_2016")
plotRGB(luglio, col=cl, main="luglio_2016")
plotRGB(settembre, col=cl, main="settembre_2016")

# NBR index to evaluete the fire area
#è stato calcolato NBR per individuare le zone bruciate
#tale procedimento è stato eseguito per il 2016, da marzo a settembre

#NBR 03_2016
B503_2016<-brick("B503_2016.TIF") # infrarosso
B703_2016<-brick("B703_2016.TIF") # infrarosso a onde corte
nbr03_2016<-(B503_2016-B703_2016)/(B503_2016+B703_2016) 

# lo plotto con una specifica palette di colori
cl<-colorRampPalette(c('purple','darkblue','red','orange','yellow','green'))(100) 
plot(nbr03_2016, col=cl, main="NBR 2016 - 03")

#NBR 05_2016
B505_2016<-brick("B505_2016.TIF") # infrarosso
B705_2016<-brick("B705_2016.TIF") # infrarosso a onde corte
nbr05_2016<-(B505_2016-B705_2016)/(B505_2016+B705_2016) 

# lo plotto con una specifica palette di colori
cl<-colorRampPalette(c('purple','darkblue','red','orange','yellow','green'))(100) 
plot(nbr05_2016, col=cl, main="NBR 2016 - 05")

#NBR 07_2016
B507_2016<-brick("B507_2016.TIF") # infrarosso
B707_2016<-brick("B707_2016.TIF") # infrarosso a onde corte
nbr07_2016<-(B507_2016-B707_2016)/(B507_2016+B707_2016) 

# lo plotto con una specifica palette di colori
cl<-colorRampPalette(c('purple','darkblue','red','orange','yellow','green'))(100) 
plot(nbr07_2016, col=cl, main="NBR 2016 - 07")

#NBR 09_2016
B509_2016<-brick("B509_2016.TIF") # infrarosso
B709_2016<-brick("B709_2016.TIF") # infrarosso a onde corte
nbr09_2016<-(B509_2016-B709_2016)/(B509_2016+B709_2016) 

# lo plotto con una specifica palette di colori
cl<-colorRampPalette(c('purple','darkblue','red','orange','yellow','green'))(100) 
plot(nbr09_2016, col=cl, main="NBR 2016 - 09")

par(mfrow=c(1,4))
plot(nbr03_2016, col=cl, main="NBR 2016 - 03")
plot(nbr05_2016, col=cl, main="NBR 2016 - 05")
plot(nbr07_2016, col=cl, main="NBR 2016 - 07")
plot(nbr09_2016, col=cl, main="NBR 2016 - 09")

K2015 <- brick("Kamchatka_Pre_2015.jpg")
plotRGB(K2015, r=1, g=2, b=3, stretch="lin")

K2016 <- brick("Kamchatka_Post_2016.jpg")
plotRGB(K2016, r=1, g=2, b=3, stretch="lin")

# layer 1 = NIR
# layer 2 = red
# layer 3 = green

par(mfrow=c(1,2))
plotRGB(K2015, r=1, g=2, b=3, stretch="lin")
plotRGB(K2016, r=1, g=2, b=3, stretch="lin") 


# DVI Difference Vegetation Index pre fire, 2015
dvi2015 = K2015[[1]] - K2015[[2]]
# or:
# dviK2015 = k2015$Kamchatka_Pre_2015.1 - k2015$Kamchatka_Pre_2015.2
dvi2015

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi2015, col=cl)


# DVI Difference Vegetation Index post fire, 2016
dvi2016 = K2016[[1]] - K2016[[2]]
# or:
# dvik2016 = k2016$Kamchatka_Post_2016.1 - k2016$Kamchatka_Post_2016.2
dvi2016

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
plot(dvi2016, col=cl)

# DVI difference in time
dvi_dif = dvi2015 - dvi2016
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(dvi_dif, col=cld)

# NDVI can be used to compare images with a different radiometric resolution
# NDVI 2015

#dvi2015 = K2015[[1]] -K2015[[2]]
ndvi2015 = dvi2015 / (K2015[[1]] + K2015[[2]])
# or
#ndvi2015 = (K2015[[1]] - K2015[[2]]) / (K2015[[1]] + K2015[[2]])

# Multiframe with plotRGB on top of the NDVI image
par(mfrow=c(2,1))
plotRGB(K2015, r=1, g=2, b=3, stretch="lin")
plot(ndvi2015, col=cl)

# NDVI 2016

#dvi2016 = K2016[[1]] - K2016[[2]]
ndvi2016 = dvi2016 / (K2016[[1]] + K2016[[2]])
# or
# ndvi2016 = (K2016[[1]] - K2016[[2]]) / (K2016[[1]] + K2016[[2]])

# Multiframe with plotRGB on top of the NDVI image
par(mfrow=c(2,1))
plotRGB(K2016, r=1, g=2, b=3, stretch="lin")
plot(ndvi2016, col=cl)

# Multiframe with NDVI2015 on top of the NDVI2016 image
par(mfrow=c(2,1))
plot(ndvi2015, col=cl)
plot(ndvi2016, col=cl)

# Automatic spectral indices by the spectralIndices function
si2015 <- spectralIndices(K2015, green=3, red=2, nir=1)
si2016 <- spectralIndices(K2016, green=3, red=2, nir=1)


plot(si2015, col=cl)
plot(si2016, col=cl)

l2015 <- brick("agosto2015.tif")
l2016 <- brick("luglio2016.tif")

par(mfrow=c(2,1))
plot(l2015, col=cl, main="PRE")
plot(l2016, col=cl, main="POST")


# Classifying the pre and post fire data 
pre <- unsuperClass(K2015, nClasses=4)
post <- unsuperClass(K2016, nClasses=4)

cl <- colorRampPalette(c('yellow','black','red'))(100)

par(mfrow=c(2,1))
plot(pre$map, col=cl, main="PRE")
plot(post$map, col=cl, main="POST")

freq(pre$map)
