etwd("~/Desktop")

#richiama una funzione che ho salvato come file di testo, utile per prendere singole funzioni anche da pacchetti molto grandi
source("im.kernel.txt")

library(imageRy)

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

#per la statistica sd
kernsun<-im.kernel(sun[[1]], stat="sd")

#se si toglie "sd" calcola tutte le statistiche
kernsun<-im.kernel(sun[[1]])

Esame: 10 min di presentazione 
attenzione ridondanza dei pacchetti, mettere solo quelli che si usano
sapere da che pacchetto vengono le funzioni
i commenti fanno parte del giudizio e sono importanti



