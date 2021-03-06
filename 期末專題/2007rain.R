if (!require('XML')){
  install.packages("XML")
  library(XML)
}



xml<-xmlTreeParse("期末專題/dy_Report_2007.xml", useInternalNodes = TRUE)
xmltop <- xmlRoot(xml)
#xmlName(xmltop)     
xmlList<-xmlToList(xmltop[[8]])
length(xmlList)
totalVector<-NULL
for(loc in 1:33){ #33 length(xmlList)
  locName<-xmlList[[loc]][[1]]
  for (datai in 2:length(xmlList[[loc]][[3]])) { #378
    dateTime<-xmlList[[loc]][[3]][[datai]][[1]][[1]] # datetime
    value<-xmlList[[loc]][[3]][[datai]][[2]][[1]][[1]] #element 
    totalVector<-rbind(totalVector,c(locName,dateTime,value))
  }
}

as.numeric(rain07$date)
rain07$element<-as.numeric(as.character(rain07$element))


hist(subset(rain07,loc=="BANQIAO,板橋")$element,col="green")

par(mfrow=c(4,1),mar=c(4,4,2,1))#一張圖裡面有4x1個子圖
hist(subset(rain07,date=="total"&loc=="TAMSUI,淡水")$element,col="green")
hist(subset(rain07,date=="total"&loc=="YUSHAN,玉山")$element,col="green")
hist(subset(rain07,date=="total"&loc=="MIAOLI,苗栗")$element,col="green")
hist(subset(rain07,date=="total"&loc=="PINGTUNG,屏東")$element,col="green")




#hist(subset(rain07,date=="total")$element,col="green")
xmlList[[1]] ##for each locations
xmlList[[1]][[1]] ## 1 name
xmlList[[1]][[2]] ## ID
xmlList[[1]][[3]] ## data ---------
length(xmlList[[1]][[3]])
xmlList[[1]][[3]][[1]] # element name
xmlList[[1]][[3]][[2]] # start from2 
xmlList[[1]][[3]][[3]]
xmlList[[1]][[3]][[4]]
xmlList[[1]][[3]][[33]]
xmlList[[1]][[3]][[378]]

xmlList[[1]][[3]][[2]][[1]][[1]] # datetime
xmlList[[1]][[3]][[2]][[2]][[1]][[1]] #element

xmlList[[1]][[3]][[33]]
xmlList[[1]][[3]][[62]]
xmlList[[1]][[3]][[94]]
xmlList[[1]][[3]][[125]]
xmlList[[1]][[3]][[157]]
xmlList[[1]][[3]][[188]]
xmlList[[1]][[3]][[220]]
xmlList[[1]][[3]][[252]]
xmlList[[1]][[3]][[283]]
xmlList[[1]][[3]][[315]]
xmlList[[1]][[3]][[346]]
xmlList[[1]][[3]][[378]]
