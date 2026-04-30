# la mia funzioneee

somma<-function(x,y){
  z=x+y
  return(z)
  }

differenza<-function(x,y){
  z=x-y
  return(z)
  }

#par
mf <- function(nrow,ncol) {
  par(mfrow=c(nrow,ncol))
  }
#struttura if/else

positivo<-function(x) {
if(x>0) {
  "questo numero è positivo"}
else if(x<0) {
"questo numero è negativo"}
else {
"Zero non è ne negativo ne positivo"}
}

#ciclo for

loop <-function(){
for(i in 1:50)
  print(i)
  }

loop2 <-function(){
for(i in 1:50)
  {op<-(i*7)
  print(op)
  }
}

setwd("C:\\Scienze e gestione della natura\\Primo anno\\Telerilevamento")
sink("output.txt") #funzione per salvare la roba bisogna mettere la roba che si vuole salvare dopo
loop2()   #funzione che viene sincata

#per disistallare pacchetti si usa la funzione
#remove.packages("nome del pacchetto)
#chiedere a Chat per i file .Rd
















