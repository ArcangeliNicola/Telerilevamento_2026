library(terra)
library(imageRy)
setwd("C:/Scienze e gestione della natura/Primo anno/Telerilevamento")
getwd()

list.files()

richat<-flip(rast("richatstructure_oli_20260306.jpg"))
plot(richat)

png("figura.png")
plot(richat)
dev.off()

png("ric b1 e b2.png")
im.multiframe(2,1)
plot(richat[[1]])
plot(richat[[2]])
dev.off()












