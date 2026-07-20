# Richiamo le library
library(terra)      # Pacchetto per maneggiare facilmente immagini satellitari
library(viridis)    # Pacchetto che aggiunge scale colori per utenti affetti da daltonismo
library(ggplot2)    # Per la creazione di grafici
library(imageRy)    # Pacchetto per svolgere più agilmente determinati compiti

# imposto la cartella di riferimento
setwd("C:\\Scienze e gestione della natura\\Primo anno\\Telerilevamento\\EsameVaia")
getwd()
list.files() # richiama l'elenco dei files contenuti nella cartella

# richiamo le bande necessarie alle analisi scelte (funzione "rast()") e le capovolgo per riposizionarle in maniera corretta (funzione "flip()")
b18<-flip(rast("2018-09-26-00_00_2018-09-26-23_59_Sentinel-2_L1C_B02_(Raw).jpg")) # blu 2018
g18<-flip(rast("2018-09-26-00_00_2018-09-26-23_59_Sentinel-2_L1C_B03_(Raw).jpg")) # verde 2018
r18<-flip(rast("2018-09-26-00_00_2018-09-26-23_59_Sentinel-2_L1C_B04_(Raw).jpg")) # rosso 2018
nir18<-flip(rast("2018-09-26-00_00_2018-09-26-23_59_Sentinel-2_L1C_B08_(Raw).jpg")) # Near-Infrared 2018
swir18<-flip(rast("2018-09-26-00_00_2018-09-26-23_59_Sentinel-2_L1C_B11_(Raw).jpg")) # Short-Wave Infrared 2018

b19<-flip(rast("2019-09-21-00_00_2019-09-21-23_59_Sentinel-2_L1C_B02_(Raw).jpg")) # blu 2019
g19<-flip(rast("2019-09-21-00_00_2019-09-21-23_59_Sentinel-2_L1C_B03_(Raw).jpg")) # verde 2019
r19<-flip(rast("2019-09-21-00_00_2019-09-21-23_59_Sentinel-2_L1C_B04_(Raw).jpg")) # rosso 2019
nir19<-flip(rast("2019-09-21-00_00_2019-09-21-23_59_Sentinel-2_L1C_B08_(Raw).jpg")) # Near-Infrared 2019
swir19<-flip(rast("2019-09-21-00_00_2019-09-21-23_59_Sentinel-2_L1C_B11_(Raw).jpg")) # Short-Wave Infrared 2019

b25<-flip(rast("2025-09-19-00_00_2025-09-19-23_59_Sentinel-2_L1C_B02_(Raw).jpg")) # blu 2025
g25<-flip(rast("2025-09-19-00_00_2025-09-19-23_59_Sentinel-2_L1C_B03_(Raw).jpg")) # verde 2025
r25<-flip(rast("2025-09-19-00_00_2025-09-19-23_59_Sentinel-2_L1C_B04_(Raw).jpg")) # rosso 2025
nir25<-flip(rast("2025-09-19-00_00_2025-09-19-23_59_Sentinel-2_L1C_B08_(Raw).jpg")) # Near-Infrared 2025
swir25<-flip(rast("2025-09-19-00_00_2025-09-19-23_59_Sentinel-2_L1C_B11_(Raw).jpg")) # Short-Wave Infrared 2025

# effettuo il ricampionamento della banda dello SWIR ad una risoluzione spaziale di 10m per poterla confrontare con le altre bande (B2, B3, B4, B8)
swir18<-resample(swir18, b18) # ricampiona il primo oggetto indicato alla risoluzione del secondo
swir19<-resample(swir25, b19)
swir25<-resample(swir25, b25)

# compongo gli stack
T18<-c(r18, g18, b18, nir18, swir18)
T19<-c(r19, g19, b19, nir19, swir19)
T25<-c(r25, g25, b25, nir25, swir25)

# rinomino i componenti degli stack creati tramite la funzione "names()"
names(T18) <- c("Rosso (B4)", "Verde (B3)", "Blu (B2)", "NIR (B8)", "SWIR (B12)")
names(T19) <- c("Rosso (B4)", "Verde (B3)", "Blu (B2)", "NIR (B8)", "SWIR (B12)")
names(T25) <- c("Rosso (B4)", "Verde (B3)", "Blu (B2)", "NIR (B8)", "SWIR (B12)")

# visualizzo le singole bande tramite gli stack
plot(T18, col = viridis(100))
plot(T19, col = viridis(100))
plot(T25, col = viridis(100))

# esportazione delle singole bande per ogni periodo analizzato
png("Tutte_le_bande_2018.png") # 2018
plot(T18, col = viridis(100))
dev.off()

png("Tutte_le_bande_2019.png") # 2019
plot(T19, col = viridis(100))
dev.off()

png("Tutte_le_bande_2025.png") # 2025
plot(T25, col = viridis(100))
dev.off()

# visualizzazione delle immagini a colori veritieri e falsati nello stesso spazio grafico
im.multiframe(2,3) # per visualizzare tutte le immagini seguenti contemporaneamente
im.plotRGB(T18, 1, 2, 3) # vengono indicati solo le posizioni all'interno degli stack, l'ordine è rosso-verde-blu
im.plotRGB(T19, 1, 2, 3)
im.plotRGB(T25, 1, 2, 3)
im.plotRGB(T18, 4, 2, 3) # viene inserita la banda del NIR al posto di quella del rosso per evidenziare la vegetazione
im.plotRGB(T19, 4, 2, 3)
im.plotRGB(T25, 4, 2, 3)

im.multiframe(2,3) # per visualizzare tutte le immagini seguenti contemporaneamente
plotRGB(T18, 1, 2, 3, stretch = "lin", main = "2018 (pre)") # vengono indicati solo le posizioni all'interno degli stack, l'ordine è rosso-verde-blu
plotRGB(T19, 1, 2, 3, stretch = "lin", main = "2019 (post)") 
plotRGB(T25, 1, 2, 3, stretch = "lin", main = "2025 (recente)")
plotRGB(T18, 4, 2, 3, stretch = "lin", main = "2018 falsi colori") # viene inserita la banda del NIR al posto di quella del rosso per evidenziare la vegetazione
plotRGB(T19, 4, 2, 3, stretch = "lin", main = "2019 falsi colori")
plotRGB(T25, 4, 2, 3, stretch = "lin", main = "2025 falsi colori")

# è possibile chiudere il multiframe con la funzione dev.off()

# esportazione delle immagini ottenute
png("Colori veritieri e falsati.png")
im.multiframe(2,3) # per visualizzare tutte le immagini seguenti contemporaneamente
plotRGB(T18, 1, 2, 3, stretch = "lin", main = "2018 (pre)") # vengono indicati solo le posizioni all'interno degli stack, l'ordine è rosso-verde-blu
plotRGB(T19, 1, 2, 3, stretch = "lin", main = "2019 (post)")
plotRGB(T25, 1, 2, 3, stretch = "lin", main = "2025 (recente)")
plotRGB(T18, 4, 2, 3, stretch = "lin", main = "2018 falsi colori") # viene inserita la banda del NIR al posto di quella del rosso per evidenziare la vegetazione
plotRGB(T19, 4, 2, 3, stretch = "lin", main = "2019 falsi colori")
plotRGB(T25, 4, 2, 3, stretch = "lin", main = "2025 falsi colori")
dev.off()

# calcolo dell'indice di vegetazione DVI
dvi18<-im.dvi(T18,4,1) # la funzione "im.dvi()" elabora automaticamente le bande
dvi19<-im.dvi(T19,4,1)
dvi25<-im.dvi(T25,4,1)
DVI<-c(dvi18, dvi19, dvi25) # si crea uno stack con tutti gli indici DVI
names(DVI) <- c("DVI 2018", "DVI 2019", "DVI 2025") # si rinominano le componenti
plot(DVI, col = mako(100)) 

# esportazione delle immagini ottenute, indice DVI
png("DVI.png")
plot(DVI, col = mako(100))
dev.off()


im.multiframe(1,3)
plot(dvi18, col=viridis(100))
plot(dvi19, col=viridis(100))
plot(dvi25, col=viridis(100))

#NDVI
ndvi18<-im.ndvi(T18,4,1)
ndvi19<-im.ndvi(T19,4,1)
ndvi25<-im.ndvi(T25,4,1)

im.multiframe(1,3)
plot(ndvi18, col=inferno(100))
plot(ndvi19, col=inferno(100))
plot(ndvi25, col=inferno(100))

#Ridgeline
ndvi<-c(ndvi18,ndvi19,ndvi25)
im.ridgeline(ndvi, scale=1, palette="inferno")

#delta ndvi
Dndvi19_18<-ndvi19 - ndvi18
Dndvi25_18<-ndvi25 - ndvi18

im.multiframe(1,2)
plot(Dndvi19_18, col=inferno(100))
plot(Dndvi25_18, col=inferno(100))
