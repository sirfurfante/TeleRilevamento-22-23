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


# dev.off()

# Landsat ETM+
# b1 = blu
# b2 = verde
# b3 = rosso
# b4 = infrarosso vicino NIR

# plot della banda del blu - B1_sre
plot(l2011$B1_sre) # trinity
# or
plot(l2011[[1]]) # neo

plot(l2011$B1_sre) 
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot(l2011$B1_sre, col=cl) 

# plot b1 from dark blue to blue to light blue
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(l2011$B1_sre, col=clb) 

# let's export the image and let it appear in the lab folder: kind of magic!
pdf("banda1.pdf")
plot(l2011$B1_sre, col=clb) 
dev.off()

png("banda1.png")
plot(l2011$B1_sre, col=clb) 
dev.off()

# plot b2 from dark green to green to light green
clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(l2011$B2_sre, col=clg) 

# multiframe
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb) 
plot(l2011$B2_sre, col=clg) 
dev.off()

# export multiframe plot
pdf("multiframe.pdf")
par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb) 
plot(l2011$B2_sre, col=clg) 
dev.off()

# exercise: revert the multiframe
par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb) 
plot(l2011$B2_sre, col=clg) 

# let's plot the first four bands
par(mfrow=c(2,2))
# blue
plot(l2011$B1_sre, col=clb) 
# green
plot(l2011$B2_sre, col=clg) 
# red
clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(l2011$B3_sre, col=clr)
# NIR
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011$B4_sre, col=clnir)
#or
plot(l2011[[4]])
