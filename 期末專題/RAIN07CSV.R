#install.packages("data.table")
library(data.table)
RAIN07<-fread("期末專題/RAIN07.csv",stringsAsFactors = F)
RAIN07<-data.frame(RAIN07)
RAIN07$desc<-iconv(as.character(RAIN07$desc),from="big5",to="UTF-8")
#EARTHQUAKE<-read.csv("期末專題/台灣地震歷史資料.csv",stringsAsFactors = F)
head(RAIN07,20)

totalRAIN07<-cbind(c(dateTime,value),RAIN07)
