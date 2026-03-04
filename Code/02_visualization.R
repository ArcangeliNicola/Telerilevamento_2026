# R code for visualising satellite images

library(terra)
library(imageRy)

#lista dati
im.list()
# ?(nome funzione ) per capire cosa fanno le funzioni
#importo immagini
banda2 <- im.import("sentinel.dolomites.b2.tif")

#Changing color, numero tra parentesi dopo è la quantità di sfumature
cl<-colorRampPalette(c("#D2691E","darkolivegreen1","darkslategray1"))(100)
plot(banda2, col=cl)

#Viridis per creare palette per daltonici (non usare turbo)
#installo pacchetto dal CRAN
install.packages("viridis")

#Specificare all'inizio i pacchetti usati

#Viridis Palettes
plot(banda2, col=inferno(100))
plot(banda2, col=mako(100))

#exercise: plot band2 with gray scales palette
gw<-colorRampPalette(c("darkgrey","grey","lightgrey"))(100)
plot(banda2, col=gw)
#multiframe
par(mfrow=c(1,2))
#per chiudere il device
#dev.off()

#multiframe su imageRy
im.multiframe(1,2)















