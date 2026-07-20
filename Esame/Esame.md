<div align="center">

# Analisi della ripresa forestale in seguito ad eventi atmosferici estremi

#  🌬️Caso studio: tempesta Vaia🌳 

## Nicola Arcangeli - telerilevamento geo-ecologico in R 🛰️
</div>

## 1. Introduzione

Tra sabato 27 e martedì 30 ottobre 2018 l’Italia è stata interessata dagli effetti di una profonda 
depressione atmosferica denominata “Vaia”. Tra il mattino e il pomeriggio di lunedì 29 ottobre 
2018, potenti raffiche di vento meridionale con velocità di punta superiori ai 200 km/h si sono 
abbattute sulle regioni Alpine, in particolare nelle aree di Nord Est provocando gravi danni alla 
vegetazione, in particolare è stata coinvolta una superficie forestale complessiva di 38 216.00 ettari e una
massa legnosa di 16 538 284.70 m<sup>3</sup> ([Mappatura delle superfici forestali danneggiate dalla tempesta Vaia](https://www.masaf.gov.it/flex/cm/pages/ServeBLOB.php/L/IT/IDPagina/18158)).

<img width="750" height="500" alt="Mappa_delle_superfici_forestali_danneggiate_dalla_tempesta_Vaia" src="https://github.com/user-attachments/assets/e05dff60-1200-4dbd-8b21-1a3a85650906" />

>Mappa dei danni forestali stilata dal MASAF ex-MIPAAF

L'obbiettivo di questo lavoro è utilizzare immagini satellitari e appositi indici spettrali per analizzare i danni 
causati dalla tempesta ed osservare e quantificare l'entità della ricrescita avvenuta negli ultimi anni.

I periodi analizzati sono:
- Settembre 2018 (condizione prima dell'evento)
- Settembre 2019 (condizioni ad un anno dall'evento)
- Settembre 2025 (situazione recente)

## 2. Area di studio e metodologie

L'area di studio su cui sono state effettuate le indagini si trova al confine tra Veneto e Trentino Alto Adige, nella parte nord-orientale
dell'Altopiano dei Sette Comuni e comprende in buona parte la Piana di Marcesina, una zona di importantissimo valore ambientale. 

<img width="1528" height="731" alt="2025-09-19-00_00_2025-09-19-23_59_Sentinel-2_L1C_True_color" src="https://github.com/user-attachments/assets/52cfccd3-1d79-4e90-9c96-3fcd1478eb30" />

>Mappa della zona di studio, orientata in direzione nord, ottenuta tramite Browser Copernicus

Le immagini provengono dal satellite Sentinel-2 operato dall'ESA e sono state scaricate tramite il browser Copernicus. Utilizzando le immagini
ottenute sono stati calcolati i seguenti indici spettrali:
- DVI (Difference Vegetation Index) fornisce un'indicazione non normalizzata, del vigore vegetativo.
- NDVI (Normalized Difference Vegetation Index) versione normalizzata del DVI, è l'indice standard per la stima della salute e densità della vegetazione.
- BSI  (Bare Soil Index) specifico per il suolo nudo, rileva i cambiamenti nell'uso del suolo

Le analisi sono state condotte in ambiente R tramite i seguenti pacchetti:

```
library(terra)      # Pacchetto per maneggiare facilmente immagini satellitari
library(viridis)    # Pacchetto che aggiunge scale colori per utenti affetti da daltonismo
library(ggplot2)    # Per la creazione di grafici
library(imageRy)    # Pacchetto per svolgere più agilmente determinati compiti
```

## 3. Preparazione delle immagini

Le immagini sono state caricate in R tramite le funzioni `rast()` del pacchetto `terra`, è inoltre stat usata la funzione `flip()` per riportare le immagini al
corretto orientamento. Le bande caricate sono:
- Blu (B2), 0.490 µm, risoluzione 10m
- Verde (B3), 0.560 µm, risoluzione 10m
- Rosso (B4), 0.665 µm, risoluzione 10m
- Near-Infrared (B8), 0.842 µm, risoluzione 10m
- Short-Wave Infrared (B11), 1.610 µm, risoluzione 20m


```
setwd("C:\\Scienze e gestione della natura\\Primo anno\\Telerilevamento\\EsameVaia") #per configurare la cartella di lavoro principale
list.files() # per richiamare la lista dei file contenuti nella cartella

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
swir18<-resample(swir18, b18)  # ricampiona il primo oggetto indicato alla risoluzione del secondo
swir19<-resample(swir25, b19)
swir25<-resample(swir25, b25)

# compongo gli stack 
T18<-c(r18, g18, b18, nir18, swir18)
T19<-c(r19, g19, b19, nir19, swir19)
T25<-c(r25, g25, b25, nir25, swir25)

# rinomino i componenti degli stack creati
names(T18) <- c("Rosso (B4)", "Verde (B3)", "Blu (B2)", "NIR (B8)", "SWIR (B12)")
names(T19) <- c("Rosso (B4)", "Verde (B3)", "Blu (B2)", "NIR (B8)", "SWIR (B12)")
names(T25) <- c("Rosso (B4)", "Verde (B3)", "Blu (B2)", "NIR (B8)", "SWIR (B12)")
```

## 4. Visualizzazione delle singole bande spettrali

Prima di procedere con il calcolo degli indici si osservano singolarmente le bande, questa operazione oltre a permettere di fare qualche 
considerazione è utile per verificare che le operazioni precedenti siano state svolte correttamente.

### Settembre 2018, condizione precedente
```
plot(T18, col=viridis(100))
```

<img width="600" height="600" alt="Tutte_le_bande_2018" src="https://github.com/user-attachments/assets/9190ea38-c59e-4820-958e-3aa803d7817f" />

>In queste immagini sono evidenti i contorni dell'altopiano, specialmente tramite la banda dello SWIR
### Settembre 2019, condizione dopo un anno
```
plot(T19, col=viridis(100))
```
<img width="600" height="600" alt="Tutte_le_bande_2019" src="https://github.com/user-attachments/assets/e80e5875-5ce1-4c9e-acd1-4faf8ae4a239" />

>Si possono osservare i danni provocati dalla tempesta
### Settembre 2025, condizione recente
```
plot(T25, col=viridis(100))
```
<img width="600" height="600" alt="Tutte_le_bande_2025" src="https://github.com/user-attachments/assets/e8fe6ea4-c63e-45a3-b63f-0d8702d10348" />

>Si osserva una piccola ripresa tuttavia la vegetazione è ancora molto diversa da quella pre-impatto

## 5. Elaborazione di composizioni RGB con colori veritieri e falsati

Sono state composte, tramite le singole bande, delle immagini a colori veri, al fine di osservare la zona d'interesse per come appare all'occhio umano, e 
falsati, per evidenziare la presenza di vegetazione. La funzione utilizzata è `plotRGB()` che permette di scegliere le singole bande che costituiranno l'immagine.

```
im.multiframe(2,3) # per visualizzare tutte le immagini seguenti contemporaneamente
plotRGB(T18, 1, 2, 3, stretch = "lin", main = "2018 (pre)") # vengono indicati solo le posizioni all'interno degli stack, l'ordine è rosso-verde-blu
plotRGB(T19, 1, 2, 3, stretch = "lin", main = "2019 (post)")
plotRGB(T25, 1, 2, 3, stretch = "lin", main = "2025 (recente)")
plotRGB(T18, 4, 2, 3, stretch = "lin", main = "2018 falsi colori") # viene inserita la banda del NIR al posto di quella del rosso per evidenziare la vegetazione
plotRGB(T19, 4, 2, 3, stretch = "lin", main = "2019 falsi colori")
plotRGB(T25, 4, 2, 3, stretch = "lin", main = "2025 falsi colori")

# è possibile chiudere il multiframe con la funzione dev.off()
```
<img width="750" height="750" alt="Colori veritieri e falsati" src="https://github.com/user-attachments/assets/e870af5f-1b48-4874-b02e-e8bb8f7d7239" />

> Tramite queste immagini si può osservare l'entità dei danni, in particolare la notevole perdita di copertura vegetazionale dell'altopiano della Marcesina tra prima e dopo la tempesta (immagini del 2018 e 2019)

## 6. Indici spettrali di vegetazione: DVI e NDVI

### DVI (Different Vegetation Index)
$` DVI = NIR - RED `$

Il DVI è un indice che si basa sull'alta riflettanza delle piante allo spettro del NIR, ed è spesso utilizzato per analizzare la copertura vegetale e lo stato di salute della vegetazione, non essendo normalizzato le comparazioni tra immagini diverse devono essere affrontate cautamente. Per calcolarlo è stata utilizzata la funzione `im.dvi()`.

```
dvi18<-im.dvi(T18,4,1) # la funzione "im.dvi()" elabora automaticamente le bande NIR e rosso
dvi19<-im.dvi(T19,4,1)
dvi25<-im.dvi(T25,4,1)
im.multiframe(1,3) # in questo caso si preferiscono i risultati sulla stessa riga
plot(dvi18, col = mako(100), main = "DVI 2018")
plot(dvi19, col = mako(100), main = "DVI 2019")
plot(dvi25, col = mako(100), main = "DVI 2025")
#dev.off()
```
<img width="720" height="300" alt="DVI2 1" src="https://github.com/user-attachments/assets/7d52e4c8-97ba-46d9-83f9-941125b71f38" />

>L'indice non permette di estrarre molte informazioni, per questo si utilizza un indice normalizzato come NDVI

### NDVI (Normalized Different Vegetation Index)
$` NDVI = \frac{NIR - RED}{NIR + RED} `$

NDVI è la versione normalizzata del DVI che può assumere valori compresi tra -1 ed 1, grazie a questa caratteristica permette di eseguire confronti più accurati tra immagini diverse tenendo conto della differente luminosità e di differenti risoluzioni radiometriche. Viene utilizzato in ambito agricolo per analizzare la produttività ed in ambito ecologico per monitorare lo stato di salute della vegetazione. Per calcolare questo indice è stata utilizzata la funzione `im.ndvi()`.

```
ndvi18<-im.ndvi(T18,4,1)
ndvi19<-im.ndvi(T19,4,1)
ndvi25<-im.ndvi(T25,4,1)
im.multiframe(1,3) # anche in questo caso si preferiscono i risultati sulla stessa riga
# si utilizza un intervallo compreso tra 0-1 in quanto si osservano pochi valori al di sotto di 0,
# che saranno indicati come no-data e colorati di bianco
# l'utilizzo di un intervallo definito permette di confrontare le colorazioni tra loro evidenziando maggiormente le differenze
plot(ndvi18, col=inferno(100), range = c(0,1)) 
plot(ndvi19, col=inferno(100), range = c(0,1)) 
plot(ndvi25, col=inferno(100), range = c(0,1))
```











