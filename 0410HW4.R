if (!require('Rfacebook')){
  install.packages("Rfacebook")
  library(Rfacebook)
}

totalPage<-NULL
lastDate<-Sys.Date()
numberOfPost<-30
DateVector<-seq(as.Date("2016-01-01"),lastDate,by="5 days")
DateVectorStr<-as.character(DateVector)
DateVectorStr

token<-'CAACmPyrae3YBAFDnvo2sSFAtHweRXpe3V4AKKlz8BZCZCKBZBqRqDBfDHceYEauprDyOBYcHU2CH3dHBGuz9xqsz7cD0ue0Mgc9nqPn91NtNJDQYJW00KqBlLKMb26JsZAZCDyaa8fqAX8GZAYWDnvZCZAB1VuuiNE8CfDNEZCIKOeUWxGFGigEZCQ91oiqDhr1LuklJj9iPgyKRwyUa0ZCg2Xz'
for(i in 1:(length(DateVectorStr)-1)){
  tempPage<-getPage("llchu", token,
                    since = DateVectorStr[i],until = DateVectorStr[i+1])
  totalPage<-rbind(totalPage,tempPage)
}
nrow(totalPage)

totalPage$datetime <- as.POSIXct(totalPage$created_time, 
                                 format = "%Y-%m-%dT%H:%M:%S+0000", 
                                 tz = "GMT")
totalPage$dateTPE <- format(totalPage$datetime, "%Y-%m-%d", 
                            tz = "Asia/Taipei")
totalPage$weekdays <-weekdays(as.Date(totalPage$dateTPE))

output<-aggregate(message~weekdays+dateTPE,totalPage,length)
library(knitr)
kable(output, digits=2)

output<-aggregate(likes_count~dateTPE,totalPage,mean)
library(knitr)
kable(output, digits=2)

output<-aggregate(comments_count~dateTPE,totalPage,mean)
library(knitr)
kable(output, digits=2)

output<-aggregate(shares_count~dateTPE,totalPage,mean)
library(knitr)
kable(output, digits=2)
