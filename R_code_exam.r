library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
setwd("C:/lab/")

# NBR index to evaluete the fire area
#è stato calcolato NBR per individuare le zone bruciate
#tale procedimento è stato eseguito per il 2016, da marzo a settembre

#NBR 05_2016 pre incendio
B505_2016<-brick("B5_maggio.tif") # infrarosso
B705_2016<-brick("B7_maggio.tif") # infrarosso a onde corte
nbr05_2016<-(B505_2016-B705_2016)/(B505_2016+B705_2016) 

#NBR 06_2016 pre incendio
B506_2016<-brick("B5_giugno.tif") # infrarosso
B706_2016<-brick("B7_giugno.tif") # infrarosso a onde corte
nbr06_2016<-(B506_2016-B706_2016)/(B506_2016+B706_2016) 


#NBR 07_2016
B507_2016<-brick("B5_luglio.tif") # infrarosso
B707_2016<-brick("B7_luglio.tif") # infrarosso a onde corte
nbr07_2016<-(B507_2016-B707_2016)/(B507_2016+B707_2016) 


#NBR 09_2016
B509_2016<-brick("B5_settembre.tif") # infrarosso
B709_2016<-brick("B7_settembre.tif") # infrarosso a onde corte
nbr09_2016<-(B509_2016-B709_2016)/(B509_2016+B709_2016) 

# li plotto con una specifica palette di colori
cl<-colorRampPalette(c('purple','darkblue','red','orange','yellow','green'))(100) 
par(mfrow=c(1,4))
plot(nbr05_2016, col=cl, main="NBR 2016 - 05")
plot(nbr06_2016, col=cl, main="NBR 2016 - 06")
plot(nbr07_2016, col=cl, main="NBR 2016 - 07")
plot(nbr09_2016, col=cl, main="NBR 2016 - 09")


#NDVI mediante lo studio delle bande B5(infrarosso) e B4(rosso)
#B5 già caricato per il calcolo del NBR
B405_2016 <- brick("B4_maggio.tif") #rosso
ndvi_maggio <- (B505_2016-B405_2016)/(B505_2016+B405_2016)
#viene assegnata la palette cromatica e in seguito viene plottato
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(ndvi_maggio, col=cl, main="NDVI_05_2016")

B406_2016 <- brick("B4_giugno.tif") #rosso
ndvi_giugno <- (B506_2016-B406_2016)/(B506_2016+B406_2016)
plot(ndvi_giugno, col=cl, main="NDVI_06_2016")

B407_2016 <- brick("B4_luglio.tif") #rosso
ndvi_luglio <- (B507_2016-B407_2016)/(B507_2016+B407_2016)
plot(ndvi_luglio, col=cl, main="NDVI_07_2016")

B409_2016 <- brick("B4_settembre.tif") #rosso
ndvi_settembre <- (B509_2016-B409_2016)/(B509_2016+B409_2016)
plot(ndvi_settembre, col=cl, main="NDVI_09_2016")

#in seguito e' stata fatta la differenza tra gli NDVI di settembre, luglio e di maggio

diffNDVI<-(ndvi_luglio-ndvi_giugno)
diffNDVI1<-(ndvi_settembre-ndvi_giugno)

cls<-colorRampPalette(c('pink','red','white','blue'))(100)
plot(diffNDVI, col=cls, main="Differenza NDVI giugno-luglio")
plot(diffNDVI1,col=cls,main="Differenza NDVI giugno-settembre")


# Classifying the pre and post fire data 
#importo foto nasa, pre e post incendio
k2015 <- brick("Kamchatka_Pre_2015.jpg")
k2016 <- brick("Kamchatka_Post_2016.jpg")
pre <- unsuperClass(k2015, nClasses=3)
post <- unsuperClass(k2016, nClasses=3)

clc <- colorRampPalette(c('yellow','red','blue','black'))(100)

par(mfrow=c(2,1))
plot(pre$map, col=clc, main="PRE")
plot(post$map, col=clc, main="POST")

#frequencies
freq(pre$map)
#     value   count
#[1,]     1  374038 nuvole
#[2,]     2 2368907 foresta
#[3,]     3  402783 parti scure/ombre

freq(post$map)
#     value   count
#[1,]     1  389348 nuvole
#[2,]     2 1135565 foresta
#[3,]     3 1620815 incendio+parti scure/ombre


s1 <- 374038 + 2368907 + 402783 
prop1 <- freq(pre$map) / s1
#            value     count
#[1,] 3.178914e-07 0.1189035 nuvole
#[2,] 6.357829e-07 0.7530553 foresta
#[3,] 9.536743e-07 0.1280413 parti scure/ombre

s2 <-  389348 + 1135565 + 1620815
prop2 <- freq(post$map) / s2
#            value     count
#[1,] 3.178914e-07 0.1237704 nuvole
#[2,] 6.357829e-07 0.3609864 foresta
#[3,] 9.536743e-07 0.5152432 incendio+parti scure/ombre

# build a dataframe
cover <- c("Foresta","Nuvole","Incendio+Ombre")
percent_2015 <- c(75, 11, 12)
percent_2016 <- c(36, 12, 51)

percentages <- data.frame(cover, percent_2015, percent_2016)
percentages

# let's plot them!
ggplot(percentages, aes(x=cover, y=percent_2015, color=cover)) + geom_bar(stat="identity", fill="white")+ geom_text(aes(label=percent_2015)) 
position=position_dodge((width=0.7), vjust=0.25, size=6)
   
                                                                                                                      
ggplot(percentages, aes(x=cover, y=percent_2016, color=cover)) + geom_bar(stat="identity", fill="white")+ geom_text(aes(label=percent_2016))
+ position=position_dodge(width=0.9, vjust=-0.25, size=6)

p1 <- ggplot(percentages, aes(x=cover, y=percent_2015, color=cover)) + geom_bar(stat="identity", fill="white")+ geom_text(aes(label=percent_2015)) 
p2 <- ggplot(percentages, aes(x=cover, y=percent_2016, color=cover)) + geom_bar(stat="identity", fill="white")+ geom_text(aes(label=percent_2016))

grid.arrange(p1, p2, nrow=1)






