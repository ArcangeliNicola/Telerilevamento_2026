#code to import data

library(terra)
library(viridis)
library(imageRy)
library(patchwork)

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

#calcoliamo l'NDVI
ndvi<-im.ndvi(stack, 3,2)

# export data
writeRaster(ndvi, "ndvi.tiff")

#importing data
ndvi2<-rast("ndvi.tiff")
plot(ndvi2)

#exporting a figure, no data
png("figura1.png")
im.multiframe(2,2)
plot(gre)
plot(red)
plot(nir)
plot(ndvi)
dev.off()

pdf("figura1.pdf")
im.multiframe(2,2)
plot(gre)
plot(red)
plot(nir)
plot(ndvi)
dev.off()

p1<-im.ggplot(ndvi)
p2<-im.ridgeline(ndvi, scale=1)
p1+p2

#immagine viene un po'male se importata
pdf("figura2.pdf")
p1<-im.ggplot(ndvi)
p2<-im.ridgeline(ndvi, scale=1)
p1+p2
dev.off()

#https://github.com/ducciorocchini/Telerilevamento_2026/tree/main/Drone2
#sostituire github.com con raw.githubusercontent.com
#rimuovere /tree
nirgit<-rast("https://raw.githubusercontent.com/ducciorocchini/Telerilevamento_2026/main/Drone2/DJI_20260409152942_0001_MS_G.TIF")


























