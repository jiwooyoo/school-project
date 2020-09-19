install.packages("RCurl")
install.packages("XML")
install.packages("rJava")
library(rJava)
library(RCurl)
library(XML)
searchURL<-"https://openapi.naver.com/v1/search/blog.xml"
Client_ID<-"_eCPEdxG23CmuezdeNMz"
Client_Secret<-"l564A_pKXp"
query<-URLencode(iconv("엽떡","euc-kr","UTF-8"))
url<-paste(searchURL,"?query=",query,"&display=20",sep = "")
doc<-getURL(url,httpheader=c('Content-Type'="application/xml",'X-Naver-Client-Id'=Client_ID,'X-Naver-Client-Secret'=Client_Secret))
doc2<-htmlParse(doc,encoding = "UTF-8")
text<-xpathSApply(doc2,"//item/description",xmlValue)
text
install.packages("KoNLP")
install.packages("RColorBrewer")
install.packages("wordcloud")
library(KoNLP)
library(RColorBrewer)
library(wordcloud)
useSejongDic()
noun<-sapply(text,extractNoun,USE.NAMES = F)
noun
noun2<-unlist(noun)
noun2
noun2<-gsub('\\d+','',noun2)
noun2<-gsub('<b>','',noun2)
noun2<-gsub('</b>','',noun2)
noun2<-gsub('&amp','',noun2)
noun2<-gsub('&lt','',noun2)
noun2<-gsub('&gt','',noun2)
noun2<-gsub('&quot','',noun2)
noun2<-gsub('"','',noun2)
noun2<-gsub('\'','',noun2)
noun2<-gsub(' ','',noun2)
noun2<-gsub('-','',noun2)
noun2
wordcount<-table(noun2)
wordcount
head(sort(wordcount,decreasing = T),30)
palete<-brewer.pal(9,"Set1")
wordcloud(names(wordcount),freq = wordcount,scale = c(5,0.25),rot.per = 0.25,min.freq = 1,random.order = F,random.color = T,colors = palete)
