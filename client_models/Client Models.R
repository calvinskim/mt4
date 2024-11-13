library(dplyr)
library(car)
library(ggplot2)
library(reshape2)
library(pROC)
library(randomForest)
library(caret)

advcy.train.s.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/advcy_train_wo_outliers_w_scaling.csv'
advcy.test.s.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/advcy_test_wo_outliers_w_scaling.csv'
envr.train.s.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/envr_train_wo_outliers_w_scaling.csv'
envr.test.s.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/envr_test_wo_outliers_w_scaling.csv'
health2.train.s.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/health2_train_wo_outliers_w_scaling.csv'
health2.test.s.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/health2_test_wo_outliers_w_scaling.csv'
health.train.s.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/health_train_wo_outliers_w_scaling.csv'
health.test.s.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/health_test_wo_outliers_w_scaling.csv'
social.train.s.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/social_train_wo_outliers_w_scaling.csv'
social.test.s.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/social_test_wo_outliers_w_scaling.csv'
veteran.train.s.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/veteran_train_wo_outliers_w_scaling.csv'
veteran.test.s.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/veteran_test_wo_outliers_w_scaling.csv'
advcy.train.ns.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/advcy_train_wo_outliers_wo_scaling.csv'
advcy.test.ns.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/advcy_test_wo_outliers_wo_scaling.csv'
envr.train.ns.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/envr_train_wo_outliers_wo_scaling.csv'
envr.test.ns.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/envr_test_wo_outliers_wo_scaling.csv'
health2.train.ns.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/health2_train_wo_outliers_wo_scaling.csv'
health2.test.ns.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/health2_test_wo_outliers_wo_scaling.csv'
health.train.ns.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/health_train_wo_outliers_wo_scaling.csv'
health.test.ns.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/health_test_wo_outliers_wo_scaling.csv'
social.train.ns.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/social_train_wo_outliers_wo_scaling.csv'
social.test.ns.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/social_test_wo_outliers_wo_scaling.csv'
veteran.train.ns.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/veteran_train_wo_outliers_wo_scaling.csv'
veteran.test.ns.file <- 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/veteran_test_wo_outliers_wo_scaling.csv'

# scaled data
advcy.train.s <- read.csv(advcy.train.s.file,header=T)[,-15] # removing f2f_t12m
advcy.test.s <- read.csv(advcy.test.s.file,header=T)[,-15] # removing f2f_t12m
envr.train.s <- read.csv(envr.train.s.file,header=T)
envr.test.s <- read.csv(envr.test.s.file,header=T)
health2.train.s <- read.csv(health2.train.s.file,header=T)[,-17] # removing other_t12m
health2.test.s <- read.csv(health2.test.s.file,header=T)[,-17] # removing other_t12m
health.train.s <- read.csv(health.train.s.file,header=T)[,-3] # removing client_state_rank
health.test.s <- read.csv(health.test.s.file,header=T)[,-3] # removing client_state_rank
social.train.s <- read.csv(social.train.s.file,header=T)
social.test.s <- read.csv(social.test.s.file,header=T)
veteran.train.s <- read.csv(veteran.train.s.file,header=T)
veteran.test.s <- read.csv(veteran.test.s.file,header=T)

# non-scaled data
advcy.train.ns <- read.csv(advcy.train.ns.file,header=T)[,-15] # removing f2f_t12m
advcy.test.ns <- read.csv(advcy.test.ns.file,header=T)[,-15] # removing f2f_t12m
envr.train.ns <- read.csv(envr.train.ns.file,header=T)
envr.test.ns <- read.csv(envr.test.ns.file,header=T)
health2.train.ns <- read.csv(health2.train.ns.file,header=T)[,-17] # removing other_t12m
health2.test.ns <- read.csv(health2.test.ns.file,header=T)[,-17] # removing other_t12m
health.train.ns <- read.csv(health.train.ns.file,header=T)[,-3] # removing client_state_rank
health.test.ns <- read.csv(health.test.ns.file,header=T)[,-3] # removing client_state_rank
social.train.ns <- read.csv(social.train.ns.file,header=T)
social.test.ns <- read.csv(social.test.ns.file,header=T)
veteran.train.ns <- read.csv(veteran.train.ns.file,header=T)
veteran.test.ns <- read.csv(veteran.test.ns.file,header=T)

# checking flag variables for any same data from outlier removal process
unique(advcy.train.s$dm_t12m)
unique(advcy.train.s$tm_t12m)
unique(advcy.train.s$wm_t12m)
unique(advcy.train.s$digital_t12m)
unique(advcy.train.s$f2f_t12m) # remove this feature
unique(advcy.train.s$events_t12m)
unique(advcy.train.s$other_t12m)
unique(advcy.train.s$no_channel_t12m)
unique(advcy.train.s$member_t12m)
unique(advcy.train.s$gender)
unique(advcy.train.s$client_state_rank)
unique(advcy.train.s$client_zip_rank)

unique(envr.train.s$dm_t12m)
unique(envr.train.s$tm_t12m)
unique(envr.train.s$wm_t12m)
unique(envr.train.s$digital_t12m)
unique(envr.train.s$f2f_t12m)
unique(envr.train.s$no_channel_t12m)
unique(envr.train.s$member_t12m)
unique(envr.train.s$gender)
unique(envr.train.s$client_state_rank)
unique(envr.train.s$client_zip_rank)

unique(health2.train.s$dm_t12m)
unique(health2.train.s$tm_t12m)
unique(health2.train.s$wm_t12m)
unique(health2.train.s$digital_t12m)
unique(health2.train.s$events_t12m)
unique(health2.train.s$other_t12m) # remove this feature
unique(health2.train.s$gender)
unique(health2.train.s$client_state_rank)
unique(health2.train.s$client_zip_rank)

unique(health.train.s$dm_t12m)
unique(health.train.s$wm_t12m)
unique(health.train.s$digital_t12m)
unique(health.train.s$f2f_t12m)
unique(health.train.s$other_t12m)
unique(health.train.s$gender)
unique(health.train.s$client_state_rank) # remove this feature
unique(health.train.s$client_zip_rank)

unique(social.train.s$dm_t12m)
unique(social.train.s$tm_t12m)
unique(social.train.s$wm_t12m)
unique(social.train.s$digital_t12m)
unique(social.train.s$f2f_t12m)
unique(social.train.s$events_t12m)
unique(social.train.s$drtv_t12m)
unique(social.train.s$other_t12m)
unique(social.train.s$gender)
unique(social.train.s$client_state_rank)
unique(social.train.s$client_zip_rank)

unique(veteran.train.s$dm_t12m)
unique(veteran.train.s$wm_t12m)
unique(veteran.train.s$digital_t12m)
unique(veteran.train.s$drtv_t12m)
unique(veteran.train.s$other_t12m)
unique(veteran.train.s$gender)
unique(veteran.train.s$client_state_rank)
unique(veteran.train.s$client_zip_rank)
unique(veteran.train.s$age)

# functions
thresh_finder <- function(model,data.train){
  predicted <- predict(model,data.train,type='response')
  temp1 <- NULL
  for (i in seq(0,1,0.1)){
    temp1 <- rbind(temp1,cbind(i,mean(ifelse(predicted>=i,1,0)==data.train$sustainer)))
  }
  t <- max(temp1[which(temp1[,2]==max(temp1[,2])),1])
  temp2 <- NULL
  for (i in seq(t-0.1,t+0.1,0.01)){
    temp2 <- rbind(temp2,cbind(i,mean(ifelse(predicted>=i,1,0)==data.train$sustainer)))
  }
  t <- max(temp2[which(temp2[,2]==max(temp2[,2])),1])
  temp3 <- NULL
  for (i in seq(t-0.01,t+0.01,0.001)){
    temp3 <- rbind(temp3,cbind(i,mean(ifelse(predicted>=i,1,0)==data.train$sustainer)))
  }
  return(max(temp3[which(temp3[,2]==max(temp3[,2])),1]))
}

# setting seed
set.seed(42)

## logistic regression
# advcy model w/ scaled data
advcy.s.model.full <- glm(as.factor(sustainer)~.-gift_avg_t12m-gift_count_t12m-promo_count_lt-gift_avg_lt,data=advcy.train.s,family='binomial')
vif(advcy.s.model.full)

advcy.s.model.step <- step(glm(as.factor(sustainer)~.-gift_avg_t12m-gift_count_t12m-promo_count_lt-gift_avg_lt,data=advcy.train.s,family='binomial'),k=log(dim(advcy.train.s)[1]))

advcy.s.final.model <- glm(advcy.s.model.step$formula,data=advcy.train.s,family='binomial')

advcy.s.thresh <- thresh_finder(advcy.s.final.model,advcy.train.s)

mean(ifelse(predict(advcy.s.final.model,advcy.train.s,type='response')>=advcy.s.thresh,1,0)==advcy.train.s$sustainer)
mean(ifelse(predict(advcy.s.final.model,advcy.test.s,type='response')>=advcy.s.thresh,1,0)==advcy.test.s$sustainer)

advcy.s.test.predicted <- ifelse(predict(advcy.s.final.model,advcy.test.s,type='response')>=advcy.s.thresh,1,0)

advcy.s.cm <- as.data.frame(cbind(advcy.s.test.predicted=test,actual=advcy.test.s$sustainer)) %>% 
  mutate(TP=ifelse(actual==1&advcy.s.test.predicted==1,1,0),FP=ifelse(actual==0&advcy.s.test.predicted==1,1,0),
         TN=ifelse(actual==0&advcy.s.test.predicted==0,1,0),FN=ifelse(actual==1&advcy.s.test.predicted==0,1,0))

sum(advcy.s.cm$TP)/(sum(advcy.s.cm$TP)+sum(advcy.s.cm$FP))

# envr model w/ scaled data
envr.s.model.full <- glm(as.factor(sustainer)~.-gift_avg_t12m-promo_count_lt-cons_month_lt,data=envr.train.s,family='binomial')
vif(envr.s.model.full)

envr.s.model.step <- step(glm(as.factor(sustainer)~.-gift_avg_t12m-promo_count_lt-cons_month_lt,data=envr.train.s,family='binomial'),k=log(dim(envr.train.s)[1]))

envr.s.final.model <- glm(envr.s.model.step$formula,data=envr.train.s,family='binomial')

envr.s.thresh <- thresh_finder(envr.s.final.model,envr.train.s)
mean(ifelse(predict(envr.s.final.model,envr.train.s,type='response')>=envr.s.thresh,1,0)==envr.train.s$sustainer)
mean(ifelse(predict(envr.s.final.model,envr.test.s,type='response')>=envr.s.thresh,1,0)==envr.test.s$sustainer)

envr.s.test.predicted <- ifelse(predict(envr.s.final.model,envr.test.s,type='response')>=envr.s.thresh,1,0)

envr.s.cm <- as.data.frame(cbind(predicted=envr.s.test.predicted,actual=envr.test.s$sustainer)) %>% 
  mutate(TP=ifelse(actual==1&predicted==1,1,0),FP=ifelse(actual==0&predicted==1,1,0),
         TN=ifelse(actual==0&predicted==0,1,0),FN=ifelse(actual==1&predicted==0,1,0))

sum(envr.s.cm$TP)/(sum(envr.s.cm$TP)+sum(envr.s.cm$FP))

# health2 model w/ scaled data
health2.s.model.full <- glm(as.factor(sustainer)~.-gift_avg_t12m-gift_count_lt,data=health2.train.s,family='binomial')
vif(health2.s.model.full)

health2.s.model.step <- step(glm(as.factor(sustainer)~.-gift_avg_t12m-gift_count_lt,data=health2.train.s,family='binomial'),k=log(dim(health2.train.s)[1]))

health2.s.final.model <- glm(health2.s.model.step$formula,data=health2.train.s,family='binomial')

health2.s.thresh <- thresh_finder(health2.s.final.model,health2.train.s)
mean(ifelse(predict(health2.s.final.model,health2.train.s,type='response')>=health2.s.thresh,1,0)==health2.train.s$sustainer)
mean(ifelse(predict(health2.s.final.model,health2.test.s,type='response')>=health2.s.thresh,1,0)==health2.test.s$sustainer)

health2.s.test.predicted <- ifelse(predict(health2.s.final.model,health2.test.s,type='response')>=health2.s.thresh,1,0)

health2.s.cm <- as.data.frame(cbind(predicted=health2.s.test.predicted,actual=health2.test.s$sustainer)) %>% 
  mutate(TP=ifelse(actual==1&predicted==1,1,0),FP=ifelse(actual==0&predicted==1,1,0),
         TN=ifelse(actual==0&predicted==0,1,0),FN=ifelse(actual==1&predicted==0,1,0))

sum(health2.s.cm$TP)/(sum(health2.s.cm$TP)+sum(health2.s.cm$FP))

# health model w/ scaled data
health.s.model.full <- glm(as.factor(sustainer)~.-gift_avg_t12m,data=health.train.s,family='binomial')
vif(health.s.model.full)

health.s.model.step <- step(glm(as.factor(sustainer)~.-gift_avg_t12m,data=health.train.s,family='binomial'),k=log(dim(health.train.s)[1]))

health.s.final.model <- glm(health.s.model.step$formula,data=health.train.s,family='binomial')

health.s.thresh <- thresh_finder(health.s.final.model,health.train.s)
mean(ifelse(predict(health.s.final.model,health.train.s,type='response')>=health.s.thresh,1,0)==health.train.s$sustainer)
mean(ifelse(predict(health.s.final.model,health.test.s,type='response')>=health.s.thresh,1,0)==health.test.s$sustainer)

health.s.test.predicted <- ifelse(predict(health.s.final.model,health.test.s,type='response')>=health.s.thresh,1,0)

health.s.cm <- as.data.frame(cbind(predicted=health.s.test.predicted,actual=health.test.s$sustainer)) %>% 
  mutate(TP=ifelse(actual==1&predicted==1,1,0),FP=ifelse(actual==0&predicted==1,1,0),
         TN=ifelse(actual==0&predicted==0,1,0),FN=ifelse(actual==1&predicted==0,1,0))

sum(health.s.cm$TP)/(sum(health.s.cm$TP)+sum(health.s.cm$FP))

# social model w/ scaled data
social.s.model.full <- glm(as.factor(sustainer)~.-gift_avg_t12m,data=social.train.s,family='binomial')
vif(social.s.model.full)

social.s.model.step <- step(glm(as.factor(sustainer)~.-gift_avg_t12m,data=social.train.s,family='binomial'),k=log(dim(social.train.s)[1]))

social.s.final.model <- glm(social.s.model.step$formula,data=social.train.s,family='binomial')

social.s.thresh <- thresh_finder(social.s.final.model,social.train.s)
mean(ifelse(predict(social.s.final.model,social.train.s,type='response')>=social.s.thresh,1,0)==social.train.s$sustainer)
mean(ifelse(predict(social.s.final.model,social.test.s,type='response')>=social.s.thresh,1,0)==social.test.s$sustainer)

social.s.test.predicted <- ifelse(predict(social.s.final.model,social.test.s,type='response')>=social.s.thresh,1,0)

social.s.cm <- as.data.frame(cbind(predicted=social.s.test.predicted,actual=social.test.s$sustainer)) %>% 
  mutate(TP=ifelse(actual==1&predicted==1,1,0),FP=ifelse(actual==0&predicted==1,1,0),
         TN=ifelse(actual==0&predicted==0,1,0),FN=ifelse(actual==1&predicted==0,1,0))

sum(social.s.cm$TP)/(sum(social.s.cm$TP)+sum(social.s.cm$FP))

# veteran model w/ scaled data
#veteran.s.model.full <- glm(as.factor(sustainer)~.-gift_avg_t12m-gift_count_lt-dm_t12m-tm_t12m-wm_t12m-digital_t12m-events_t12m-other_t12m,data=veteran.train.s,family='binomial')
veteran.s.model.full <- glm(as.factor(sustainer)~.-gift_count_lt-gift_avg_t12m-gift_count_t12m,data=veteran.train.s,family='binomial')
vif(veteran.s.model.full)

veteran.s.model.step <- step(glm(as.factor(sustainer)~.-gift_count_lt-gift_avg_t12m-gift_count_t12m,data=veteran.train.s,family='binomial'),k=log(dim(veteran.train.s)[1]))

veteran.s.final.model <- glm(veteran.s.model.step$formula,data=veteran.train.s,family='binomial')

veteran.s.thresh <- thresh_finder(veteran.s.final.model,veteran.train.s)
mean(ifelse(predict(veteran.s.final.model,veteran.train.s,type='response')>=veteran.s.thresh,1,0)==veteran.train.s$sustainer)
mean(ifelse(predict(veteran.s.final.model,veteran.test.s,type='response')>=veteran.s.thresh,1,0)==veteran.test.s$sustainer)

veteran.s.test.predicted <- ifelse(predict(veteran.s.final.model,veteran.test.s,type='response')>=veteran.s.thresh,1,0)

veteran.s.cm <- as.data.frame(cbind(predicted=veteran.s.test.predicted,actual=veteran.test.s$sustainer)) %>% 
  mutate(TP=ifelse(actual==1&predicted==1,1,0),FP=ifelse(actual==0&predicted==1,1,0),
         TN=ifelse(actual==0&predicted==0,1,0),FN=ifelse(actual==1&predicted==0,1,0))

sum(veteran.s.cm$TP)/(sum(veteran.s.cm$TP)+sum(veteran.s.cm$FP))

# advcy model w/ non-scaled data
advcy.ns.model.full <- glm(as.factor(sustainer)~.-gift_avg_t12m-gift_count_t12m-gift_avg_lt-promo_count_lt,data=advcy.train.ns,family='binomial')
vif(advcy.ns.model.full)

advcy.ns.model.step <- step(glm(as.factor(sustainer)~.-gift_avg_t12m-gift_count_t12m-gift_avg_lt-promo_count_lt,data=advcy.train.ns,family='binomial'),k=log(dim(advcy.train.ns)[1]))

advcy.ns.final.model <- glm(advcy.ns.model.step$formula,data=advcy.train.ns,family='binomial')

advcy.ns.thresh <- thresh_finder(advcy.ns.final.model,advcy.train.ns)
mean(ifelse(predict(advcy.ns.final.model,advcy.train.ns,type='response')>=advcy.ns.thresh,1,0)==advcy.train.ns$sustainer)
mean(ifelse(predict(advcy.ns.final.model,advcy.test.ns,type='response')>=advcy.ns.thresh,1,0)==advcy.test.ns$sustainer)

advcy.ns.test.predicted <- ifelse(predict(advcy.ns.final.model,advcy.test.ns,type='response')>=advcy.ns.thresh,1,0)

advcy.ns.cm <- as.data.frame(cbind(predicted=advcy.ns.test.predicted,actual=advcy.test.ns$sustainer)) %>% 
  mutate(TP=ifelse(actual==1&predicted==1,1,0),FP=ifelse(actual==0&predicted==1,1,0),
         TN=ifelse(actual==0&predicted==0,1,0),FN=ifelse(actual==1&predicted==0,1,0))

sum(advcy.ns.cm$TP)/(sum(advcy.ns.cm$TP)+sum(advcy.ns.cm$FP))

# envr model w/ non-scaled data
envr.ns.model.full <- glm(as.factor(sustainer)~.-gift_avg_t12m-promo_count_lt-cons_month_lt,data=envr.train.ns,family='binomial')
vif(envr.ns.model.full)

envr.ns.model.step <- step(glm(as.factor(sustainer)~.-gift_avg_t12m-promo_count_lt-cons_month_lt,data=envr.train.ns,family='binomial'),k=log(dim(envr.train.ns)[1]))

envr.ns.final.model <- glm(envr.ns.model.step$formula,data=envr.train.ns,family='binomial')

envr.ns.thresh <- thresh_finder(envr.ns.final.model,envr.train.ns)
mean(ifelse(predict(envr.ns.final.model,envr.train.ns,type='response')>=envr.ns.thresh,1,0)==envr.train.ns$sustainer)
mean(ifelse(predict(envr.ns.final.model,envr.test.ns,type='response')>=envr.ns.thresh,1,0)==envr.test.ns$sustainer)

envr.ns.test.predicted <- ifelse(predict(envr.ns.final.model,envr.test.ns,type='response')>=envr.ns.thresh,1,0)

envr.ns.cm <- as.data.frame(cbind(predicted=envr.ns.test.predicted,actual=envr.test.ns$sustainer)) %>% 
  mutate(TP=ifelse(actual==1&predicted==1,1,0),FP=ifelse(actual==0&predicted==1,1,0),
         TN=ifelse(actual==0&predicted==0,1,0),FN=ifelse(actual==1&predicted==0,1,0))

sum(envr.ns.cm$TP)/(sum(envr.ns.cm$TP)+sum(envr.ns.cm$FP))

# health2 model w/ non-scaled data
health2.ns.model.full <- glm(as.factor(sustainer)~.-gift_avg_t12m-gift_count_lt,data=health2.train.ns,family='binomial')
vif(health2.ns.model.full)

health2.ns.model.step <- step(glm(as.factor(sustainer)~.-gift_avg_t12m-gift_count_lt,data=health2.train.ns,family='binomial'),k=log(dim(health2.train.ns)[1]))

health2.ns.final.model <- glm(health2.ns.model.step$formula,data=health2.train.ns,family='binomial')

health2.ns.thresh <- thresh_finder(health2.ns.final.model,health2.train.ns)
mean(ifelse(predict(health2.ns.final.model,health2.train.ns,type='response')>=health2.ns.thresh,1,0)==health2.train.ns$sustainer)
mean(ifelse(predict(health2.ns.final.model,health2.test.ns,type='response')>=health2.ns.thresh,1,0)==health2.test.ns$sustainer)

health2.ns.test.predicted <- ifelse(predict(health2.ns.final.model,health2.test.ns,type='response')>=health2.ns.thresh,1,0)

health2.ns.cm <- as.data.frame(cbind(predicted=health2.ns.test.predicted,actual=health2.test.ns$sustainer)) %>% 
  mutate(TP=ifelse(actual==1&predicted==1,1,0),FP=ifelse(actual==0&predicted==1,1,0),
         TN=ifelse(actual==0&predicted==0,1,0),FN=ifelse(actual==1&predicted==0,1,0))

sum(health2.ns.cm$TP)/(sum(health2.ns.cm$TP)+sum(health2.ns.cm$FP))

# health model w/ non-scaled data
health.ns.model.full <- glm(as.factor(sustainer)~.-gift_avg_t12m,data=health.train.ns,family='binomial')
vif(health.ns.model.full)

health.ns.model.step <- step(glm(as.factor(sustainer)~.-gift_avg_t12m,data=health.train.ns,family='binomial'),k=log(dim(health.train.ns)[1]))

health.ns.final.model <- glm(health.ns.model.step$formula,data=health.train.ns,family='binomial')

health.ns.thresh <- thresh_finder(health.ns.final.model,health.train.ns)
mean(ifelse(predict(health.ns.final.model,health.train.ns,type='response')>=health.ns.thresh,1,0)==health.train.ns$sustainer)
mean(ifelse(predict(health.ns.final.model,health.test.ns,type='response')>=health.ns.thresh,1,0)==health.test.ns$sustainer)

health.ns.test.predicted <- ifelse(predict(health.ns.final.model,health.test.ns,type='response')>=health.ns.thresh,1,0)

health.ns.cm <- as.data.frame(cbind(predicted=health.ns.test.predicted,actual=health.test.ns$sustainer)) %>% 
  mutate(TP=ifelse(actual==1&predicted==1,1,0),FP=ifelse(actual==0&predicted==1,1,0),
         TN=ifelse(actual==0&predicted==0,1,0),FN=ifelse(actual==1&predicted==0,1,0))

sum(health.ns.cm$TP)/(sum(health.ns.cm$TP)+sum(health.ns.cm$FP))

# social model w/ non-scaled data
social.ns.model.full <- glm(as.factor(sustainer)~.-gift_avg_t12m,data=social.train.ns,family='binomial')
vif(social.ns.model.full)

social.ns.model.step <- step(glm(as.factor(sustainer)~.-gift_avg_t12m,data=social.train.ns,family='binomial'),k=log(dim(social.train.ns)[1]))

social.ns.final.model <- glm(social.ns.model.step$formula,data=social.train.ns,family='binomial')

social.ns.thresh <- thresh_finder(social.ns.final.model,social.train.ns)
mean(ifelse(predict(social.ns.final.model,social.train.ns,type='response')>=social.ns.thresh,1,0)==social.train.ns$sustainer)
mean(ifelse(predict(social.ns.final.model,social.test.ns,type='response')>=social.ns.thresh,1,0)==social.test.ns$sustainer)

social.ns.test.predicted <- ifelse(predict(social.ns.final.model,social.test.ns,type='response')>=social.ns.thresh,1,0)

social.ns.cm <- as.data.frame(cbind(predicted=social.ns.test.predicted,actual=social.test.ns$sustainer)) %>% 
  mutate(TP=ifelse(actual==1&predicted==1,1,0),FP=ifelse(actual==0&predicted==1,1,0),
         TN=ifelse(actual==0&predicted==0,1,0),FN=ifelse(actual==1&predicted==0,1,0))

sum(social.ns.cm$TP)/(sum(social.ns.cm$TP)+sum(social.ns.cm$FP))

# veteran model w/ non-scaled data
#veteran.ns.model.full <- glm(as.factor(sustainer)~.-gift_avg_t12m-cons_month_lt-dm_t12m-tm_t12m-wm_t12m-digital_t12m-events_t12m-other_t12m,data=veteran.train.ns,family='binomial')
veteran.ns.model.full <- glm(as.factor(sustainer)~.-gift_count_lt-gift_avg_t12m-gift_count_t12m,data=veteran.train.ns,family='binomial')
vif(veteran.ns.model.full)

veteran.ns.model.step <- step(glm(as.factor(sustainer)~.-gift_count_lt-gift_avg_t12m-gift_count_t12m,data=veteran.train.ns,family='binomial'),k=log(dim(veteran.train.ns)[1]))

veteran.ns.final.model <- glm(veteran.ns.model.step$formula,data=veteran.train.ns,family='binomial')

veteran.ns.thresh <- thresh_finder(veteran.ns.final.model,veteran.train.ns)
mean(ifelse(predict(veteran.ns.final.model,veteran.train.ns,type='response')>=veteran.ns.thresh,1,0)==veteran.train.ns$sustainer)
mean(ifelse(predict(veteran.ns.final.model,veteran.test.ns,type='response')>=veteran.ns.thresh,1,0)==veteran.test.ns$sustainer)

veteran.ns.test.predicted <- ifelse(predict(veteran.ns.final.model,veteran.test.ns,type='response')>=veteran.ns.thresh,1,0)

veteran.ns.cm <- as.data.frame(cbind(predicted=veteran.ns.test.predicted,actual=veteran.test.ns$sustainer)) %>% 
  mutate(TP=ifelse(actual==1&predicted==1,1,0),FP=ifelse(actual==0&predicted==1,1,0),
         TN=ifelse(actual==0&predicted==0,1,0),FN=ifelse(actual==1&predicted==0,1,0))

sum(veteran.ns.cm$TP)/(sum(veteran.ns.cm$TP)+sum(veteran.ns.cm$FP))



## random forest
# grid cv stuff
customRF <- list(type='Classification',library='randomForest',loop=NULL)
customRF$parameters <- data.frame(parameter=c('mtry','ntree'),class=rep('numeric',2),label=c('mtry','ntree'))
customRF$grid <- function(x,y,len=NULL,search='grid'){}
customRF$fit <- function(x,y,wts,param,lev,last,weights,classProbs,...){
  randomForest(x,y,mtry=param$mtry,ntree=param$ntree,...)
}
customRF$predict <- function(modelFit,newdata,preProc=NULL,submodels=NULL){
  predict(modelFit,newdata)
}
customRF$prob <- function(modelFit,newdata,preProc=NULL,submodels=NULL){
  predict(modelFit,newdata,type='prob')
}
customRF$sort <- function(x){x[order(x[,1]),]}
customRF$levels <- function(x){x$classes}
control <- trainControl(method='cv',number=5)

# advcy model w/ scaled data
#advcy.ctrl <- rfeControl(functions=rfFuncs,method='cv',number=5)
#advcy.result <- rfe(x=advcy.train.s[,-1],y=as.factor(advcy.train.s[,1]),sizes=seq(1,23,by=2),rfeControl=advcy.ctrl)
#write.csv(advcy.result$variables,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/rfe/advcy_rfe_results.csv',row.names=F)
#write.csv(advcy.result$results,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/rfe/advcy_rfe_results_s.csv',row.names=F)

#advcy.tunegrid <- expand.grid(.mtry=c(1:9),.ntree=c(1000,1500,2000,2500))
#advcy.custom <- train(as.factor(sustainer)~digital_t12m+cons_month_lt+client_zip_rank+gift_min_lt+
#                        client_state_rank+gender+gift_max_lt+tm_t12m+gift_avg_lt
#                      ,data=advcy.train.s,method=customRF,metric='Accuracy',tuneGrid=advcy.tunegrid,trControl=control)
#write.csv(advcy.custom$results,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/rf_ht/advcy_results_s.csv',row.names=F)

advcy.rf.model.s <- randomForest(as.factor(sustainer)~digital_t12m+cons_month_lt+client_zip_rank+gift_min_lt+
                                   client_state_rank+gender+gift_max_lt+tm_t12m+gift_avg_lt
                                 ,data=advcy.train.s,mtry=8,ntree=2000)

# envr model w/ scaled data
#envr.ctrl <- rfeControl(functions=rfFuncs,method='cv',number=5)
#envr.result <- rfe(x=envr.train.s[,-1],y=as.factor(envr.train.s[,1]),sizes=seq(1,23,by=2),rfeControl=envr.ctrl)
#write.csv(envr.result$variables,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/rfe/envr_rfe_results.csv',row.names=F)
#write.csv(envr.result$results,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/rfe/envr_rfe_results_s.csv',row.names=F)

envr.tunegrid <- expand.grid(.mtry=c(1:17),.ntree=c(1000,1500,2000,2500))
envr.custom <- train(as.factor(sustainer)~client_zip_rank+client_state_rank+age+digital_t12m+dm_t12m+
                       gift_max_lt+gift_count_t12m+gift_avg_lt+gift_max_t12m+gift_count_lt+cons_month_lt+
                       gender+gift_min_t12m+member_t12m+gift_min_lt+gift_avg_t12m+promo_count_lt
                     ,data=envr.train.s,method=customRF,metric='Accuracy',tuneGrid=envr.tunegrid,trControl=control)
write.csv(envr.custom$results,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/rf_ht/envr_results_s.csv',row.names=F)

# health2 model w/ scaled data
#health2.ctrl <- rfeControl(functions=rfFuncs,method='cv',number=5)
#health2.result <- rfe(x=health2.train.s[,-1],y=as.factor(health2.train.s[,1]),sizes=seq(1,21,by=2),rfeControl=health2.ctrl)
#write.csv(health2.result$variables,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/rfe/health2_rfe_results.csv',row.names=F)
#write.csv(health2.result$results,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/rfe/health2_rfe_results_s.csv',row.names=F)

health2.tunegrid <- expand.grid(.mtry=c(1:15),.ntree=c(1000,1500,2000,2500))
health2.custom <- train(as.factor(sustainer)~cons_month_lt+age+client_zip_rank+digital_t12m+
                          dm_t12m+gift_count_lt+gift_min_lt+gift_avg_lt+gift_avg_t12m+gift_max_lt+
                          gift_min_t12m+wm_t12m+promo_count_lt+gift_max_t12m+cons_month_t12m+gift_count_t12m
                        ,data=health2.train.s,method=customRF,metric='Accuracy',tuneGrid=health2.tunegrid,trControl=control)
write.csv(health2.custom$results,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/rf_ht/health2_results_s.csv',row.names=F)

# health model w/ scaled data
#health.ctrl <- rfeControl(functions=rfFuncs,method='cv',number=5)
#health.result <- rfe(x=health.train.s[,-1],y=as.factor(health.train.s[,1]),sizes=seq(1,19,by=2),rfeControl=health.ctrl)
#write.csv(health.result$variables,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/rfe/health_rfe_results.csv',row.names=F)
#write.csv(health.result$results,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/rfe/health_rfe_results_s.csv',row.names=F)

health.tunegrid <- expand.grid(.mtry=c(1:9),.ntree=c(1000,1500,2000,2500))
health.custom <- train(as.factor(sustainer)~client_zip_rank+digital_t12m+cons_month_lt+gift_avg_lt+promo_count_lt+
                         gift_min_lt+gift_avg_t12m+gift_min_t12m+gift_max_lt+gender+gift_count_lt
                       ,data=health.train.s,method=customRF,metric='Accuracy',tuneGrid=health.tunegrid,trControl=control)
write.csv(health.custom$results,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/rf_ht/health_results_s.csv',row.names=F)

# social model w/ scaled data
#social.ctrl <- rfeControl(functions=rfFuncs,method='cv',number=5)
#social.result <- rfe(x=social.train.s[,-1],y=as.factor(social.train.s[,1]),sizes=seq(1,23,by=2),rfeControl=social.ctrl)
#write.csv(social.result$variables,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/rfe/social_rfe_results.csv',row.names=F)
#write.csv(social.result$results,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/rfe/social_rfe_results_s.csv',row.names=F)

social.tunegrid <- expand.grid(.mtry=c(1:11),.ntree=c(1000,1500,2000,2500))
social.custom <- train(as.factor(sustainer)~client_state_rank+client_zip_rank+cons_month_lt+gift_max_lt+promo_count_lt+
                         gender+wm_t12m+gift_min_lt+gift_avg_lt+other_t12m+
                         gift_max_t12m
                       ,data=social.train.s,method=customRF,metric='Accuracy',tuneGrid=social.tunegrid,trControl=control)
write.csv(social.custom$results,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/rf_ht/social_results_s.csv',row.names=F)

# veteran model w/ scaled data
#veteran.ctrl <- rfeControl(functions=rfFuncs,method='cv',number=5)
#veteran.result <- rfe(x=veteran.train.s[,-1],y=as.factor(veteran.train.s[,1]),sizes=seq(1,21,by=2),rfeControl=veteran.ctrl)
#write.csv(veteran.result$variables,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/rfe/veteran_rfe_var_s.csv',row.names=F)
#write.csv(veteran.result$results,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/rfe/veteran_rfe_results_s.csv',row.names=F)

veteran.tunegrid <- expand.grid(.mtry=c(1:9),.ntree=c(1000,1500,2000,2500))
veteran.custom <- train(as.factor(sustainer)~client_zip_rank+client_state_rank+age+cons_month_lt+
                          gift_avg_lt+digital_t12m+gift_max_lt+gender+gift_min_lt
                        ,data=veteran.train.s,method=customRF,metric='Accuracy',tuneGrid=veteran.tunegrid,trControl=control)
write.csv(veteran.custom$results,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/rf_ht/veteran_results_s.csv',row.names=F)
