# R code for visualising satellite images

library(terra)
library(imageRy)
library(viridis)
library(ggplot2)
library(patchwork)


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

# facciamo uno stack
b2<-im.import("sentinel.dolomites.b2.tif") #blue
b3<-im.import("sentinel.dolomites.b3.tif") #green
b4<-im.import("sentinel.dolomites.b4.tif") #red
b8<-im.import("sentinel.dolomites.b8.tif") #NIR
sentinel<-c(b2,b3,b4,b8)
#1=b2 blue, 
#2=b3 verde, 
#3=b4 rosso, 
#4=b8 NIR
#plotto tutto
plot(sentinel)
#plotto solo una banda
plot(sentinel[[4]]

#installo patchwork, funziona solo su ggplot2
#creo due plot p1 e p2
p1<-im.ggplot(b8)
p2<-im.ggplot(b4)
#plotto entrambe insieme
p1+p2

#plot sovrapposti per creare immagini RGB
#come si fa?
?im.rgb()
#facciamolo
im.plotRGB(sentinel, r=3, g=2, b=1)
#otteniamo un immagine natural colors, come vedrebbe un umano
#facciamo un "false color"
im.plotRGB(sentinel, r=4, g=3, b=2)
#vediamo che ci sono poche differenze
im.plotRGB(sentinel, r=3, g=4, b=2)
im.plotRGB(sentinel, r=2, g=4, b=3)
im.plotRGB(sentinel, r=1, g=3, b=4)
#alta correlazione tra le bande del visibili
#calcoliamola
pairs(sentinel)

im.plotRGB(sentinel, r=1, g=3, b=4)

#plotting in RGB con pacchetto Terra
plotRGB(sentinel, r=4, g=3, b=2)
#non funziona perchè a differenza di im.plotRGB, lo strech lineare non è effettuato
plotRGB(sentinel, r=4, g=3, b=2, stretch="lin")
#stretch non lineare
plotRGB(sentinel, r=4, g=3, b=2, stretch="hist")
#usato per discriminare alcuni elementi al costo di perdere informazioni sul reale

#semplifico il codice, non serve esplicitare le componenti
im.plotRGB(sentinel, 3, 2, 1)




