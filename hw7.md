糖尿病 預測模型
================

資料前處理
----------

### 資料讀取

此資料來源為UCI Machine Learning Repository。

此資料記載一些因素來協助預測女性是否為糖尿病患者，一共有八個參數。另外，分類結果為二元分類，包括非糖尿病患者(neg)與糖尿病患者(pos) 。

``` r
library(mlbench)
```

    ## Warning: package 'mlbench' was built under R version 3.2.5

``` r
data(PimaIndiansDiabetes)
str(PimaIndiansDiabetes) 
```

    ## 'data.frame':    768 obs. of  9 variables:
    ##  $ pregnant: num  6 1 8 1 0 5 3 10 2 8 ...
    ##  $ glucose : num  148 85 183 89 137 116 78 115 197 125 ...
    ##  $ pressure: num  72 66 64 66 40 74 50 0 70 96 ...
    ##  $ triceps : num  35 29 0 23 35 0 32 0 45 0 ...
    ##  $ insulin : num  0 0 0 94 168 0 88 0 543 0 ...
    ##  $ mass    : num  33.6 26.6 23.3 28.1 43.1 25.6 31 35.3 30.5 0 ...
    ##  $ pedigree: num  0.627 0.351 0.672 0.167 2.288 ...
    ##  $ age     : num  50 31 32 21 33 30 26 29 53 54 ...
    ##  $ diabetes: Factor w/ 2 levels "neg","pos": 2 1 2 1 2 1 2 1 2 2 ...

### 留下無缺值資料

``` r
PimaIndiansDiabetesC<-
    PimaIndiansDiabetes[complete.cases(PimaIndiansDiabetes),] 
c(nrow(PimaIndiansDiabetes),nrow(PimaIndiansDiabetesC))
```

    ## [1] 768 768

### 將資料隨機分為訓練組與測試組

隨機將2/3的資料分到訓練組（Test==F），剩下1/3為測試組（Test==T）且將有糖尿病症狀的人放在level1

``` r
PimaIndiansDiabetesC$Test<-F 
PimaIndiansDiabetesC[sample(1:nrow(PimaIndiansDiabetesC),nrow(PimaIndiansDiabetesC)/3),]$Test<-T
PimaIndiansDiabetesC$diabetes<-factor(PimaIndiansDiabetesC$diabetes,levels=c("pos","neg"))
c(sum(PimaIndiansDiabetesC$Test==F),sum(PimaIndiansDiabetesC$Test==T))
```

    ## [1] 512 256

可得訓練組案例數為512，測試組案例數為256

預測模型建立
------------

### 模型建立

由於變數相當多，且多為連續變項，而且輸出為二元的類別變項，所以選擇邏輯迴歸演算法建立模型，並使用雙向逐步選擇最佳參數組合。

``` r
fit<-glm(diabetes~., PimaIndiansDiabetesC[PimaIndiansDiabetesC$Test==F,],family="binomial")
library(MASS)
finalFit<-stepAIC(fit,direction = "both",trace = F)
summary(finalFit)$coefficients
```

    ##                 Estimate   Std. Error   z value     Pr(>|z|)
    ## (Intercept)  8.487638137 0.8467083257 10.024276 1.192299e-23
    ## pregnant    -0.090132526 0.0372149921 -2.421941 1.543784e-02
    ## glucose     -0.034609614 0.0044621242 -7.756309 8.743686e-15
    ## insulin      0.001589479 0.0009567478  1.661335 9.664610e-02
    ## mass        -0.071542137 0.0175116818 -4.085395 4.400190e-05
    ## pedigree    -0.911857074 0.3607011237 -2.528013 1.147102e-02
    ## age         -0.015946481 0.0110995029 -1.436684 1.508077e-01

### 模型挑選、說明

由上述參數可知，以邏輯迴歸建立模型預測是否為糖尿病患者，經最佳化後，模型使用參數為pregnant, glucose, insulin, mass, pedigree, age，共6個參數，各參數代表每一個可能影響的因素

預測模型驗證
------------

``` r
#install.packages('nloptr')

DiabPred<-predict(finalFit,newdata = PimaIndiansDiabetesC[PimaIndiansDiabetesC$Test==T,])
DiabAns<-ifelse(DiabPred<0.5,"pos","neg") 
DiabAns<-factor(DiabAns,levels = c("pos","neg"))
library(caret)
```

    ## Warning: package 'caret' was built under R version 3.2.5

    ## Loading required package: lattice

    ## Warning: package 'lattice' was built under R version 3.2.5

    ## Loading required package: ggplot2

    ## Warning: package 'ggplot2' was built under R version 3.2.5

``` r
sensitivity(DiabAns,PimaIndiansDiabetesC[PimaIndiansDiabetesC$Test==T,]$diabetes)
```

    ## [1] 0.7065217

``` r
specificity(DiabAns,PimaIndiansDiabetesC[PimaIndiansDiabetesC$Test==T,]$diabetes)
```

    ## [1] 0.7317073

``` r
posPredValue(DiabAns,PimaIndiansDiabetesC[PimaIndiansDiabetesC$Test==T,]$diabetes)
```

    ## [1] 0.5963303

``` r
negPredValue(DiabAns,PimaIndiansDiabetesC[PimaIndiansDiabetesC$Test==T,]$diabetes)
```

    ## [1] 0.8163265

從不同女性得到的相關資料，經過邏輯回歸模型預測是否為糖尿病患者，可得： 敏感度 70.65% 特異性 73.17% 陽性預測率 59.63% 陰性預測率 81.63%
