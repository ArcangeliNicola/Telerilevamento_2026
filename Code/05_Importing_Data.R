#code to import data

library(terra)
library(viridis)
library(imageRy)

setwd("C:/Scienze e gestione della natura/Primo anno/Telerilevamento")
getwd()

#list of files 
list.files()

gre<-rast("DJI_20260409152942_0001_MS_G.tiff")
#flippiamo
gre<-flip(gre)
#plot
plot(gre, col=mako(100))

red<-flip(rast("DJI_20260409152942_0001_MS_R.tiff"))
nir<-flip(rast("DJI_20260409152942_0001_MS_NIR.tiff"))

#stack
stack<-c(gre, red, nir)
plot(stack)
#ricordarsi lo stretch
plotRGB(stack, r=3,g=2,b=1, stretch="lin")
#stretch per valori intermedi 
plotRGB(stack, r=3,g=2,b=1, stretch="hist")

im.multiframe(1,2)
plotRGB(stack, r=3,g=2,b=1, stretch="lin")
plotRGB(stack, r=3,g=2,b=1, stretch="hist")
























