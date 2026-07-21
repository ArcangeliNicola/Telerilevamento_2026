# Richiamo le library
library(terra)      # Pacchetto per maneggiare facilmente immagini satellitari
library(viridis)    # Pacchetto che aggiunge scale colori per utenti affetti da daltonismo
library(ggplot2)    # Per la creazione di grafici
library(imageRy)    # Pacchetto per svolgere più agilmente determinati compiti
library(BSI)        # Pacchetto per calcolare agilmente il Bare Soil Index

# imposto la cartella di riferimento
setwd("C:\\Scienze e gestione della natura\\Primo anno\\Telerilevamento\\Esame Vaia")
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
dvi<-c(dvi18, dvi19, dvi25)
names(dvi)<-c("DVI 2018","DVI 2019","DVI 2025")
plot(dvi, col = mako(100))

# esportazione delle immagini ottenute, indice DVI
png("DVI2.png")
plot(dvi, col = mako(100))
dev.off()

# calcolo dell'indice di vegetazione NDVI
ndvi18<-im.ndvi(T18,4,1)
ndvi19<-im.ndvi(T19,4,1)
ndvi25<-im.ndvi(T25,4,1)
ndvi<-c(ndvi18, ndvi19, ndvi25)
names(ndvi)<-c("NDVI 2018","NDVI 2019","NDVI 2025")
# si utilizza il range 0-1 in quanto si osservano pochi valori al di sotto di 0, che saranno indicati come no-data e colorati di bianco
# l'utilizzo di un range definito permette di confrontare le colorazioni tra loro evidenziando maggiormente le differenze
plot(ndvi, col=inferno(100), range = c(0,1)) 

# esportazione delle immagini ottenute, indice NDVI
png("NDVI.png")
plot(ndvi, col=inferno(100), range = c(0,1)) 
dev.off()

# calcolo dell'indice BSI
bsi18<-bsi(T18, 1, 3, 4, 5) # utilizzo la funzione bsi() ottenuta dal pacchetto "BSI" per evitare di scrivere la formula completa
bsi19<-bsi(T19, 1, 3, 4, 5)
bsi25<-bsi(T25, 1, 3, 4, 5)
#visualizzazione dell'indice
bsi<-c(bsi18, bsi19, bsi25)
names(bsi)<-c("BSI 2018", "BSI 2019", "BSI 2025")
plot(bsi, col = inferno(100), range = c(-1,1))

# esportazione delle immagini ottenute, indice BSI
png("BSI.png")
plot(bsi, col = inferno(100), range = c(-1,1))
dev.off()

#Ridgeline plot NDVI
im.ridgeline(ndvi, scale=1, palette="viridis") # la funzione im.ridgeline() permette di creare velocemente un ridgeline plot

#esportazione del ridgeline plot NDVI
png("Ridgeline NDVI.png", width = 700, height = 350)
im.ridgeline(ndvi, scale=1, palette="viridis")
dev.off()

#Ridgeline plot BSI
im.ridgeline(bsi, scale=1, palette="viridis")

#esportazione del ridgeline plot BSI
png("Ridgeline BSI.png", width = 700, height = 350)
im.ridgeline(bsi, scale=1, palette="viridis")
dev.off()

# classificazione dell'NDVI in due categorie, viene utilizzato lo stesso seed per ottenere informazioni comparabili
ndvi18c<-im.classify(ndvi18, num_cluster=2, seed=42)
ndvi19c<-im.classify(ndvi19, num_cluster=2, seed=42)
ndvi25c<-im.classify(ndvi25, num_cluster=2, seed=42)
ndvic<-c(ndvi18c, ndvi19c ,ndvi25c)
plot(ndvic, col = cividis(100))

# classificazione del BSI in due categorie, viene utilizzato lo stesso seed per ottenere informazioni comparabili
bsi18c<-im.classify(bsi18, num_cluster=2, seed=42, do_plot = FALSE) # non è necessario che venga visulizzato graficamente
bsi19c_raw<-im.classify(bsi19, num_cluster=2, seed=42, do_plot = FALSE) # viene aggiunta la sezione "raw" in quanto l'oggetto sarà sottoposto ad ulteriori modifiche
bsi25c_raw<-im.classify(bsi25, num_cluster=2, seed=42, do_plot = FALSE) 

bsi19c = subst(bsi19c_raw, from = c(1, 2), to = c(2, 1)) # vengono invertite le celle con valore 1 e 2 in modo da ottenere un risultato più facilmente comparabile
bsi25c = subst(bsi25c_raw, from = c(1, 2), to = c(2, 1))

bsic<-c(bsi18c,bsi19c,bsi25c)
names(bsic)<-c("BSI classificato 2018", "BSI classificato 2019","BSI classificato 2025")

legend_bsi<-c("Vegetazione arborea", "Vegetazione erbacea o suolo nudo") # crezione dei nomi per la legenda
plot(bsic, col = viridis(100), legend = FALSE)
legend("bottomright", legend = legend_bsi, fill = cividis(2), bg = "white") # impostazione della legenda

f2018 <- freq(bsi18c) 
perc2018 <- (f2018$count / ncell(bsi18c)) * 100

f2019 <- freq(bsi19c) 
perc2019 <- (f2019$count / ncell(bsi19c)) * 100
perc2019

f2025 <- freq(bsi25c) 
perc2025 <- (f2025$count / ncell(bsi25c)) * 100
perc2025

# Table
tab_perc <- data.frame(
  Classe = c("Foresta", "Veg. erbacea o suolo scoperto"),
  BSI_2018 = c(68, 32),
  BSI_2019 = c(48, 52),
  BSI_2025 = c(46, 54))

png("Tab_perc.png", width = 700, height = 350)
plot(tab_perc)
dev.off()




ggplot(tab_perc, aes(x=class, y=perc2018, color=class)) + # structure



















