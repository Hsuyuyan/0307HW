if (!require('XML')){
  install.packages("XML")
  library(XML)
}


xml<-xmlTreeParse("期末專題/dy_Report_2008.xml", useInternalNodes = TRUE)
xmltop <- xmlRoot(xml)
#xmlName(xmltop)     
xmlList<-xmlToList(xmltop[[8]])
length(xmlList)
totalVectora<-NULL
for(loc in 1:33){ #33 length(xmlList)
  locName<-xmlList[[loc]][[1]]
  for (datai in 2:length(xmlList[[loc]][[3]])) { #378
    dateTime<-xmlList[[loc]][[3]][[datai]][[1]][[1]] # datetime
    value<-xmlList[[loc]][[3]][[datai]][[2]][[1]][[1]] #element 
    totalVectora<-rbind(totalVectora,c(locName,dateTime,value))
  }
}


par(mfrow=c(2,1),mar=c(4,4,2,1))#一張圖裡面有2x1個子圖

hist(subset(xml,Team=="SAN")$TotalPoints,col="green")

hist(subset(xml,Team=="GSW")$TotalPoints,col="green")
 
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

totalVector<-rbind(totalVector,c(locName,dateTime,value))

########################################################################################
if (!require('XML')){
  install.packages("XML")
  library(XML)
}

xml08<-xmlTreeParse("期末專題/dy_Report_2008.xml", useInternalNodes = TRUE)
xmltop08 <- xmlRoot(xml08)
#xmlName(xmltop)     
xmlList08<-xmlToList(xmltop08[[8]])
length(xmlList08)
totalVector<-NULL
for(loc in 1:2){ #33 length(xmlList)
  locName08<-xmlList08[[loc]][[1]]
  for (datai in 2:length(xmlList08[[loc]][[3]])) { #378
    dateTime08<-xmlList08[[loc]][[3]][[datai]][[1]][[1]] # datetime
    value08<-xmlList08[[loc]][[3]][[datai]][[2]][[1]][[1]] #element 
    totalVector08<-rbind(totalVector,c(locName,dateTime,value))
  }
}

xmlList08[[1]] ##for each locations
xmlList08[[1]][[1]] ## 1 name
xmlList08[[1]][[2]] ## ID
xmlList08[[1]][[3]] ## data ---------
length(xmlList08[[1]][[3]])
xmlList08[[1]][[3]][[1]] # element name
xmlList08[[1]][[3]][[2]] # start from2 
xmlList08[[1]][[3]][[3]]
xmlList08[[1]][[3]][[4]]
xmlList08[[1]][[3]][[33]]
xmlList08[[1]][[3]][[378]]

xmlList08[[1]][[3]][[2]][[1]][[1]] # datetime
xmlList08[[1]][[3]][[2]][[2]][[1]][[1]] #element 
########################################################################################
if (!require('XML')){
    install.packages("XML")
    library(XML)
}
fileUrl <- "http://opendata.cwb.gov.tw/govdownload?dataid=C-B0025-002&authorizationkey=rdec-key-123-45678-011121314"
doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)

########################################################################################

library(XML)
xml<-xmlTreeParse("http://opendata.cwb.gov.tw/govdownload?dataid=C-B0025-002&authorizationkey=rdec-key-123-45678-011121314", useInternalNodes = TRUE)
xmltop <- xmlRoot(xml)
totalVector<-NULL
for(i in 10:length(xmlChildren(xmltop))){
    tempVector<-c()
    tempList<-xmlToList(xmltop[[i]])
    #print(length(tempList))
    for(j in 1:length(tempList)){
        #print(length(tempList[[j]]))
        for(k in 1:length(tempList[[j]])){
            tempVector<-c(tempVector,tempList[[j]][[k]][[1]])
        }
    }
    totalVector<-rbind(totalVector,tempVector)
}
rownames(totalVector)<-c(1:nrow(totalVector))
head(totalVector)



########################################################################################
library(XML)
xml<-xmlTreeParse("http://opendata.cwb.gov.tw/govdownload?dataid=C-B0025-002&authorizationkey=rdec-key-123-45678-011121314", useInternalNodes = TRUE)
xmltop <- xmlRoot(xml)

########################################################################################
#?????????淚?????????察歷???.......Start
########################################################################################
xmlList<-xmlToList(xmltop[[8]])
xmlList[[1]][[1]]
xmlList[[1]][[2]]
xmlList[[2]][[8]] ##main info
xmlList[[2]][[9]] ##each area [[2]]
length(xmlList[[2]][[9]][[1]][[5]])
length(xmlList[[2]][[9]][[1]][[6]])
length(xmlList[[2]][[9]][[1]][[7]])
length(xmlList[[2]][[9]][[2]][[5]])
unlist(xmlList[[2]][[9]][[1]][[6]])

########################################################################################
#?????????淚?????????察歷???.......End
########################################################################################

totalVector<-NULL
headVector<-c()
summaryInfo<-NULL
for(j in 1:length(xmlList)){
    #print(length(tempList[[j]]))
    for(k in 1:length(xmlList[[j]])){
        #if k==9--->each area
        if(k!=9){
            headVector<-c(headVector,unlist(xmlList[[j]][[k]]))
        }else{
            ## for each area
            for(area in 1:length(xmlList[[j]][[k]])){
                if(length(xmlList[[j]][[k]][[area]])<4){
                    summaryInfo<-rbind(summaryInfo,c(headVector,areaHeadVector,unlist(xmlList[[j]][[k]][[area]])))   
                }else{
                    #1~4 area info, others station info
                    areaHeadVector<-c(unlist(xmlList[[j]][[k]][[area]][[1]]),
                                      unlist(xmlList[[j]][[k]][[area]][[2]]),
                                      unlist(xmlList[[j]][[k]][[area]][[3]]),
                                      unlist(xmlList[[j]][[k]][[area]][[4]]))
                    #station info
                    for(i in 5:length(xmlList[[j]][[k]][[area]])){
                        #each area i xmlList[[2]][[9]][[i]]
                        areaVector<-c(headVector,areaHeadVector,unlist(xmlList[[j]][[k]][[area]][[i]]))
                        totalVector<-rbind(totalVector,areaVector)
                        print(areaVector)
                    }
                }
            }
        }
    }
}
head(totalVector)
head(summaryInfo)

#http://data.gov.tw/node/gov/resource/3311
