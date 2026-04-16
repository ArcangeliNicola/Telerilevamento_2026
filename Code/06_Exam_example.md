# Questo sarà il titolo del mio progetto d'esame

testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo testo



# Pacchetti utilizzati

elenco dei pacchetti:
`````
library(terra) #commento su cosa fa il pacchetto
library(imageRy) #per multiframe e altro
`````

# Importazione dati

i dati sono stati scaticati da earth observatory: https://assets.science.nasa.gov/dynamicimage/assets/science/esd/eo/images/iotd/2026/eyeing-the-richat-structure/richatstructure_oli_20260306.jpg?w=1440&h=960&fit=clip&crop=faces%2Cfocalpoint

oppure scrivere così: [Earth observatory](https://assets.science.nasa.gov/dynamicimage/assets/science/esd/eo/images/iotd/2026/eyeing-the-richat-structure/richatstructure_oli_20260306.jpg?w=1440&h=960&fit=clip&crop=faces%2Cfocalpoint)

Il codice utilizzato è il seguente: prima di tutto selezioniamo la working directory 

`````
setwd("C:/Scienze e gestione della natura/Primo anno/Telerilevamento")
getwd()
list.files()
`````

Per importare i dati è stata utilizzata la funzione `rast()` del pacchetto `terra`: 
`````
richat<-flip(rast("richatstructure_oli_20260306.jpg"))
plot(richat)
`````
<img width="480" height="480" alt="figura" src="https://github.com/user-attachments/assets/c7d38a53-4fff-4dbc-b8b0-cd52a5c148ce" />

# analisi esplorativa
codici per ottenere le bande
`````
im.multiframe(2,1)
plot(richat[[1]])
plot(richat[[2]])
`````
<img width="480" height="480" alt="ric b1 e b2" src="https://github.com/user-attachments/assets/d589cd74-56dd-4449-bee2-5cc92010490f" />

#roba copiata da chat da prendere dal file del prof, istogrammi







