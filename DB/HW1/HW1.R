x<-read.csv("C:\\Users\\WORK\\Desktop\\k_wf.csv")
x

install.packages("dplyr")
library(dplyr)

x <- rename(x,sex=h10_g3,birth=h10_g4,marriage=h10_g10,religion=h10_g11,income=p1002_8aq1,code_job=h10_eco9,code_region=h10_reg7)
k_wf_yjw <- data.frame(x %>% select(sex,birth,marriage,religion,income,code_job,code_region))
k_wf_yjw

is.na(k_wf_yjw)
#sex 결측치
table(is.na(k_wf_yjw$sex))
#birth
table(is.na(k_wf_yjw$birth))
#marriage
table(is.na(k_wf_yjw$marriage))
#religion
table(is.na(k_wf_yjw$religion))
#income
table(is.na(k_wf_yjw$income))
#code_job
table(is.na(k_wf_yjw$code_job))
#code_religion
table(is.na(k_wf_yjw$code_region))

k_wf_yjw <- k_wf_yjw %>% mutate(sex_t=ifelse(sex==1, "M","F")) %>% mutate(age=2019-birth)
k_wf_yjw <- k_wf_yjw %>% mutate(age_g=ifelse(age<20,10,
                                 ifelse(age<30,20,
                                        ifelse(age<40,30,
                                               ifelse(age<50,40,
                                                      ifelse(age<60,50,
                                                             ifelse(age<70,60,
                                                                    ifelse(age<80,70,
                                                                           ifelse(age<90,80,
                                                                                  ifelse(age<100,90,
                                                                                         ifelse(age<110,100,110)))))))))))

k_wf_yjw <- k_wf_yjw %>% mutate(income_g=ifelse(!is.na(income)&income<100,0,ifelse(income<200,1,
                                                      ifelse(income<300,2,
                                                          ifelse(income<400,3,
                                                             ifelse(income<500,4,
                                                                ifelse(income<600,5,
                                                                   ifelse(income<700,6,
                                                                      ifelse(income<800,7,
                                                                         ifelse(income<900,8,
                                                                            ifelse(income<1000,9,10)))))))))))

y <- read.csv("C:\\Users\\WORK\\Desktop\\Codebook.csv")
k_wf_yjw <- left_join(k_wf_yjw,y,by="code_job")
k_wf_yjw


k_wf_yjw <- k_wf_yjw %>% mutate(region=ifelse(code_region==1, "서울",
                            ifelse(code_region==2,"수도권(인천/경기)",
                               ifelse(code_region==3,"부산/경남/울산",
                                  ifelse(code_region==4,"대구/경북",
                                     ifelse(code_region==5,"대전/충남",
                                          ifelse(code_region==6,"강원/충북","광주/전남/전북/제주도")))))))

install.packages("ggplot2")
library(ggplot2)
df_k_wf_yjw <- k_wf_yjw  %>% filter(code_region==1)
df_k_wf_yjw <- df_k_wf_yjw %>% group_by(age_g,sex_t) %>% summarise(mean_income=mean(income,na.rm=T))
ggplot(data=df_k_wf_yjw, aes(x=age_g,y=mean_income,fill=sex_t))+geom_col()

df_k_wf_yjw <- k_wf_yjw %>%group_by(age,sex_t) %>% summarise(mean_income=mean(income,na.rm = T))
ggplot(data=df_k_wf_yjw,aes(x=age,y=mean_income,color=sex_t))+geom_line()


k_wf_yjw %>% filter(sex==2)%>% group_by(job)%>%summarise(mean_income=mean(income,na.rm=T)) %>%
  arrange(desc(mean_income))%>% head(10)

df_k_wf_yjw <- k_wf_yjw%>% filter(!is.na(income)&!is.na(marriage)) %>% 
  group_by(income_g,marriage) %>% summarise(total_n=n())
total_sum <- (sum(df_k_wf_yjw$total_n))
df_k_wf_yjw <- df_k_wf_yjw %>% filter(marriage %in% c(1,2,3,4)) %>%
  group_by(income_g) %>% summarise(sum(total_n)/total_sum*100)                    
df_k_wf_yjw

k_wf_yjw <- k_wf_yjw %>% mutate(age_group=ifelse(age<15,"child",
                                    ifelse(age<30,"young",
                                           ifelse(age<60,"middle","old"))))
total_count <- count(k_wf_yjw) 
df_k_wf_yjw <- k_wf_yjw %>% group_by(age_group,region) %>% summarise(n=n()/total_count$n*100)
ggplot(data=df_k_wf_yjw, aes(x=region,y=n,fill=age_group))+geom_col()+coord_flip()
