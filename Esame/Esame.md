<div align="center">

# Analisi della ripresa forestale in seguito ad eventi atmosferici estremi

#  🌬️Caso studio: tempesta Vaia🌳 

## Nicola Arcangeli - telerilevamento geo-ecologico in `R` 🛰️
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
library(BSI)        # Pacchetto per calcolare agilmente il Bare Soil Index
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
setwd("C:\\Scienze e gestione della natura\\Primo anno\\Telerilevamento\\Esame Vaia") #per configurare la cartella di lavoro principale
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

## 6. Indici spettrali analizzati: DVI, NDVI e BSI

### DVI (Different Vegetation Index)
$` DVI = NIR - RED `$

Il DVI è un indice che si basa sull'alta riflettanza delle piante allo spettro del NIR, ed è spesso utilizzato per analizzare la copertura vegetale e lo stato di salute della vegetazione, non essendo normalizzato le comparazioni tra immagini diverse devono essere affrontate cautamente. Per calcolarlo è stata utilizzata la funzione `im.dvi()`.

```
dvi18<-im.dvi(T18,4,1) # la funzione "im.dvi()" elabora automaticamente le bande
dvi19<-im.dvi(T19,4,1)
dvi25<-im.dvi(T25,4,1)
dvi<-c(dvi18, dvi19, dvi25)
names(dvi)<-c("DVI 2018","DVI 2019","DVI 2025")
plot(dvi, col = mako(100))
```
<img width="600" height="600" alt="DVI" src="https://github.com/user-attachments/assets/dd660126-c8b0-43e8-be32-eb8de3437455" />

>L'indice non permette di estrarre molte informazioni, per questo si utilizza un indice normalizzato come NDVI

### NDVI (Normalized Different Vegetation Index)
$` NDVI = \frac{NIR - RED}{NIR + RED} `$

NDVI è la versione normalizzata del DVI che può assumere valori compresi tra -1 ed 1, grazie a questa caratteristica permette di eseguire confronti più accurati tra immagini diverse tenendo conto della differente luminosità e di differenti risoluzioni radiometriche. Viene utilizzato in ambito agricolo per analizzare la produttività ed in ambito ecologico per monitorare lo stato di salute della vegetazione. Per calcolare questo indice è stata utilizzata la funzione `im.ndvi()`.

```
ndvi18<-im.ndvi(T18,4,1)
ndvi19<-im.ndvi(T19,4,1)
ndvi25<-im.ndvi(T25,4,1)
ndvi<-c(ndvi18, ndvi19, ndvi25)
names(ndvi)<-c("NDVI 2018","NDVI 2019","NDVI 2025")
# si utilizza il range 0-1 in quanto si osservano pochi valori al di sotto di 0, che saranno indicati come no-data e colorati di bianco
# l'utilizzo di un range definito permette di confrontare le colorazioni tra loro evidenziando maggiormente le differenze
plot(ndvi, col=inferno(100), range = c(0,1)) 
```
<img width="600" height="600" alt="NDVI" src="https://github.com/user-attachments/assets/a62b8040-d314-44ce-96f6-846a76b6fe63" />

> Tramite l'indice si possono identificare molto bene le aree che sono state danneggiate dalla tempesta tramite l'immagine dell'anno 2019, si può osservare anche come la vegetazione si sia ripresa in tempi recenti tuttavia sono ancora evidenti le differenze rispetto allo stato precedente all'evento

### BSI  (Bare Soil Index)

$` BSI=\frac{((SWIR1+Red)−(NIR+Blue)}{(SWIR1+Red)+(NIR+Blue)} `$

L'indice BSI è utilizzato per evidenziare il suolo nudo o eroso. Spesso viene utilizzato per evidenziare la desertificazione o i cambiamenti nello stato del suolo, in questo caso viene utilizzato a scopo esplorativo per osservare quali risultati si ottengono se applicato all'analisi di vegetazione arborea abbattuta da un evento atmosferico.

```
# calcolo dell'indice BSI
bsi18<-bsi(T18, 1, 3, 4, 5) # utilizzo la funzione bsi() ottenuta dal pacchetto "BSI"
bsi19<-bsi(T19, 1, 3, 4, 5)
bsi25<-bsi(T25, 1, 3, 4, 5)
#visualizzazione dell'indice
bsi<-c(bsi18, bsi19, bsi25)
names(bsi)<-c("BSI 2018", "BSI 2019", "BSI 2025")
plot(bsi, col = inferno(100), range = c(-1,1))
```
<img width="600" height="600" alt="BSI" src="https://github.com/user-attachments/assets/3a51d85d-3a2d-408f-8ae2-6cc83a4cd844" />

> In queste immagini un colore più scuro rappresenta un suolo in cui è presente vegetazione legnosa mentre il suolo chiaro può essere ricondotto ad una vegetazione erbacea, è evidente come la copertura del suolo sia notevolmente cambiata in seguito alla tempesta ed inoltre questo indice accentua in maniera ottima come la vegetazione non sia ancora tornata ad uno stato anche solo simile a quello precedente

## 7. Ridgeline plot

Al fine di analizzare in modo più diretto le variazioni degli indici spettrali calcolati in precedenza si preparano dei Ridgeline plot. Nonostante vengano perse le informazioni riguardanti la posizione all'interno dell'area di studio questo tipo di analisi permette di ottenere risultati facilmente comparabili ed interpretabili. Per sviluppare i Ridgeline plot è stata utilizzata la funzione `im.ridgeline()` proveniente dal pacchetto `imageRy`.

### Ridgeline plot: indice NDVI
```
im.ridgeline(ndvi, scale=1, palette="viridis") # la funzione im.ridgeline() permette di creare velocemente un ridgeline plot
```
<img width="700" height="350" alt="Ridgeline NDVI" src="https://github.com/user-attachments/assets/001fa7a5-f4ca-4c86-ad46-57d35eb04cac" />

> La distribuzione all'interno del grafico è chiaramente unimodale, comunque possono essere effettuate delle considerazioni:
>
> - Si può osservare come nel 2019 la coda sinistra della distribuzione tenda maggiormente verso i valori negativi dell'indice che rappresentano una vegetazione meno rigogliosa o assente
> - Rispetto alla distribuzione del grafico del 2018 quella del 2025 risulta più rilassata, il picco è inferiore e le code sono più spesse

### Ridgeline plot: indice BSI
```
im.ridgeline(bsi, scale=1, palette="viridis") # la funzione im.ridgeline() permette di creare velocemente un ridgeline plot
```
<img width="700" height="350" alt="Ridgeline BSI" src="https://github.com/user-attachments/assets/d9a29987-e79c-4d36-b05d-3ae0ff2c4bc3" />

> i risultati di questo Ridgeline plot sono particolarmente interessanti.
> - La disposizione possiede uno stato bimodale nel periodo precedente la tempesta (2018), in cui il picco più alto si trova all'interno dei valori tra -0.5 e -0.25 che rappresentano la copertura forestale mentre il secondo picco tra -0.25 e 0 rappresenta la copertura erbacea.
> - La situazione cambia drasticamente nel periodo subito dopo l'evento (2019) in cui la distribuzione passa ad uno stato quasi trimodale nel quale il picco tra -0.5 e -0.25 si riduce drasticamente, il picco tra -0.25 e 0 si alza mentre si può osservare un notevole aumento dei valori vicini a 0, questo riflette perfettamente le dinamiche della tempesta: la foresta è stata abbattuta dal vento e il suolo rimasto esposto viene colonizzato da piante erbacee o rimane nudo.
> - All'interno del grafico che rappresenta la situazione più recente (2025) si osserva un ritorno ad una distribuzione bimodale in cui tuttavia l'altezza dei picchi è invertita rispetto alla condizione pre-evento, in particolare il picco legato alla vegetazione forestale sembra rimanere stabile rispetto al periodo 2019 mentre le specie erbacee hanno avuto il tempo di colonizzare il suolo nudo e così di espandersi.

## 8. Classificazione

Al fine di ottenere una stima quantitativa dell'impatto della tempesta operiamo una classificazione.


































