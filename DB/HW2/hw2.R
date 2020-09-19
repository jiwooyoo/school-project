x<-read.csv("C:\\Users\\WORK\\Desktop\\age.csv")
names(x)

install.packages("dplyr")
library(dplyr)

#install.packages("varhandle")
#library(varhandle)
x<- data.frame(x %>% select(자치구,행정동,구분,X15.19세,X20.24세,X25.29세))
x

#y<-subset(x,x$자치구=="관악구"&x$구분=="계")
#y
#y11<-as.numeric(factor(x$X15.19세))
#y22<-as.numeric(factor(x$X20.24세))
#y33<-as.numeric(factor(x$X25.29세))
#sum_all<-y11+y22+y33
#sum_all<-as.data.frame(sum_all)
y<- x %>%
  filter(자치구=="관악구" & 구분 =="계"&행정동!="소계")%>%
  group_by(행정동)

y

y11<-suppressWarnings(as.numeric(as.character(y$X15.19세)))
y22<-suppressWarnings(as.numeric(as.character(y$X20.24세)))
y33<-suppressWarnings(as.numeric(as.character(y$X25.29세)))
y11
