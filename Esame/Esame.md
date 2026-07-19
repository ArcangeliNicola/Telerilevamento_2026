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

## Preparazione delle immagini

Le immagini sono state caricate in R tramite le funzioni `rast` del pacchetto `terra`:



`
















