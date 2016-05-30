install.packages("caret")
install.packages("lattice")
install.packages("ggplot2")

library(caret)
DiabPred<-predict(finalFit,newdata = PimaIndiansDiabetesC[PimaIndiansDiabetesC$Test==T,])
DiabAns<-ifelse(DiabPred<0.5,"pos","neg") 
DiabAns<-factor(DiabAns,levels = c("pos","neg"))
DiabAns

round