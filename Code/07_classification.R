# R code for classyfing images
library(terra)
library(imageRy)

im.list()

sun<-im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
?im.classify() #per cercare il manuale

#classification

sunc<-im.classify(sun, num_clusters=3)
#procedura iterativa, se non specificato è casuale, scegliamone una così che il risultato sia comune per tutti
sunc<-im.classify(sun, num_clusters=3, seed=19)

#grand canyon classification

can<-im.import("dolansprings_oli_2013088_canyon_lrg.jpg")
canc<-im.classify(can, num_clusters=4, seed=19)

# funzione ncell("oggetto") restituisce il numero di pixel, importante per il loro peso

#scaricare immagine


















