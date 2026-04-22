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
setwd("C:/Scienze e gestione della natura/Primo anno/Telerilevamento")
list.files()
#importo con rast
dji<-flip(rast("dji_fly_20241226_054143_0_1735188103432_photo_low_quality.JPG"))

#classifico immagine
djic<-im.classify(dji, num_cluster=3, seed=19)

#classify Mato Grosso data
m1992<-flip(im.import("matogrosso_l5_1992219_lrg.jpg"))
m2006<-flip(im.import("matogrosso_ast_2006209_lrg.jpg"))
im.multiframe(1,2)
plot(m1992)
plot(m2006)

m1992c<-im.classify(m1992, num_cluster=2, seed=19)
m2006c<-im.classify(m2006, num_cluster=2, seed=19)

# Assign labels
levels(m1992c) <- data.frame(
  value = c(1, 2),
  label = c("forest", "human")
)

#percentages

freq1992<-freq(m1992c)
perc1992<-freq1992$count*100/ncell(m1992c)

freq2006<-freq(m2006c)
perc2006<-freq2006$count*100/ncell(m2006c)

#creo tabella

tabout<-data.frame(
  class=c("Forest","Human"),
  perc1992=c(83,17),
  perc2006=c(45,55))


















