library(raster)
library(RStoolbox)

setwd("C:/lab/")

K2015 <- brick("Kamchatka_Pre_2015.jpg")
plotRGB(K2015, r=1, g=2, b=3, stretch="lin")

K2016 <- brick("Kamchatka_Post_2016.jpg")
plotRGB(K2016, r=1, g=2, b=3, stretch="lin")

# layer 1 = NIR
# layer 2 = red
# layer 3 = green

par(mfrow=c(2,1))
plotRGB(k2015, r=1, g=2, b=3, stretch="lin")
plotRGB(k2016, r=1, g=2, b=3, stretch="lin") 

# DVI Difference Vegetation Index pre fire, 2015
dvi2015 = k2015[[1]] - k2015[[2]]
# or:
# dvik2015 = k2015$Kamchatka_Pre_2015.1 - k2015$Kamchatka_Pre_2015.2
dvi2015

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi2015, col=cl)


# DVI Difference Vegetation Index post fire, 2016
dvi2016 = k2016[[1]] - k2016[[2]]
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

#dvi2015 = k2015[[1]] - k2015[[2]]
ndvi2015 = dvi2015 / (k2015[[1]] + k2015[[2]])
# or
ndvi2015 = (k2015[[1]] - k2015[[2]]) / (k2015[[1]] + k2015[[2]])

# Multiframe with plotRGB on top of the NDVI image
par(mfrow=c(2,1))
plotRGB(k2015, r=1, g=2, b=3, stretch="lin")
plot(ndvi2015, col=cl)

# NDVI 2016

#dvi2016 = k2016[[1]] - k2016[[2]]
ndvi2016 = dvi2016 / (k2016[[1]] + k2016[[2]])
# or
ndvi2016 = (k2016[[1]] - k2016[[2]]) / (k2016[[1]] + k2016[[2]])

# Multiframe with plotRGB on top of the NDVI image
par(mfrow=c(2,1))
plotRGB(k2016, r=1, g=2, b=3, stretch="lin")
plot(ndvi2016, col=cl)

# Multiframe with NDVI2015 on top of the NDVI2016 image
par(mfrow=c(2,1))
plot(ndvi2015, col=cl)
plot(ndvi2016, col=cl)

# Automatic spectral indices by the spectralIndices function
si2015 <- spectralIndices(k2015, green=3, red=2, nir=1)
si2016 <- spectralIndices(k2016, green=3, red=2, nir=1)

par(mfrow=c(2,1))
plot(si2015, col=cl)
plot(si2016, col=cl)




