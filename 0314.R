#11要相同類別
x10 <- 1:3
y10 <- 10:12
cbind(x10, y10)
rbind(x10, y10)

#12可不同類別
x11 <- list(1, "a", TRUE, 1 + 4i) 
x11

#13塞字串 但幫字串編號
x12<-factor(c("yes", "yes", "no", "yes", "no")) 
x12
#把向量轉成整理出有哪些分類  NO是1 YES是2 因為N在Y前面 有LEVEL可規定誰是1.2
x12a<-factor(c("yes", "yes", "no", "yes", "no"), levels =c("yes","no"))
x12a

#14每列要是相同的類別 不同列可不同類別 FOO第一個COLUMN 1-4 
x13 <- data.frame(foo = 1:4, bar = c(T, T, F, F)) 
x13 #column names: foo, bar 
nrow(x13) #此DATAFRAME有幾行
ncol(x13) #此DATAFRAME有幾列
names(x13)<-c("fooNew","barNew") #foo, bar改名稱為fooNew.barNew
x13

#15安裝此PACKAGE時名稱要加雙引號
install.packages("SportsAnalytics")
library(SportsAnalytics)
NBA1415<-fetch_NBAPlayerStatistics("14-15") 
names(NBA1415)
head(NBA1415)#可看前幾筆
nrow(NBA1415)
ncol(NBA1415)#幾個值可用

#17
x16<-as.Date("1970-01-01") #新增一個日期 把括號裡的資料變成DATE 並塞入X16參數中
x16
unclass(x16)  #1970-0101開始算 所以是第0天 1970-0102 第1天
unclass(as.Date("1971-01-01")) 
weekdays(x16) #可看星期幾
months(x16)
seq(Sys.Date(), by="1 months", length.out=12) #現在的時間每隔一個月 總共要有12個
seq(as.Date("2016-01-31"), by="1 months", length.out=12)#20160131後每隔一個月 總共要有12個

#18
x17<-Sys.time()
x17
LisDate<-as.POSIXlt(x17) #把時間轉成LIST  分開顯示秒分十年月日
IntDate<-as.POSIXct(x17) #存成數字 有秒1457940886
LisDate
IntDate
unclass(LisDate)
unclass(IntDate)

#19
as.Date("2012/03/01")
as.Date("2012 MAR 01")
as.Date("2012 MAR 01", "%Y %b %d") #Y年 B月份 D日期
?strptime #若記不得年月日的形式 可輸入此strptime顯示日期格式
x18 <- as.Date("2012-03-01")
y18 <-as.Date("2012-02-28") 
x18-y18 #日期可加減 計算年紀時

#21 Subset不符合條件的資料刪除 
letters #字母 若要大寫 Letters
letters [1] #要字母的第一個a的資料
letters [1:10] #要1-10個向量
letters[c(1,3,5)] #產生ace
letters [-1:-10] #不要第1-10個字母 所以從k開始
head(letters,5)#前五筆資料
tail(letters,5)#後五個資料

islands #內建的資料集
sort(islands) #排序資料
head(sort(islands))
tail(sort(islands))

#22 head(iris) iris是一種花
iris[1,2] #(Row 1, Column 2) 要此dataframe的第一排第二列的資料
iris[,"Species"] #Column name=="Species" row的資料都要 而指定column
iris$Species #Column name=="Species" 與iris[,"Species"]相同答案
subset(iris, Species=="virginica") #Species == "virginica"
iris[iris$Species=="virginica",]#Species == "virginica" 與subset(iris, Species=="virginica")同

#23
install.packages("SportsAnalytics")
library(SportsAnalytics)
NBA1415<-fetch_NBAPlayerStatistics("14-15")
San<-subset(NBA1415,Team=='SAN') #只取team=san的人
San
San[order(San$GamesPlayed,decreasing = T),"Name"] #排序與row有關 order(San$GamesPlayed,decreasing = T)為row decreasing = T 從多排到少
San[order(San$GamesPlayed,decreasing = T),c("Name","GamesPlayed")]

#24 str iris的詳細資料
str(iris)
str(NBA1415)

#26
available.packages()
head(available.packages())
install.packages("ggplot2")
library(ggplot2) 

#28 strsplit 切字串
strsplit("Hello World"," ")
toupper("Hello World") #將所有資料全部換成全大寫
tolower("Hello World") #將所有資料全部換成全小寫
library(stringr)
str_trim("Hello World   ") #移除前後空白

#29
#字串連接
paste("Hello", "World", sep='')#sep='' 代表部插入任何字元的連接串
paste0("Hello", "World") #paste0將字串無縫接軌連起來
paste0("Hello", "it's me", "I was wondering if after all these years","You'd like to meet, to go over everything")
paste(c("Hello", "World"), sep='') #向量沒變
paste(c("Hello", "World"), sep='',collapse = '') #向量的話要加參數collapse = ''
#字串切割
substr("Hello World", start=2,stop=4) #切第2-4個字
#字串取代
gsub("o","0","Hello World") #把Hello World的英文o換成0數字

#30 grep 回傳index grepl回傳T/F
grep("Tim",NBA1415$Name) #第137 158 196 335行的人
NBA1415[grep("Tim",NBA1415$Name),] #顯示所有名字有Tim的人
grepl("Tim",NBA1415$Name)
subset(NBA1415,grepl("Tim",Name)) #subset 資料集 有tim的人

#32
which(letters>"m") #m是第13個

#33
a<-3
if(a>10){
  b<-10
}else if(a>5){
  b<-5
}else{
  b<-a
}
b
ifelse(a>10,b<-10,b<-a) #若a>10是真 就b變成10 若不是 就b=a
ifelse(a>10,b<-10,ifelse(a>5,b<-5,b<-a))


#34
ifelse(NBA1415$GamesPlayed>30,"Hardwork","Lazy")
NBA1415$Personality<-ifelse(NBA1415$GamesPlayed>30,"Hardwork","Lazy") #另闢一個Personality

#35
#for
for(index in 1:10){
  print(index)
}
#repeat
index<-1
repeat{
  if(index>10){
    break
  }
  print(index)
  index<-index+1
}
#36
#next 
for(index in 1:10){
  if(index!=4){
    print(index)
  }
}
for(index in 1:10){
  if(index==4){
    next #跳過4不吉利的數字
  }
  print(index)
}

#37
for(i in 1:nrow(NBA1415)){ #1:nrow(NBA1415) 從第一行到最後一航
  print(NBA1415[i,"Name"])
}
for(i in 1:nrow(NBA1415)){
  if(!grepl('a|A',NBA1415[i,"Name"])){  # 不要(搜尋小A或大A的人)
    print(NBA1415[i,"Name"])
  }
}

#38
for (i in 1:nrow(NBA1415)) {
  if (NBA1415[i,"GamesPlayed"]>70&
   NBA1415[i,"TotalPoints"]>1500)
  {
    print(NBA1415[i,c("Name","Team","Position")])}
    
}
#39
subset(NBA1415,GamesPlayed>70&TotalPoints>1500)[,c("Name","Team","Position")]
NBA1415[NBA1415$GamesPlayed>70&NBA1415$TotalPoints>1500,c("Name","Team","Position")]


#41
apply(NBA1415[,c("GamesPlayed","TotalMinutesPlayed","TotalPoints")],2,mean)


#43
sapply(iris, mean)
sapply(NBA1415[,c("GamesPlayed","TotalMinutesPlayed","TotalPoints")],mean)
#44
lapply(iris, mean)
lapply(NBA1415[,c("GamesPlayed","TotalMinutesPlayed","TotalPoints")],mean)
#45
tapply(NBA1415$Name,NBA1415$Team,length)
tapply(NBA1415$TotalPoints,NBA1415$Team,max)
tapply(NBA1415$TotalPoints,NBA1415$Team,mean)
tapply(NBA1415$TotalPoints,NBA1415$Team,range)

#46
split(1:30,gl(3, 10))
lapply(split(1:30,gl(3, 10)),mean)
tapply(1:30,gl(3, 10),mean)

#47
NBA1415Team<-split(NBA1415[,c("TotalPoints","GamesPlayed")],NBA1415$Team)
lapply(NBA1415Team, colMeans)
sapply(NBA1415Team, colMeans)

#48
NBA1415TP<-split(NBA1415[,c("TotalPoints","GamesPlayed")],list(NBA1415$Team,NBA1415$Position))
lapply(NBA1415TP, colMeans)
sapply(NBA1415TP, colMeans)

#50
aggregate(NBA1415$TotalPoints, by=list(NBA1415$Team,NBA1415$Position), FUN=mean, na.rm=TRUE)
aggregate(TotalPoints ~ Team+Position, data = NBA1415, mean)

#51
x<-c(1,2,3,4,5)
mean(x)
x<-c(x,NA)
mean(x)
mean(x, na.rm=T)
sum(x)
sum(x, na.rm=T)


#52
system.time({
  n <- 1000
  r <- numeric(n)
  for(i in 1:n) {
    x <- rnorm(n)
    r[i] <- mean(x)
  }
})

#53
x <- list(foo = 1:4, bar = 0.6, baz = "hello")
x[1]
x[[1]]
x[2]
x[[2]]
x$foo

#55=4
x <- c(1, 2, NA, 4, NA, 5)
x[! is.na(x)]
x[! complete.cases(x)]




##test 2
