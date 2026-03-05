# R code for visualising satellite images

library(terra)
library(imageRy)
library(viridis)

#lista dati
im.list()
# ?(nome funzione ) per capire cosa fanno le funzioni
#importo immagini
b2 <- im.import("sentinel.dolomites.b2.tif")

#Changing color, numero tra parentesi dopo è la quantità di sfumature
cl<-colorRampPalette(c("#D2691E","darkolivegreen1","darkslategray1"))(100)
plot(banda2, col=cl)

#Viridis per creare palette per daltonici (non usare turbo)
#installo pacchetto dal CRAN
install.packages("viridis")
library(viridis)

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

#importo banda verde (3)
b3 <- im.import("sentinel.dolomites.b3.tif")
#cambiare palette secondo il pacchetto viridis
plot(b3, col=plasma(100))
#importo banda 4 rosso 665 nm
b4 <- im.import("sentinel.dolomites.b4.tif")
#importo banda 8 near infrared
b8 <- im.import("sentinel.dolomites.b8.tif")

#esercizio fare multiframe con le 4 bande e colori associati es banda blu in blu
cb2<-colorRampPalette(c("blue","blue4","lightblue"))(100)
cb3<-colorRampPalette(c("green","green4", "palegreen"))(100)
cb4<-colorRampPalette(c("red","red4", "lightred"))(100)
cb8<-colorRampPalette(c("lightgoldenrod","lightgoldenrod4"))(100)
im.multiframe(2,2)
plot(b2,col=cb2)
plot(b3,col=cb3)
plot(b4,col=cb4)
plot(b8,col=cb8)

sentinel<-c(b2,b3,b4,b8)
plot(sentinel)
#per avere informazioni su un oggetto basta scriverne il nome 
b2
# funzione names(oggetto) per sapere i nomi dei vettori che costituiscono un oggetto
names(sentinel)
#per plottare un solo oggetto da un oggetto che lo contiene
plot(sentinel$sentinel.dolomites.b4.tif)
# layer1=b2 layer2=b3 layer3=b4 layer4=b8
# per richiamare un singolo layer e creare un subset
plot(sentinel[[4]])

#stack











