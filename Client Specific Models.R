library(dplyr)
library(car)
library(ggplot2)

advcy.file = 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/advcy_data_final.csv'
envr.file = 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/envr_data_final.csv'
health2.file = 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/health2_data_final.csv'
health.file = 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/health_data_final.csv'
social.file = 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/social_data_final.csv'
veteran.file = 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/veteran_data_final.csv'

advcy.data <- read.csv(advcy.file,header=T)[,-7]
envr.data <- read.csv(envr.file,header=T)
health2.data <- read.csv(health2.file,header=T)
health.data <- read.csv(health.file,header=T) #remove age
social.data <- read.csv(social.file,header=T) # remove age
veteran.data <- read.csv(veteran.file,header=T)

envr.data <- envr.data %>% filter(!is.na(age))
health2.data <- health2.data %>% filter(!is.na(age))
veteran.data <- veteran.data %>% filter(!is.na(age))

advcy.data %>% select(sustainer) %>% group_by(sustainer) %>% count()
envr.data %>% select(sustainer) %>% group_by(sustainer) %>% count()
health2.data %>% select(sustainer) %>% group_by(sustainer) %>% count()
health.data %>% select(sustainer) %>% group_by(sustainer) %>% count()
social.data %>% select(sustainer) %>% group_by(sustainer) %>% count()
veteran.data %>% select(sustainer) %>% group_by(sustainer) %>% count()

advcy.n <- 3471
envr.n <- 8703
health2.n <- 252
health.n <- 3746
social.n <- 52031
veteran.n <- 19624

advcy.data.clean <- advcy.data[,-c(7,8)]
envr.data.clean <- envr.data[,-c(8,9)]

# advocacy
set.seed(42)
advcy.dc.0 <- sample_n(advcy.data.clean[advcy.data.clean$sustainer==0,],advcy.n)
advcy.dc.1 <- advcy.data.clean[advcy.data.clean$sustainer==1,]
advcy.flag <- sort(sample(1:advcy.n,round((advcy.n*3)/10)))

advcy.train <- rbind(advcy.dc.0[-advcy.flag,],advcy.dc.1[-advcy.flag,])
advcy.test <- rbind(advcy.dc.0[advcy.flag,],advcy.dc.1[advcy.flag,])

advcy.model <- glm(sustainer~gift_min_t12m+gift_avg_t12m+gift_count_t12m+promo_count_t12m+cons_month_t12m+dm_t12m+tm_t12m+wm_t12m+digital_t12m+no_channel_t12m+gift_min_lt+gift_avg_lt+promo_count_lt+cons_month_lt,data=advcy.train,family='binomial')

mean((predict(advcy.model,advcy.train,type='response')>0.6)==(advcy.train[,1]==1))
mean((predict(advcy.model,advcy.test,type='response')>0.6)==(advcy.test[,1]==1))

step(advcy.model)

# envr
envr.dc.0 <- sample_n(envr.data.clean[envr.data.clean$sustainer==0,],envr.n)
envr.dc.1 <- envr.data.clean[envr.data.clean$sustainer==1,]
envr.flag <- sort(sample(1:envr.n,round((envr.n*3)/10)))

envr.train <- rbind(envr.dc.0[-envr.flag,],envr.dc.1[-envr.flag,])
envr.test <- rbind(envr.dc.0[envr.flag,],envr.dc.1[envr.flag,])

envr.model <- glm(sustainer~.,data=envr.train,family='binomial')

step(envr.model)

envr.model <- glm(sustainer~all_state_rank+age+gift_min_t12m+gift_max_t12m+gift_avg_t12m+gift_count_t12m+promo_count_t12m+cons_month_t12m+dm_t12m+tm_t12m+wm_t12m+digital_t12m+f2f_t12m+no_channel_t12m+member_t12m+gift_min_lt+gift_max_lt+gift_avg_lt+gift_count_lt+promo_count_lt+cons_month_lt,data=envr.train,family='binomial')

mean((predict(envr.model,envr.train,type='response')>0.62)==(envr.train[,1]==1))
mean((predict(envr.model,envr.test,type='response')>0.62)==(envr.test[,1]==1))
