
> library(terra)
terra 1.8.93
Messaggio di avvertimento:
il pacchetto ‘terra’ è stato creato con R versione 4.5.2 
> library(imageRy)
> library(viridis)
Caricamento del pacchetto richiesto: viridisLite
Messaggi di avvertimento:
1: il pacchetto ‘viridis’ è stato creato con R versione 4.5.2 
2: il pacchetto ‘viridisLite’ è stato creato con R versione 4.5.2 
> library(ggplot2)
Messaggio di avvertimento:
il pacchetto ‘ggplot2’ è stato creato con R versione 4.5.2 
> library(patchwork)

Caricamento pacchetto: ‘patchwork’

Il seguente oggetto è mascherato da ‘package:terra’:

    area

Messaggio di avvertimento:
il pacchetto ‘patchwork’ è stato creato con R versione 4.5.2 
> setwd("C:\\Scienze e gestione della natura\\Primo anno\\Telerilevamento\\Esame")
> getwd()
[1] "C:/Scienze e gestione della natura/Primo anno/Telerilevamento/Esame"
> list.files()
[1] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L2A_B01_(Raw).jpg" 
[2] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L2A_B02_(Raw).jpg" 
[3] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L2A_B03_(Raw).jpg" 
[4] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L2A_B04_(Raw).jpg" 
[5] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L2A_B05_(Raw).jpg" 
[6] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L2A_True_color.jpg"
 
> rast("2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L2A_True_color.jpg")
class       : SpatRaster 
size        : 776, 705, 3  (nrow, ncol, nlyr)
resolution  : 1, 1  (x, y)
extent      : 0, 705, 0, 776  (xmin, xmax, ymin, ymax)
coord. ref. :  
source      : 2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L2A_True_color.jpg 
colors RGB  : 1, 2, 3 
names       : 2016-06-28~ue_color_1, 2016-06-28~ue_color_2, 2016-06-28~ue_color_3 
Messaggio di avvertimento:
[rast] unknown extent 
> TrueColor<-rast("2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L2A_True_color.jpg")
Messaggio di avvertimento:
[rast] unknown extent 
> plot("TrueColor")
Errore in plot.window(...) : i valori di 'ylim' devono essere finiti
In aggiunta: Messaggi di avvertimento:
1: In xy.coords(x, y, xlabel, ylabel, log) : NA introdotti per coercizione
2: In min(x) : nessun argomento non-mancante al minimo; si restituisce Inf
3: In max(x) :
  nessun argomento non-mancante al massimo; si restituisce -Inf
> TrueColor<-rast("2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L2A_True_color.JPG")
Messaggio di avvertimento:
[rast] unknown extent 
> ?rast
avvio in corso del server httpd per la guida ... fatto
> TrueColor<-rast("2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L2A_True_color.JPG")
Messaggio di avvertimento:
[rast] unknown extent 
> TrueColor<-rast("2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L2A_True_color.jpg")
Messaggio di avvertimento:
[rast] unknown extent 
> plot(TrueColor)
> plot(TrueColor)
> RGB<-flip(TrueColor)
> plot(RGB)
> list.files()
 [1] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B01_(Raw).jpg" 
 [2] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B02_(Raw).jpg" 
 [3] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B03_(Raw).jpg" 
 [4] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B04_(Raw).jpg" 
 [5] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B05_(Raw).jpg" 
 [6] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B06_(Raw).jpg" 
 [7] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B07_(Raw).jpg" 
 [8] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B08_(Raw).jpg" 
 [9] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B09_(Raw).jpg" 
[10] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B8A_(Raw).jpg" 
[11] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_True_color.jpg"
> nir<-flip(rast("2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B08_(Raw).jpg"))
Messaggio di avvertimento:
[rast] unknown extent 
> plot(nir)
> blue<-flip(rast("2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B02_(Raw).jpg"))
Messaggio di avvertimento:
[rast] unknown extent 
> gre<-flip(rast("2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B03_(Raw).jpg"))
Messaggio di avvertimento:
[rast] unknown extent 
> red<-flip(rast("2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B04_(Raw).jpg"))
Messaggio di avvertimento:
[rast] unknown extent 
> stack<-c(blue,gre,red,nir)
> plotRGB(stack, red, gre, blue)
Errore: [subset] no (valid) layer selected
> plotRGB(stack, red, gre, blue,"lin")
Errore: [subset] no (valid) layer selected
In aggiunta: Messaggio di avvertimento:
[rast] 1 out of 4 elements of x are not a SpatRaster 
> plotRGB(stack, 1, 2, 3,"lin")
Errore: [subset] invalid name(s)
> plotRGB(stack, [1], [2], [3)
Errore: '[' inatteso in "plotRGB(stack, ["
> plotRGB(stack, [1], [2], [3])
Errore: '[' inatteso in "plotRGB(stack, ["
> plotRGB(stack, 2, 3, 1, stretch="lin")
> rgb<-flip(rast("2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_True_color.jpg"))
Messaggio di avvertimento:
[rast] unknown extent 
> rgb
class       : SpatRaster 
size        : 644, 590, 3  (nrow, ncol, nlyr)
resolution  : 1, 1  (x, y)
extent      : 0, 590, 0, 644  (xmin, xmax, ymin, ymax)
coord. ref. :  
source(s)   : memory
colors RGB  : 1, 2, 3 
varname     : 2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_True_color 
names       : 2016-06-28~ue_color_1, 2016-06-28~ue_color_2, 2016-06-28~ue_color_3 
min values  :                     7,                    33,                    33 
max values  :                   219,                   204,                   205 
> plot(rgb)
> im.multiframe(1,2)
> plot(rgb)
> plotRGB(stack, 2, 3, 1, stretch="lin")
> plotRGB(stack, 2, 1, 3, stretch="lin")
> plotRGB(stack, 3, 2, 1, stretch="lin")
> plotRGB(stack, 1, 2, 3, stretch="lin")
> stack<-c(red, gre, blue, nir)
> plotRGB(stack, 1, 2, 3, stretch="lin")
> dev.off()
null device 
          1 
> plot(rgb)
> plotRGB(stack, 1, 2, 3, stretch="lin")
> im.multiframe(1,2)
> plot(rgb)
> plotRGB(stack, 1, 2, 3, stretch="lin")
> plotRGB(stack, 1, 2, 4, stretch="lin")
> plotRGB(stack, 4, 2, 3, stretch="lin")
> plot(nir, col=inferno)
Errore in as.character(x) : 
  cannot coerce type 'closure' to vector of type 'character'
> plot(nir, col=inferno(100))
> list.file()
Errore in list.file() : non trovo la funzione "list.file"
> list.files()
 [1] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B01_(Raw).jpg" 
 [2] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B02_(Raw).jpg" 
 [3] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B03_(Raw).jpg" 
 [4] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B04_(Raw).jpg" 
 [5] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B05_(Raw).jpg" 
 [6] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B06_(Raw).jpg" 
 [7] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B07_(Raw).jpg" 
 [8] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B08_(Raw).jpg" 
 [9] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B09_(Raw).jpg" 
[10] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_B8A_(Raw).jpg" 
[11] "2016-06-28-00_00_2016-06-28-23_59_Sentinel-2_L1C_True_color.jpg"
[12] "2026-06-26-00_00_2026-06-26-23_59_Sentinel-2_L1C_B01_(Raw).jpg" 
[13] "2026-06-26-00_00_2026-06-26-23_59_Sentinel-2_L1C_B02_(Raw).jpg" 
[14] "2026-06-26-00_00_2026-06-26-23_59_Sentinel-2_L1C_B03_(Raw).jpg" 
[15] "2026-06-26-00_00_2026-06-26-23_59_Sentinel-2_L1C_B04_(Raw).jpg" 
[16] "2026-06-26-00_00_2026-06-26-23_59_Sentinel-2_L1C_B05_(Raw).jpg" 
[17] "2026-06-26-00_00_2026-06-26-23_59_Sentinel-2_L1C_B06_(Raw).jpg" 
[18] "2026-06-26-00_00_2026-06-26-23_59_Sentinel-2_L1C_B07_(Raw).jpg" 
[19] "2026-06-26-00_00_2026-06-26-23_59_Sentinel-2_L1C_B08_(Raw).jpg" 
[20] "2026-06-26-00_00_2026-06-26-23_59_Sentinel-2_L1C_B09_(Raw).jpg" 
[21] "2026-06-26-00_00_2026-06-26-23_59_Sentinel-2_L1C_B8A_(Raw).jpg" 
[22] "2026-06-26-00_00_2026-06-26-23_59_Sentinel-2_L1C_True_color.jpg"
> r26<-flip(rast("2026-06-26-00_00_2026-06-26-23_59_Sentinel-2_L1C_B04_(Raw).jpg"))
Messaggio di avvertimento:
[rast] unknown extent 
> b26<-flip(rast("2026-06-26-00_00_2026-06-26-23_59_Sentinel-2_L1C_B03_(Raw).jpg"))
Messaggio di avvertimento:
[rast] unknown extent 
> g26<-flip(rast("2026-06-26-00_00_2026-06-26-23_59_Sentinel-2_L1C_B03_(Raw).jpg"))
Messaggio di avvertimento:
[rast] unknown extent 
> b26<-flip(rast("2026-06-26-00_00_2026-06-26-23_59_Sentinel-2_L1C_B02_(Raw).jpg"))
Messaggio di avvertimento:
[rast] unknown extent 
> nir26<-flip(rast("2026-06-26-00_00_2026-06-26-23_59_Sentinel-2_L1C_B08_(Raw).jpg"))
Messaggio di avvertimento:
[rast] unknown extent 
> st26<-c(r26, g26, b26, nir26)
> plotRGB(st26, 4, 2, 3, stretch="lin")
> im.multiframe(1,2)
> plotRGB(stack, 4, 2, 3, stretch="lin")
> plotRGB(st26, 4, 2, 3, stretch="lin")
> ndvi16<-im.ndvi(stack,4,1)
> ndvi26<-im.ndvi(st26,4,1)
> plot(ndvi16, col=inferno(100))
> plot(ndvi26, col=inferno(100))
> library(ggridges)
Messaggio di avvertimento:
il pacchetto ‘ggridges’ è stato creato con R versione 4.5.3 
> im.ridgeline(ndvi, scale=1, palette="viridis")
Errore in .External(list(name = "CppMethod__invoke_notvoid", address = <pointer: (nil)>,  : 
  Valore NULL passato come indirizzo simbolo
> im.ridgeline(ndvi16, scale=1, palette="viridis")
Picking joint bandwidth of 0.0118
> im.ridgeline(ndvi26, scale=1, palette="viridis")
Picking joint bandwidth of 0.0129
> ndvi<-c(ndvi16,ndvi26)
> im.ridgeline(ndvi, scale=1, palette="viridis")
Picking joint bandwidth of 0.0124
> im.ridgeline(ndvi, scale=2, palette="viridis")
Picking joint bandwidth of 0.0124
> im.ridgeline(ndvi, scale=3, palette="viridis")
Picking joint bandwidth of 0.0124
> plot(ndvi[[1]], nedvi[[2]])
Errore in h(simpleError(msg, call)) : 
  errore durante la valutazione dell'argomento 'y' nella selezione di un metodo per la funzione 'plot': oggetto 'nedvi' non trovato
> plot(ndvi[[1]], ndvi[[2]])
Messaggio di avvertimento:
[plot] plot used a sample of 26.4% of the cells. You can use "maxcell" to increase the sample) 
> plot(ndvi[[1]],ndvi[[2]],xlim=c(-0.3,0.9), ylim=c(-0.3,0.9))
Messaggio di avvertimento:
[plot] plot used a sample of 26.4% of the cells. You can use "maxcell" to increase the sample) 
> plot(ndvi[[1]],ndvi[[2]],col="red",xlim=c(-0.3,0.9), ylim=c(-0.3,0.9))
Messaggio di avvertimento:
[plot] plot used a sample of 26.4% of the cells. You can use "maxcell" to increase the sample) 
> ndvidiff<-ndvi26-ndvi16
> plot(ndvidiff, col=inferno(100))
> nirC<-im.classify(nir, seed=42, num_clusters=2)
> im.multiframe(1,2)
> plot(nir, col=inferno(100))
> nirC<-im.classify(nir, seed=42, num_clusters=2)
> plot(ndvi16, col=inferno(100))
> plot(ndvi16, col=viridis(100))
> plot(ndvi16, col=viridis(100))
> nirC<-im.classify(ndvi16, seed=42, num_clusters=2)
> im.multiframe(2,2)
> plot(ndvi16, col=viridis(100))
> nirC<-im.classify(ndvi16, seed=42, num_clusters=2)
> plot(ndvi26, col=viridis(100))
> nirC<-im.classify(ndvi26, seed=42, num_clusters=2)

im.multiframe(2,2)
plot(ndvi16, col=viridis(100))
ndvi16C<-im.classify(ndvi16, seed=42, num_clusters=2)
plot(ndvi26, col=viridis(100))
ndvi26C<-im.classify(ndvi26, seed=42, num_clusters=2)

# Calculating frequencies
fndvi16 <- freq(ndvi16C) 
fndvi26 <- freq(ndvi26C) 

propndvi16 <- fndvi16$count / ncell(ndvi16C)
propndvi26 <- fndvi26$count / ncell(ndvi26C)

percndvi16 <- propndvi16 * 100
percndvi26 <- propndvi26 * 100


















