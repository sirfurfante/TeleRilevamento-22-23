library(raster)
library(RStoolbox)

setwd("C:/lab/")

# NBR index to evaluete the fire area
#è stato calcolato NBR per individuare le zone bruciate
#tale procedimento è stato eseguito per il 2016, da marzo a settembre

#NBR 05_2016
B505_2016<-brick("B5_maggio.tif") # infrarosso
B705_2016<-brick("B7_maggio.tif") # infrarosso a onde corte
nbr05_2016<-(B505_2016-B705_2016)/(B505_2016+B705_2016) 

# lo plotto con una specifica palette di colori
cl<-colorRampPalette(c('purple','darkblue','red','orange','yellow','green'))(100) 
plot(nbr05_2016, col=cl, main="NBR 2016 - 05")

#NBR 07_2016
B507_2016<-brick("B5_luglio.tif") # infrarosso
B707_2016<-brick("B7_luglio.tif") # infrarosso a onde corte
nbr07_2016<-(B507_2016-B707_2016)/(B507_2016+B707_2016) 

plot(nbr07_2016, col=cl, main="NBR 2016 - 07")

#NBR 09_2016
B509_2016<-brick("B5_settembre.tif") # infrarosso
B709_2016<-brick("B7_settembre.tif") # infrarosso a onde corte
nbr09_2016<-(B509_2016-B709_2016)/(B509_2016+B709_2016) 

plot(nbr09_2016, col=cl, main="NBR 2016 - 09")

par(mfrow=c(1,3))

plot(nbr05_2016, col=cl, main="NBR 2016 - 05")
plot(nbr07_2016, col=cl, main="NBR 2016 - 07")
plot(nbr09_2016, col=cl, main="NBR 2016 - 09")

maggio <- brick("17_05_2016_Kachatka.jpg")
luglio <- brick("4_7_2016_Kamchatka.jpg")
settembre <- brick("6_9_2016_Kamchatka.jpg")
# layer 1 = NIR
# layer 2 = red
# layer 3 = green

par(mfrow=c(1,2))
plotRGB(maggio, r=1, g=2, b=3, stretch="lin")
plotRGB(luglio, r=1, g=2, b=3, stretch="lin") 
plotRGB(settembre, r=1, g=2, b=3, stretch="lin")


# DVI Difference Vegetation Index pre fire, 2016 (maggio)
dvi_pre = maggio[[1]] - maggio[[2]]
dvi_pre
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi_pre, col=cl)


# DVI Difference Vegetation Index post fire, 2016 (luglio)
dvi_post = luglio[[1]] - luglio[[2]]
dvi_post
plot(dvi_post, col=cl)

# DVI Difference Vegetation Index post fire, 2016 (settembre)
dvi_post1 = settembre[[1]] - settembre[[2]]
dvi_post1
plot(dvi_post1, col=cl)

# DVI difference in time
dvi_dif = dvi_pre - dvi_post
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(dvi_dif, col=cld)

dvi_dif1 = dvi_pre - dvi_post1
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(dvi_dif1, col=cld)

# NDVI can be used to compare images with a different radiometric resolution
# NDVI pre fire

ndvi_pre = dvi_pre / (maggio[[1]] + maggio[[2]])

# Multiframe with plotRGB on top of the NDVI image
par(mfrow=c(2,1))
plotRGB(maggio, r=1, g=2, b=3, stretch="lin")
plot(ndvi_pre, col=cl)

# NDVI post fire
ndvi_post = dvi_post / (luglio[[1]] + luglio[[2]])
# Multiframe with plotRGB on top of the NDVI image
par(mfrow=c(2,1))
plotRGB(luglio, r=1, g=2, b=3, stretch="lin")
plot(ndvi_post, col=cl)

# NDVI post fire 1
ndvi_post1 = dvi_post1 / (settembre[[1]] + settembre[[2]])
# Multiframe with plotRGB on top of the NDVI image
par(mfrow=c(2,1))
plotRGB(settembre, r=1, g=2, b=3, stretch="lin")
plot(ndvi_post1, col=cl)

# Multiframe with NDVI2015 on top of the NDVI2016 image
par(mfrow=c(3,1))
plot(ndvi_pre, col=cl, main="NDVI maggio")
plot(ndvi_post, col=cl, main="NDVI luglio")
plot(ndvi_post1, col=cl, main="NDVI settembre")

# Classifying the pre and post fire data 
#importo foto nasa, pre e post incendio
2015 <- brick("Kamchatka_Pre_2015")
2016 <- brick("Kamchatka_Post_2016")
pre <- unsuperClass(2015, nClasses=4)
post <- unsuperClass(2016, nClasses=4)

clc <- colorRampPalette(c('yellow','red','blue','black'))(100)

par(mfrow=c(2,1))
plot(pre$map, col=clc, main="PRE")
plot(post$map, col=clc, main="POST")

#frequencies
freq(pre$map)

freq(post$map)


s1 <- 
prop1 <- freq(pre$map) / s1

s2 <- 
prop2 <- freq(post$map) / s2

