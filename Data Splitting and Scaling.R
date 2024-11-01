library(dplyr)

advcy.file = 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/advcydata_without_outliers.csv'
envr.file = 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/envrdata_without_outliers.csv'
health2.file = 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/health2data_without_outliers.csv'
health.file = 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/healthdata_without_outliers.csv'
social.file = 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/socialdata_without_outliers.csv'
veteran.file = 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/veterandata_without_outliers.csv'
generic.file = 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/genericdata_without_outliers.csv'

advcy.data = read.csv(advcy.file,header=T)
envr.data = read.csv(envr.file,header=T)
health2.data = read.csv(health2.file,header=T)
health.data = read.csv(health.file,header=T)
social.data = read.csv(social.file,header=T)
veteran.data = read.csv(veteran.file,header=T)
generic.data = read.csv(generic.file,header=T)

# 70-30 train-test split of data
set.seed(42)
advcy.0 <- advcy.data[advcy.data$sustainer==0,]
advcy.1 <- advcy.data[advcy.data$sustainer==1,]
advcy.0.n <- dim(advcy.0)[1]
advcy.1.n <- dim(advcy.1)[1]
advcy.0.flag <- sort(sample(1:advcy.0.n,round((advcy.0.n*3)/10)))
advcy.1.flag <- sort(sample(1:advcy.1.n,round((advcy.1.n*3)/10)))
advcy.train <- rbind(advcy.0[-advcy.0.flag,],advcy.1[-advcy.1.flag,])
advcy.test <- rbind(advcy.0[advcy.0.flag,],advcy.1[advcy.1.flag,])

envr.0 <- envr.data[envr.data$sustainer==0,]
envr.1 <- envr.data[envr.data$sustainer==1,]
envr.0.n <- dim(envr.0)[1]
envr.1.n <- dim(envr.1)[1]
envr.0.flag <- sort(sample(1:envr.0.n,round((envr.0.n*3)/10)))
envr.1.flag <- sort(sample(1:envr.1.n,round((envr.1.n*3)/10)))
envr.train <- rbind(envr.0[-envr.0.flag,],envr.1[-envr.1.flag,])
envr.test <- rbind(envr.0[envr.0.flag,],envr.1[envr.1.flag,])

health2.0 <- health2.data[health2.data$sustainer==0,]
health2.1 <- health2.data[health2.data$sustainer==1,]
health2.0.n <- dim(health2.0)[1]
health2.1.n <- dim(health2.1)[1]
health2.0.flag <- sort(sample(1:health2.0.n,round((health2.0.n*3)/10)))
health2.1.flag <- sort(sample(1:health2.1.n,round((health2.1.n*3)/10)))
health2.train <- rbind(health2.0[-health2.0.flag,],health2.1[-health2.1.flag,])
health2.test <- rbind(health2.0[health2.0.flag,],health2.1[health2.1.flag,])

health.0 <- health.data[health.data$sustainer==0,]
health.1 <- health.data[health.data$sustainer==1,]
health.0.n <- dim(health.0)[1]
health.1.n <- dim(health.1)[1]
health.0.flag <- sort(sample(1:health.0.n,round((health.0.n*3)/10)))
health.1.flag <- sort(sample(1:health.1.n,round((health.1.n*3)/10)))
health.train <- rbind(health.0[-health.0.flag,],health.1[-health.1.flag,])
health.test <- rbind(health.0[health.0.flag,],health.1[health.1.flag,])

social.0 <- social.data[social.data$sustainer==0,]
social.1 <- social.data[social.data$sustainer==1,]
social.0.n <- dim(social.0)[1]
social.1.n <- dim(social.1)[1]
social.0.flag <- sort(sample(1:social.0.n,round((social.0.n*3)/10)))
social.1.flag <- sort(sample(1:social.1.n,round((social.1.n*3)/10)))
social.train <- rbind(social.0[-social.0.flag,],social.1[-social.1.flag,])
social.test <- rbind(social.0[social.0.flag,],social.1[social.1.flag,])

veteran.0 <- veteran.data[veteran.data$sustainer==0,]
veteran.1 <- veteran.data[veteran.data$sustainer==1,]
veteran.0.n <- dim(veteran.0)[1]
veteran.1.n <- dim(veteran.1)[1]
veteran.0.flag <- sort(sample(1:veteran.0.n,round((veteran.0.n*3)/10)))
veteran.1.flag <- sort(sample(1:veteran.1.n,round((veteran.1.n*3)/10)))
veteran.train <- rbind(veteran.0[-veteran.0.flag,],veteran.1[-veteran.1.flag,])
veteran.test <- rbind(veteran.0[veteran.0.flag,],veteran.1[veteran.1.flag,])

generic.0 <- generic.data[generic.data$sustainer==0,]
generic.1 <- generic.data[generic.data$sustainer==1,]
generic.0.n <- dim(generic.0)[1]
generic.1.n <- dim(generic.1)[1]
generic.0.flag <- sort(sample(1:generic.0.n,round((generic.0.n*3)/10)))
generic.1.flag <- sort(sample(1:generic.1.n,round((generic.1.n*3)/10)))
generic.train <- rbind(generic.0[-generic.0.flag,],generic.1[-generic.1.flag,])
generic.test <- rbind(generic.0[generic.0.flag,],generic.1[generic.1.flag,])

# export the non-scaled data
write.csv(advcy.train,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/advcy_train_wo_outliers_wo_scaling.csv',row.names=F)
write.csv(advcy.test,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/advcy_test_wo_outliers_wo_scaling.csv',row.names=F)
write.csv(envr.train,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/envr_train_wo_outliers_wo_scaling.csv',row.names=F)
write.csv(envr.test,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/envr_test_wo_outliers_wo_scaling.csv',row.names=F)
write.csv(health2.train,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/health2_train_wo_outliers_wo_scaling.csv',row.names=F)
write.csv(health2.test,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/health2_test_wo_outliers_wo_scaling.csv',row.names=F)
write.csv(health.train,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/health_train_wo_outliers_wo_scaling.csv',row.names=F)
write.csv(health.test,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/health_test_wo_outliers_wo_scaling.csv',row.names=F)
write.csv(social.train,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/social_train_wo_outliers_wo_scaling.csv',row.names=F)
write.csv(social.test,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/social_test_wo_outliers_wo_scaling.csv',row.names=F)
write.csv(veteran.train,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/veteran_train_wo_outliers_wo_scaling.csv',row.names=F)
write.csv(veteran.test,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/veteran_test_wo_outliers_wo_scaling.csv',row.names=F)
write.csv(generic.train,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/generic_train_wo_outliers_wo_scaling.csv',row.names=F)
write.csv(generic.test,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_wo_scaling/generic_test_wo_outliers_wo_scaling.csv',row.names=F)

# scaling
advcy.train.client.state.rank.mean <- mean(advcy.train$client_state_rank)
advcy.train.client.state.rank.sd <- sd(advcy.train$client_state_rank)
advcy.train.client.zip.rank.mean <- mean(advcy.train$client_zip_rank)
advcy.train.client.zip.rank.sd <- sd(advcy.train$client_zip_rank)
advcy.train.gift.min.t12m.mean <- mean(advcy.train$gift_min_t12m)
advcy.train.gift.min.t12m.sd <- sd(advcy.train$gift_min_t12m)
advcy.train.gift.max.t12m.mean <- mean(advcy.train$gift_max_t12m)
advcy.train.gift.max.t12m.sd <- sd(advcy.train$gift_max_t12m)
advcy.train.gift.avg.t12m.mean <- mean(advcy.train$gift_avg_t12m)
advcy.train.gift.avg.t12m.sd <- sd(advcy.train$gift_avg_t12m)
advcy.train.gift.count.t12m.mean <- mean(advcy.train$gift_count_t12m)
advcy.train.gift.count.t12m.sd <- sd(advcy.train$gift_count_t12m)
advcy.train.promo.count.t12m.mean <- mean(advcy.train$promo_count_t12m)
advcy.train.promo.count.t12m.sd <- sd(advcy.train$promo_count_t12m)
advcy.train.cons.month.t12m.mean <- mean(advcy.train$cons_month_t12m)
advcy.train.cons.month.t12m.sd <- sd(advcy.train$cons_month_t12m)
advcy.train.gift.min.lt.mean <- mean(advcy.train$gift_min_lt)
advcy.train.gift.min.lt.sd <- sd(advcy.train$gift_min_lt)
advcy.train.gift.max.lt.mean <- mean(advcy.train$gift_max_lt)
advcy.train.gift.max.lt.sd <- sd(advcy.train$gift_max_lt)
advcy.train.gift.avg.lt.mean <- mean(advcy.train$gift_avg_lt)
advcy.train.gift.avg.lt.sd <- sd(advcy.train$gift_avg_lt)
advcy.train.gift.count.lt.mean <- mean(advcy.train$gift_count_lt)
advcy.train.gift.count.lt.sd <- sd(advcy.train$gift_count_lt)
advcy.train.promo.count.lt.mean <- mean(advcy.train$promo_count_lt)
advcy.train.promo.count.lt.sd <- sd(advcy.train$promo_count_lt)
advcy.train.cons.month.lt.mean <- mean(advcy.train$cons_month_lt)
advcy.train.cons.month.lt.sd <- sd(advcy.train$cons_month_lt)

advcy.train.scaled <- advcy.train %>% mutate(client_state_rank=(client_state_rank-advcy.train.client.state.rank.mean)/advcy.train.client.state.rank.sd,
                                             client_zip_rank=(client_zip_rank-advcy.train.client.zip.rank.mean)/advcy.train.client.zip.rank.sd,
                                             gift_min_t12m=(gift_min_t12m-advcy.train.gift.min.t12m.mean)/advcy.train.gift.min.t12m.sd,
                                             gift_max_t12m=(gift_max_t12m-advcy.train.gift.max.t12m.mean)/advcy.train.gift.max.t12m.sd,
                                             gift_avg_t12m=(gift_avg_t12m-advcy.train.gift.avg.t12m.mean)/advcy.train.gift.avg.t12m.sd,
                                             gift_count_t12m=(gift_count_t12m-advcy.train.gift.count.t12m.mean)/advcy.train.gift.count.t12m.sd,
                                             promo_count_t12m=(promo_count_t12m-advcy.train.promo.count.t12m.mean)/advcy.train.promo.count.t12m.sd,
                                             cons_month_t12m=(cons_month_t12m-advcy.train.cons.month.t12m.mean)/advcy.train.cons.month.t12m.sd,
                                             gift_min_lt=(gift_min_lt-advcy.train.gift.min.lt.mean)/advcy.train.gift.min.lt.sd,
                                             gift_max_lt=(gift_max_lt-advcy.train.gift.max.lt.mean)/advcy.train.gift.max.lt.sd,
                                             gift_avg_lt=(gift_avg_lt-advcy.train.gift.avg.lt.mean)/advcy.train.gift.avg.lt.sd,
                                             gift_count_lt=(gift_count_lt-advcy.train.gift.count.lt.mean)/advcy.train.gift.count.lt.sd,
                                             promo_count_lt=(promo_count_lt-advcy.train.promo.count.lt.mean)/advcy.train.promo.count.lt.sd,
                                             cons_month_lt=(cons_month_lt-advcy.train.cons.month.lt.mean)/advcy.train.cons.month.lt.sd)

advcy.test.scaled <- advcy.test %>% mutate(client_state_rank=(client_state_rank-advcy.train.client.state.rank.mean)/advcy.train.client.state.rank.sd,
                                             client_zip_rank=(client_zip_rank-advcy.train.client.zip.rank.mean)/advcy.train.client.zip.rank.sd,
                                             gift_min_t12m=(gift_min_t12m-advcy.train.gift.min.t12m.mean)/advcy.train.gift.min.t12m.sd,
                                             gift_max_t12m=(gift_max_t12m-advcy.train.gift.max.t12m.mean)/advcy.train.gift.max.t12m.sd,
                                             gift_avg_t12m=(gift_avg_t12m-advcy.train.gift.avg.t12m.mean)/advcy.train.gift.avg.t12m.sd,
                                             gift_count_t12m=(gift_count_t12m-advcy.train.gift.count.t12m.mean)/advcy.train.gift.count.t12m.sd,
                                             promo_count_t12m=(promo_count_t12m-advcy.train.promo.count.t12m.mean)/advcy.train.promo.count.t12m.sd,
                                             cons_month_t12m=(cons_month_t12m-advcy.train.cons.month.t12m.mean)/advcy.train.cons.month.t12m.sd,
                                             gift_min_lt=(gift_min_lt-advcy.train.gift.min.lt.mean)/advcy.train.gift.min.lt.sd,
                                             gift_max_lt=(gift_max_lt-advcy.train.gift.max.lt.mean)/advcy.train.gift.max.lt.sd,
                                             gift_avg_lt=(gift_avg_lt-advcy.train.gift.avg.lt.mean)/advcy.train.gift.avg.lt.sd,
                                             gift_count_lt=(gift_count_lt-advcy.train.gift.count.lt.mean)/advcy.train.gift.count.lt.sd,
                                             promo_count_lt=(promo_count_lt-advcy.train.promo.count.lt.mean)/advcy.train.promo.count.lt.sd,
                                             cons_month_lt=(cons_month_lt-advcy.train.cons.month.lt.mean)/advcy.train.cons.month.lt.sd)

envr.train.client.state.rank.mean <- mean(envr.train$client_state_rank)
envr.train.client.state.rank.sd <- sd(envr.train$client_state_rank)
envr.train.age.mean <- mean(envr.train$age)
envr.train.age.sd <- sd(envr.train$age)
envr.train.client.zip.rank.mean <- mean(envr.train$client_zip_rank)
envr.train.client.zip.rank.sd <- sd(envr.train$client_zip_rank)
envr.train.gift.min.t12m.mean <- mean(envr.train$gift_min_t12m)
envr.train.gift.min.t12m.sd <- sd(envr.train$gift_min_t12m)
envr.train.gift.max.t12m.mean <- mean(envr.train$gift_max_t12m)
envr.train.gift.max.t12m.sd <- sd(envr.train$gift_max_t12m)
envr.train.gift.avg.t12m.mean <- mean(envr.train$gift_avg_t12m)
envr.train.gift.avg.t12m.sd <- sd(envr.train$gift_avg_t12m)
envr.train.gift.count.t12m.mean <- mean(envr.train$gift_count_t12m)
envr.train.gift.count.t12m.sd <- sd(envr.train$gift_count_t12m)
envr.train.promo.count.t12m.mean <- mean(envr.train$promo_count_t12m)
envr.train.promo.count.t12m.sd <- sd(envr.train$promo_count_t12m)
envr.train.cons.month.t12m.mean <- mean(envr.train$cons_month_t12m)
envr.train.cons.month.t12m.sd <- sd(envr.train$cons_month_t12m)
envr.train.gift.min.lt.mean <- mean(envr.train$gift_min_lt)
envr.train.gift.min.lt.sd <- sd(envr.train$gift_min_lt)
envr.train.gift.max.lt.mean <- mean(envr.train$gift_max_lt)
envr.train.gift.max.lt.sd <- sd(envr.train$gift_max_lt)
envr.train.gift.avg.lt.mean <- mean(envr.train$gift_avg_lt)
envr.train.gift.avg.lt.sd <- sd(envr.train$gift_avg_lt)
envr.train.gift.count.lt.mean <- mean(envr.train$gift_count_lt)
envr.train.gift.count.lt.sd <- sd(envr.train$gift_count_lt)
envr.train.promo.count.lt.mean <- mean(envr.train$promo_count_lt)
envr.train.promo.count.lt.sd <- sd(envr.train$promo_count_lt)
envr.train.cons.month.lt.mean <- mean(envr.train$cons_month_lt)
envr.train.cons.month.lt.sd <- sd(envr.train$cons_month_lt)

envr.train.scaled <- envr.train %>% mutate(client_state_rank=(client_state_rank-envr.train.client.state.rank.mean)/envr.train.client.state.rank.sd,
                                           client_zip_rank=(client_zip_rank-envr.train.client.zip.rank.mean)/envr.train.client.zip.rank.sd,
                                           age=(age-envr.train.age.mean)/envr.train.age.sd,
                                           gift_min_t12m=(gift_min_t12m-envr.train.gift.min.t12m.mean)/envr.train.gift.min.t12m.sd,
                                           gift_max_t12m=(gift_max_t12m-envr.train.gift.max.t12m.mean)/envr.train.gift.max.t12m.sd,
                                           gift_avg_t12m=(gift_avg_t12m-envr.train.gift.avg.t12m.mean)/envr.train.gift.avg.t12m.sd,
                                           gift_count_t12m=(gift_count_t12m-envr.train.gift.count.t12m.mean)/envr.train.gift.count.t12m.sd,
                                           promo_count_t12m=(promo_count_t12m-envr.train.promo.count.t12m.mean)/envr.train.promo.count.t12m.sd,
                                           cons_month_t12m=(cons_month_t12m-envr.train.cons.month.t12m.mean)/envr.train.cons.month.t12m.sd,
                                           gift_min_lt=(gift_min_lt-envr.train.gift.min.lt.mean)/envr.train.gift.min.lt.sd,
                                           gift_max_lt=(gift_max_lt-envr.train.gift.max.lt.mean)/envr.train.gift.max.lt.sd,
                                           gift_avg_lt=(gift_avg_lt-envr.train.gift.avg.lt.mean)/envr.train.gift.avg.lt.sd,
                                           gift_count_lt=(gift_count_lt-envr.train.gift.count.lt.mean)/envr.train.gift.count.lt.sd,
                                           promo_count_lt=(promo_count_lt-envr.train.promo.count.lt.mean)/envr.train.promo.count.lt.sd,
                                           cons_month_lt=(cons_month_lt-envr.train.cons.month.lt.mean)/envr.train.cons.month.lt.sd)

envr.test.scaled <- envr.test %>% mutate(client_state_rank=(client_state_rank-envr.train.client.state.rank.mean)/envr.train.client.state.rank.sd,
                                         client_zip_rank=(client_zip_rank-envr.train.client.zip.rank.mean)/envr.train.client.zip.rank.sd,
                                         age=(age-envr.train.age.mean)/envr.train.age.sd,
                                         gift_min_t12m=(gift_min_t12m-envr.train.gift.min.t12m.mean)/envr.train.gift.min.t12m.sd,
                                         gift_max_t12m=(gift_max_t12m-envr.train.gift.max.t12m.mean)/envr.train.gift.max.t12m.sd,
                                         gift_avg_t12m=(gift_avg_t12m-envr.train.gift.avg.t12m.mean)/envr.train.gift.avg.t12m.sd,
                                         gift_count_t12m=(gift_count_t12m-envr.train.gift.count.t12m.mean)/envr.train.gift.count.t12m.sd,
                                         promo_count_t12m=(promo_count_t12m-envr.train.promo.count.t12m.mean)/envr.train.promo.count.t12m.sd,
                                         cons_month_t12m=(cons_month_t12m-envr.train.cons.month.t12m.mean)/envr.train.cons.month.t12m.sd,
                                         gift_min_lt=(gift_min_lt-envr.train.gift.min.lt.mean)/envr.train.gift.min.lt.sd,
                                         gift_max_lt=(gift_max_lt-envr.train.gift.max.lt.mean)/envr.train.gift.max.lt.sd,
                                         gift_avg_lt=(gift_avg_lt-envr.train.gift.avg.lt.mean)/envr.train.gift.avg.lt.sd,
                                         gift_count_lt=(gift_count_lt-envr.train.gift.count.lt.mean)/envr.train.gift.count.lt.sd,
                                         promo_count_lt=(promo_count_lt-envr.train.promo.count.lt.mean)/envr.train.promo.count.lt.sd,
                                         cons_month_lt=(cons_month_lt-envr.train.cons.month.lt.mean)/envr.train.cons.month.lt.sd)

health2.train.client.state.rank.mean <- mean(health2.train$client_state_rank)
health2.train.client.state.rank.sd <- sd(health2.train$client_state_rank)
health2.train.client.zip.rank.mean <- mean(health2.train$client_zip_rank)
health2.train.client.zip.rank.sd <- sd(health2.train$client_zip_rank)
health2.train.age.mean <- mean(health2.train$age)
health2.train.age.sd <- sd(health2.train$age)
health2.train.gift.min.t12m.mean <- mean(health2.train$gift_min_t12m)
health2.train.gift.min.t12m.sd <- sd(health2.train$gift_min_t12m)
health2.train.gift.max.t12m.mean <- mean(health2.train$gift_max_t12m)
health2.train.gift.max.t12m.sd <- sd(health2.train$gift_max_t12m)
health2.train.gift.avg.t12m.mean <- mean(health2.train$gift_avg_t12m)
health2.train.gift.avg.t12m.sd <- sd(health2.train$gift_avg_t12m)
health2.train.gift.count.t12m.mean <- mean(health2.train$gift_count_t12m)
health2.train.gift.count.t12m.sd <- sd(health2.train$gift_count_t12m)
health2.train.promo.count.t12m.mean <- mean(health2.train$promo_count_t12m)
health2.train.promo.count.t12m.sd <- sd(health2.train$promo_count_t12m)
health2.train.cons.month.t12m.mean <- mean(health2.train$cons_month_t12m)
health2.train.cons.month.t12m.sd <- sd(health2.train$cons_month_t12m)
health2.train.gift.min.lt.mean <- mean(health2.train$gift_min_lt)
health2.train.gift.min.lt.sd <- sd(health2.train$gift_min_lt)
health2.train.gift.max.lt.mean <- mean(health2.train$gift_max_lt)
health2.train.gift.max.lt.sd <- sd(health2.train$gift_max_lt)
health2.train.gift.avg.lt.mean <- mean(health2.train$gift_avg_lt)
health2.train.gift.avg.lt.sd <- sd(health2.train$gift_avg_lt)
health2.train.gift.count.lt.mean <- mean(health2.train$gift_count_lt)
health2.train.gift.count.lt.sd <- sd(health2.train$gift_count_lt)
health2.train.promo.count.lt.mean <- mean(health2.train$promo_count_lt)
health2.train.promo.count.lt.sd <- sd(health2.train$promo_count_lt)
health2.train.cons.month.lt.mean <- mean(health2.train$cons_month_lt)
health2.train.cons.month.lt.sd <- sd(health2.train$cons_month_lt)

health2.train.scaled <- health2.train %>% mutate(client_state_rank=(client_state_rank-health2.train.client.state.rank.mean)/health2.train.client.state.rank.sd,
                                                 client_zip_rank=(client_zip_rank-health2.train.client.zip.rank.mean)/health2.train.client.zip.rank.sd,
                                                 age=(age-health2.train.age.mean)/health2.train.age.sd,
                                                 gift_min_t12m=(gift_min_t12m-health2.train.gift.min.t12m.mean)/health2.train.gift.min.t12m.sd,
                                                 gift_max_t12m=(gift_max_t12m-health2.train.gift.max.t12m.mean)/health2.train.gift.max.t12m.sd,
                                                 gift_avg_t12m=(gift_avg_t12m-health2.train.gift.avg.t12m.mean)/health2.train.gift.avg.t12m.sd,
                                                 gift_count_t12m=(gift_count_t12m-health2.train.gift.count.t12m.mean)/health2.train.gift.count.t12m.sd,
                                                 promo_count_t12m=(promo_count_t12m-health2.train.promo.count.t12m.mean)/health2.train.promo.count.t12m.sd,
                                                 cons_month_t12m=(cons_month_t12m-health2.train.cons.month.t12m.mean)/health2.train.cons.month.t12m.sd,
                                                 gift_min_lt=(gift_min_lt-health2.train.gift.min.lt.mean)/health2.train.gift.min.lt.sd,
                                                 gift_max_lt=(gift_max_lt-health2.train.gift.max.lt.mean)/health2.train.gift.max.lt.sd,
                                                 gift_avg_lt=(gift_avg_lt-health2.train.gift.avg.lt.mean)/health2.train.gift.avg.lt.sd,
                                                 gift_count_lt=(gift_count_lt-health2.train.gift.count.lt.mean)/health2.train.gift.count.lt.sd,
                                                 promo_count_lt=(promo_count_lt-health2.train.promo.count.lt.mean)/health2.train.promo.count.lt.sd,
                                                 cons_month_lt=(cons_month_lt-health2.train.cons.month.lt.mean)/health2.train.cons.month.lt.sd)

health2.test.scaled <- health2.test %>% mutate(client_state_rank=(client_state_rank-health2.train.client.state.rank.mean)/health2.train.client.state.rank.sd,
                                               client_zip_rank=(client_zip_rank-health2.train.client.zip.rank.mean)/health2.train.client.zip.rank.sd,
                                               age=(age-health2.train.age.mean)/health2.train.age.sd,
                                               gift_min_t12m=(gift_min_t12m-health2.train.gift.min.t12m.mean)/health2.train.gift.min.t12m.sd,
                                               gift_max_t12m=(gift_max_t12m-health2.train.gift.max.t12m.mean)/health2.train.gift.max.t12m.sd,
                                               gift_avg_t12m=(gift_avg_t12m-health2.train.gift.avg.t12m.mean)/health2.train.gift.avg.t12m.sd,
                                               gift_count_t12m=(gift_count_t12m-health2.train.gift.count.t12m.mean)/health2.train.gift.count.t12m.sd,
                                               promo_count_t12m=(promo_count_t12m-health2.train.promo.count.t12m.mean)/health2.train.promo.count.t12m.sd,
                                               cons_month_t12m=(cons_month_t12m-health2.train.cons.month.t12m.mean)/health2.train.cons.month.t12m.sd,
                                               gift_min_lt=(gift_min_lt-health2.train.gift.min.lt.mean)/health2.train.gift.min.lt.sd,
                                               gift_max_lt=(gift_max_lt-health2.train.gift.max.lt.mean)/health2.train.gift.max.lt.sd,
                                               gift_avg_lt=(gift_avg_lt-health2.train.gift.avg.lt.mean)/health2.train.gift.avg.lt.sd,
                                               gift_count_lt=(gift_count_lt-health2.train.gift.count.lt.mean)/health2.train.gift.count.lt.sd,
                                               promo_count_lt=(promo_count_lt-health2.train.promo.count.lt.mean)/health2.train.promo.count.lt.sd,
                                               cons_month_lt=(cons_month_lt-health2.train.cons.month.lt.mean)/health2.train.cons.month.lt.sd)

health.train.client.state.rank.mean <- mean(health.train$client_state_rank)
health.train.client.state.rank.sd <- sd(health.train$client_state_rank)
health.train.client.zip.rank.mean <- mean(health.train$client_zip_rank)
health.train.client.zip.rank.sd <- sd(health.train$client_zip_rank)
health.train.gift.min.t12m.mean <- mean(health.train$gift_min_t12m)
health.train.gift.min.t12m.sd <- sd(health.train$gift_min_t12m)
health.train.gift.max.t12m.mean <- mean(health.train$gift_max_t12m)
health.train.gift.max.t12m.sd <- sd(health.train$gift_max_t12m)
health.train.gift.avg.t12m.mean <- mean(health.train$gift_avg_t12m)
health.train.gift.avg.t12m.sd <- sd(health.train$gift_avg_t12m)
health.train.gift.count.t12m.mean <- mean(health.train$gift_count_t12m)
health.train.gift.count.t12m.sd <- sd(health.train$gift_count_t12m)
health.train.promo.count.t12m.mean <- mean(health.train$promo_count_t12m)
health.train.promo.count.t12m.sd <- sd(health.train$promo_count_t12m)
health.train.cons.month.t12m.mean <- mean(health.train$cons_month_t12m)
health.train.cons.month.t12m.sd <- sd(health.train$cons_month_t12m)
health.train.gift.min.lt.mean <- mean(health.train$gift_min_lt)
health.train.gift.min.lt.sd <- sd(health.train$gift_min_lt)
health.train.gift.max.lt.mean <- mean(health.train$gift_max_lt)
health.train.gift.max.lt.sd <- sd(health.train$gift_max_lt)
health.train.gift.avg.lt.mean <- mean(health.train$gift_avg_lt)
health.train.gift.avg.lt.sd <- sd(health.train$gift_avg_lt)
health.train.gift.count.lt.mean <- mean(health.train$gift_count_lt)
health.train.gift.count.lt.sd <- sd(health.train$gift_count_lt)
health.train.promo.count.lt.mean <- mean(health.train$promo_count_lt)
health.train.promo.count.lt.sd <- sd(health.train$promo_count_lt)
health.train.cons.month.lt.mean <- mean(health.train$cons_month_lt)
health.train.cons.month.lt.sd <- sd(health.train$cons_month_lt)

health.train.scaled <- health.train %>% mutate(client_state_rank=(client_state_rank-health.train.client.state.rank.mean)/health.train.client.state.rank.sd,
                                               client_zip_rank=(client_zip_rank-health.train.client.zip.rank.mean)/health.train.client.zip.rank.sd,
                                               gift_min_t12m=(gift_min_t12m-health.train.gift.min.t12m.mean)/health.train.gift.min.t12m.sd,
                                               gift_max_t12m=(gift_max_t12m-health.train.gift.max.t12m.mean)/health.train.gift.max.t12m.sd,
                                               gift_avg_t12m=(gift_avg_t12m-health.train.gift.avg.t12m.mean)/health.train.gift.avg.t12m.sd,
                                               gift_count_t12m=(gift_count_t12m-health.train.gift.count.t12m.mean)/health.train.gift.count.t12m.sd,
                                               promo_count_t12m=(promo_count_t12m-health.train.promo.count.t12m.mean)/health.train.promo.count.t12m.sd,
                                               cons_month_t12m=(cons_month_t12m-health.train.cons.month.t12m.mean)/health.train.cons.month.t12m.sd,
                                               gift_min_lt=(gift_min_lt-health.train.gift.min.lt.mean)/health.train.gift.min.lt.sd,
                                               gift_max_lt=(gift_max_lt-health.train.gift.max.lt.mean)/health.train.gift.max.lt.sd,
                                               gift_avg_lt=(gift_avg_lt-health.train.gift.avg.lt.mean)/health.train.gift.avg.lt.sd,
                                               gift_count_lt=(gift_count_lt-health.train.gift.count.lt.mean)/health.train.gift.count.lt.sd,
                                               promo_count_lt=(promo_count_lt-health.train.promo.count.lt.mean)/health.train.promo.count.lt.sd,
                                               cons_month_lt=(cons_month_lt-health.train.cons.month.lt.mean)/health.train.cons.month.lt.sd)

health.test.scaled <- health.test %>% mutate(client_state_rank=(client_state_rank-health.train.client.state.rank.mean)/health.train.client.state.rank.sd,
                                             client_zip_rank=(client_zip_rank-health.train.client.zip.rank.mean)/health.train.client.zip.rank.sd,
                                             gift_min_t12m=(gift_min_t12m-health.train.gift.min.t12m.mean)/health.train.gift.min.t12m.sd,
                                             gift_max_t12m=(gift_max_t12m-health.train.gift.max.t12m.mean)/health.train.gift.max.t12m.sd,
                                             gift_avg_t12m=(gift_avg_t12m-health.train.gift.avg.t12m.mean)/health.train.gift.avg.t12m.sd,
                                             gift_count_t12m=(gift_count_t12m-health.train.gift.count.t12m.mean)/health.train.gift.count.t12m.sd,
                                             promo_count_t12m=(promo_count_t12m-health.train.promo.count.t12m.mean)/health.train.promo.count.t12m.sd,
                                             cons_month_t12m=(cons_month_t12m-health.train.cons.month.t12m.mean)/health.train.cons.month.t12m.sd,
                                             gift_min_lt=(gift_min_lt-health.train.gift.min.lt.mean)/health.train.gift.min.lt.sd,
                                             gift_max_lt=(gift_max_lt-health.train.gift.max.lt.mean)/health.train.gift.max.lt.sd,
                                             gift_avg_lt=(gift_avg_lt-health.train.gift.avg.lt.mean)/health.train.gift.avg.lt.sd,
                                             gift_count_lt=(gift_count_lt-health.train.gift.count.lt.mean)/health.train.gift.count.lt.sd,
                                             promo_count_lt=(promo_count_lt-health.train.promo.count.lt.mean)/health.train.promo.count.lt.sd,
                                             cons_month_lt=(cons_month_lt-health.train.cons.month.lt.mean)/health.train.cons.month.lt.sd)

social.train.client.state.rank.mean <- mean(social.train$client_state_rank)
social.train.client.state.rank.sd <- sd(social.train$client_state_rank)
social.train.client.zip.rank.mean <- mean(social.train$client_zip_rank)
social.train.client.zip.rank.sd <- sd(social.train$client_zip_rank)
social.train.gift.min.t12m.mean <- mean(social.train$gift_min_t12m)
social.train.gift.min.t12m.sd <- sd(social.train$gift_min_t12m)
social.train.gift.max.t12m.mean <- mean(social.train$gift_max_t12m)
social.train.gift.max.t12m.sd <- sd(social.train$gift_max_t12m)
social.train.gift.avg.t12m.mean <- mean(social.train$gift_avg_t12m)
social.train.gift.avg.t12m.sd <- sd(social.train$gift_avg_t12m)
social.train.gift.count.t12m.mean <- mean(social.train$gift_count_t12m)
social.train.gift.count.t12m.sd <- sd(social.train$gift_count_t12m)
social.train.promo.count.t12m.mean <- mean(social.train$promo_count_t12m)
social.train.promo.count.t12m.sd <- sd(social.train$promo_count_t12m)
social.train.cons.month.t12m.mean <- mean(social.train$cons_month_t12m)
social.train.cons.month.t12m.sd <- sd(social.train$cons_month_t12m)
social.train.gift.min.lt.mean <- mean(social.train$gift_min_lt)
social.train.gift.min.lt.sd <- sd(social.train$gift_min_lt)
social.train.gift.max.lt.mean <- mean(social.train$gift_max_lt)
social.train.gift.max.lt.sd <- sd(social.train$gift_max_lt)
social.train.gift.avg.lt.mean <- mean(social.train$gift_avg_lt)
social.train.gift.avg.lt.sd <- sd(social.train$gift_avg_lt)
social.train.gift.count.lt.mean <- mean(social.train$gift_count_lt)
social.train.gift.count.lt.sd <- sd(social.train$gift_count_lt)
social.train.promo.count.lt.mean <- mean(social.train$promo_count_lt)
social.train.promo.count.lt.sd <- sd(social.train$promo_count_lt)
social.train.cons.month.lt.mean <- mean(social.train$cons_month_lt)
social.train.cons.month.lt.sd <- sd(social.train$cons_month_lt)

social.train.scaled <- social.train %>% mutate(client_state_rank=(client_state_rank-social.train.client.state.rank.mean)/social.train.client.state.rank.sd,
                                               client_zip_rank=(client_zip_rank-social.train.client.zip.rank.mean)/social.train.client.zip.rank.sd,
                                               gift_min_t12m=(gift_min_t12m-social.train.gift.min.t12m.mean)/social.train.gift.min.t12m.sd,
                                               gift_max_t12m=(gift_max_t12m-social.train.gift.max.t12m.mean)/social.train.gift.max.t12m.sd,
                                               gift_avg_t12m=(gift_avg_t12m-social.train.gift.avg.t12m.mean)/social.train.gift.avg.t12m.sd,
                                               gift_count_t12m=(gift_count_t12m-social.train.gift.count.t12m.mean)/social.train.gift.count.t12m.sd,
                                               promo_count_t12m=(promo_count_t12m-social.train.promo.count.t12m.mean)/social.train.promo.count.t12m.sd,
                                               cons_month_t12m=(cons_month_t12m-social.train.cons.month.t12m.mean)/social.train.cons.month.t12m.sd,
                                               gift_min_lt=(gift_min_lt-social.train.gift.min.lt.mean)/social.train.gift.min.lt.sd,
                                               gift_max_lt=(gift_max_lt-social.train.gift.max.lt.mean)/social.train.gift.max.lt.sd,
                                               gift_avg_lt=(gift_avg_lt-social.train.gift.avg.lt.mean)/social.train.gift.avg.lt.sd,
                                               gift_count_lt=(gift_count_lt-social.train.gift.count.lt.mean)/social.train.gift.count.lt.sd,
                                               promo_count_lt=(promo_count_lt-social.train.promo.count.lt.mean)/social.train.promo.count.lt.sd,
                                               cons_month_lt=(cons_month_lt-social.train.cons.month.lt.mean)/social.train.cons.month.lt.sd)

social.test.scaled <- social.test %>% mutate(client_state_rank=(client_state_rank-social.train.client.state.rank.mean)/social.train.client.state.rank.sd,
                                             client_zip_rank=(client_zip_rank-social.train.client.zip.rank.mean)/social.train.client.zip.rank.sd,
                                             gift_min_t12m=(gift_min_t12m-social.train.gift.min.t12m.mean)/social.train.gift.min.t12m.sd,
                                             gift_max_t12m=(gift_max_t12m-social.train.gift.max.t12m.mean)/social.train.gift.max.t12m.sd,
                                             gift_avg_t12m=(gift_avg_t12m-social.train.gift.avg.t12m.mean)/social.train.gift.avg.t12m.sd,
                                             gift_count_t12m=(gift_count_t12m-social.train.gift.count.t12m.mean)/social.train.gift.count.t12m.sd,
                                             promo_count_t12m=(promo_count_t12m-social.train.promo.count.t12m.mean)/social.train.promo.count.t12m.sd,
                                             cons_month_t12m=(cons_month_t12m-social.train.cons.month.t12m.mean)/social.train.cons.month.t12m.sd,
                                             gift_min_lt=(gift_min_lt-social.train.gift.min.lt.mean)/social.train.gift.min.lt.sd,
                                             gift_max_lt=(gift_max_lt-social.train.gift.max.lt.mean)/social.train.gift.max.lt.sd,
                                             gift_avg_lt=(gift_avg_lt-social.train.gift.avg.lt.mean)/social.train.gift.avg.lt.sd,
                                             gift_count_lt=(gift_count_lt-social.train.gift.count.lt.mean)/social.train.gift.count.lt.sd,
                                             promo_count_lt=(promo_count_lt-social.train.promo.count.lt.mean)/social.train.promo.count.lt.sd,
                                             cons_month_lt=(cons_month_lt-social.train.cons.month.lt.mean)/social.train.cons.month.lt.sd)

veteran.train.client.state.rank.mean <- mean(veteran.train$client_state_rank)
veteran.train.client.state.rank.sd <- sd(veteran.train$client_state_rank)
veteran.train.age.mean <- mean(veteran.train$age)
veteran.train.age.sd <- sd(veteran.train$age)
veteran.train.client.zip.rank.mean <- mean(veteran.train$client_zip_rank)
veteran.train.client.zip.rank.sd <- sd(veteran.train$client_zip_rank)
veteran.train.gift.min.t12m.mean <- mean(veteran.train$gift_min_t12m)
veteran.train.gift.min.t12m.sd <- sd(veteran.train$gift_min_t12m)
veteran.train.gift.max.t12m.mean <- mean(veteran.train$gift_max_t12m)
veteran.train.gift.max.t12m.sd <- sd(veteran.train$gift_max_t12m)
veteran.train.gift.avg.t12m.mean <- mean(veteran.train$gift_avg_t12m)
veteran.train.gift.avg.t12m.sd <- sd(veteran.train$gift_avg_t12m)
veteran.train.gift.count.t12m.mean <- mean(veteran.train$gift_count_t12m)
veteran.train.gift.count.t12m.sd <- sd(veteran.train$gift_count_t12m)
veteran.train.promo.count.t12m.mean <- mean(veteran.train$promo_count_t12m)
veteran.train.promo.count.t12m.sd <- sd(veteran.train$promo_count_t12m)
veteran.train.cons.month.t12m.mean <- mean(veteran.train$cons_month_t12m)
veteran.train.cons.month.t12m.sd <- sd(veteran.train$cons_month_t12m)
veteran.train.gift.min.lt.mean <- mean(veteran.train$gift_min_lt)
veteran.train.gift.min.lt.sd <- sd(veteran.train$gift_min_lt)
veteran.train.gift.max.lt.mean <- mean(veteran.train$gift_max_lt)
veteran.train.gift.max.lt.sd <- sd(veteran.train$gift_max_lt)
veteran.train.gift.avg.lt.mean <- mean(veteran.train$gift_avg_lt)
veteran.train.gift.avg.lt.sd <- sd(veteran.train$gift_avg_lt)
veteran.train.gift.count.lt.mean <- mean(veteran.train$gift_count_lt)
veteran.train.gift.count.lt.sd <- sd(veteran.train$gift_count_lt)
veteran.train.promo.count.lt.mean <- mean(veteran.train$promo_count_lt)
veteran.train.promo.count.lt.sd <- sd(veteran.train$promo_count_lt)
veteran.train.cons.month.lt.mean <- mean(veteran.train$cons_month_lt)
veteran.train.cons.month.lt.sd <- sd(veteran.train$cons_month_lt)

veteran.train.scaled <- veteran.train %>% mutate(client_state_rank=(client_state_rank-veteran.train.client.state.rank.mean)/veteran.train.client.state.rank.sd,
                                                 client_zip_rank=(client_zip_rank-veteran.train.client.zip.rank.mean)/veteran.train.client.zip.rank.sd,
                                                 age=(age-veteran.train.age.mean)/veteran.train.age.sd,
                                                 gift_min_t12m=(gift_min_t12m-veteran.train.gift.min.t12m.mean)/veteran.train.gift.min.t12m.sd,
                                                 gift_max_t12m=(gift_max_t12m-veteran.train.gift.max.t12m.mean)/veteran.train.gift.max.t12m.sd,
                                                 gift_avg_t12m=(gift_avg_t12m-veteran.train.gift.avg.t12m.mean)/veteran.train.gift.avg.t12m.sd,
                                                 gift_count_t12m=(gift_count_t12m-veteran.train.gift.count.t12m.mean)/veteran.train.gift.count.t12m.sd,
                                                 promo_count_t12m=(promo_count_t12m-veteran.train.promo.count.t12m.mean)/veteran.train.promo.count.t12m.sd,
                                                 cons_month_t12m=(cons_month_t12m-veteran.train.cons.month.t12m.mean)/veteran.train.cons.month.t12m.sd,
                                                 gift_min_lt=(gift_min_lt-veteran.train.gift.min.lt.mean)/veteran.train.gift.min.lt.sd,
                                                 gift_max_lt=(gift_max_lt-veteran.train.gift.max.lt.mean)/veteran.train.gift.max.lt.sd,
                                                 gift_avg_lt=(gift_avg_lt-veteran.train.gift.avg.lt.mean)/veteran.train.gift.avg.lt.sd,
                                                 gift_count_lt=(gift_count_lt-veteran.train.gift.count.lt.mean)/veteran.train.gift.count.lt.sd,
                                                 promo_count_lt=(promo_count_lt-veteran.train.promo.count.lt.mean)/veteran.train.promo.count.lt.sd,
                                                 cons_month_lt=(cons_month_lt-veteran.train.cons.month.lt.mean)/veteran.train.cons.month.lt.sd)

veteran.test.scaled <- veteran.test %>% mutate(client_state_rank=(client_state_rank-veteran.train.client.state.rank.mean)/veteran.train.client.state.rank.sd,
                                               client_zip_rank=(client_zip_rank-veteran.train.client.zip.rank.mean)/veteran.train.client.zip.rank.sd,
                                               age=(age-veteran.train.age.mean)/veteran.train.age.sd,
                                               gift_min_t12m=(gift_min_t12m-veteran.train.gift.min.t12m.mean)/veteran.train.gift.min.t12m.sd,
                                               gift_max_t12m=(gift_max_t12m-veteran.train.gift.max.t12m.mean)/veteran.train.gift.max.t12m.sd,
                                               gift_avg_t12m=(gift_avg_t12m-veteran.train.gift.avg.t12m.mean)/veteran.train.gift.avg.t12m.sd,
                                               gift_count_t12m=(gift_count_t12m-veteran.train.gift.count.t12m.mean)/veteran.train.gift.count.t12m.sd,
                                               promo_count_t12m=(promo_count_t12m-veteran.train.promo.count.t12m.mean)/veteran.train.promo.count.t12m.sd,
                                               cons_month_t12m=(cons_month_t12m-veteran.train.cons.month.t12m.mean)/veteran.train.cons.month.t12m.sd,
                                               gift_min_lt=(gift_min_lt-veteran.train.gift.min.lt.mean)/veteran.train.gift.min.lt.sd,
                                               gift_max_lt=(gift_max_lt-veteran.train.gift.max.lt.mean)/veteran.train.gift.max.lt.sd,
                                               gift_avg_lt=(gift_avg_lt-veteran.train.gift.avg.lt.mean)/veteran.train.gift.avg.lt.sd,
                                               gift_count_lt=(gift_count_lt-veteran.train.gift.count.lt.mean)/veteran.train.gift.count.lt.sd,
                                               promo_count_lt=(promo_count_lt-veteran.train.promo.count.lt.mean)/veteran.train.promo.count.lt.sd,
                                               cons_month_lt=(cons_month_lt-veteran.train.cons.month.lt.mean)/veteran.train.cons.month.lt.sd)

generic.train.client.state.rank.mean <- mean(generic.train$client_state_rank)
generic.train.client.state.rank.sd <- sd(generic.train$client_state_rank)
generic.train.all.state.rank.mean <- mean(generic.train$all_state_rank)
generic.train.all.state.rank.sd <- sd(generic.train$all_state_rank)
generic.train.client.zip.rank.mean <- mean(generic.train$client_zip_rank)
generic.train.client.zip.rank.sd <- sd(generic.train$client_zip_rank)
generic.train.all.zip.rank.mean <- mean(generic.train$all_zip_rank)
generic.train.all.zip.rank.sd <- sd(generic.train$all_zip_rank)
generic.train.age.mean <- mean(generic.train$age)
generic.train.age.sd <- sd(generic.train$age)
generic.train.gift.min.t12m.mean <- mean(generic.train$gift_min_t12m)
generic.train.gift.min.t12m.sd <- sd(generic.train$gift_min_t12m)
generic.train.gift.max.t12m.mean <- mean(generic.train$gift_max_t12m)
generic.train.gift.max.t12m.sd <- sd(generic.train$gift_max_t12m)
generic.train.gift.avg.t12m.mean <- mean(generic.train$gift_avg_t12m)
generic.train.gift.avg.t12m.sd <- sd(generic.train$gift_avg_t12m)
generic.train.gift.count.t12m.mean <- mean(generic.train$gift_count_t12m)
generic.train.gift.count.t12m.sd <- sd(generic.train$gift_count_t12m)
generic.train.promo.count.t12m.mean <- mean(generic.train$promo_count_t12m)
generic.train.promo.count.t12m.sd <- sd(generic.train$promo_count_t12m)
generic.train.cons.month.t12m.mean <- mean(generic.train$cons_month_t12m)
generic.train.cons.month.t12m.sd <- sd(generic.train$cons_month_t12m)
generic.train.gift.min.lt.mean <- mean(generic.train$gift_min_lt)
generic.train.gift.min.lt.sd <- sd(generic.train$gift_min_lt)
generic.train.gift.max.lt.mean <- mean(generic.train$gift_max_lt)
generic.train.gift.max.lt.sd <- sd(generic.train$gift_max_lt)
generic.train.gift.avg.lt.mean <- mean(generic.train$gift_avg_lt)
generic.train.gift.avg.lt.sd <- sd(generic.train$gift_avg_lt)
generic.train.gift.count.lt.mean <- mean(generic.train$gift_count_lt)
generic.train.gift.count.lt.sd <- sd(generic.train$gift_count_lt)
generic.train.promo.count.lt.mean <- mean(generic.train$promo_count_lt)
generic.train.promo.count.lt.sd <- sd(generic.train$promo_count_lt)
generic.train.cons.month.lt.mean <- mean(generic.train$cons_month_lt)
generic.train.cons.month.lt.sd <- sd(generic.train$cons_month_lt)

generic.train.scaled <- generic.train %>% mutate(client_state_rank=(client_state_rank-generic.train.client.state.rank.mean)/generic.train.client.state.rank.sd,
                                                 all_state_rank=(all_state_rank-generic.train.all.state.rank.mean)/generic.train.all.state.rank.sd,
                                                 client_zip_rank=(client_zip_rank-generic.train.client.zip.rank.mean)/generic.train.client.zip.rank.sd,
                                                 all_zip_rank=(all_zip_rank-generic.train.all.zip.rank.mean)/generic.train.all.zip.rank.sd,
                                                 age=(age-generic.train.age.mean)/generic.train.age.sd,
                                                 gift_min_t12m=(gift_min_t12m-generic.train.gift.min.t12m.mean)/generic.train.gift.min.t12m.sd,
                                                 gift_max_t12m=(gift_max_t12m-generic.train.gift.max.t12m.mean)/generic.train.gift.max.t12m.sd,
                                                 gift_avg_t12m=(gift_avg_t12m-generic.train.gift.avg.t12m.mean)/generic.train.gift.avg.t12m.sd,
                                                 gift_count_t12m=(gift_count_t12m-generic.train.gift.count.t12m.mean)/generic.train.gift.count.t12m.sd,
                                                 promo_count_t12m=(promo_count_t12m-generic.train.promo.count.t12m.mean)/generic.train.promo.count.t12m.sd,
                                                 cons_month_t12m=(cons_month_t12m-generic.train.cons.month.t12m.mean)/generic.train.cons.month.t12m.sd,
                                                 gift_min_lt=(gift_min_lt-generic.train.gift.min.lt.mean)/generic.train.gift.min.lt.sd,
                                                 gift_max_lt=(gift_max_lt-generic.train.gift.max.lt.mean)/generic.train.gift.max.lt.sd,
                                                 gift_avg_lt=(gift_avg_lt-generic.train.gift.avg.lt.mean)/generic.train.gift.avg.lt.sd,
                                                 gift_count_lt=(gift_count_lt-generic.train.gift.count.lt.mean)/generic.train.gift.count.lt.sd,
                                                 promo_count_lt=(promo_count_lt-generic.train.promo.count.lt.mean)/generic.train.promo.count.lt.sd,
                                                 cons_month_lt=(cons_month_lt-generic.train.cons.month.lt.mean)/generic.train.cons.month.lt.sd)

generic.test.scaled <- generic.test %>% mutate(client_state_rank=(client_state_rank-generic.train.client.state.rank.mean)/generic.train.client.state.rank.sd,
                                               all_state_rank=(all_state_rank-generic.train.all.state.rank.mean)/generic.train.all.state.rank.sd,
                                               client_zip_rank=(client_zip_rank-generic.train.client.zip.rank.mean)/generic.train.client.zip.rank.sd,
                                               all_zip_rank=(all_zip_rank-generic.train.all.zip.rank.mean)/generic.train.all.zip.rank.sd,
                                               age=(age-generic.train.age.mean)/generic.train.age.sd,
                                               gift_min_t12m=(gift_min_t12m-generic.train.gift.min.t12m.mean)/generic.train.gift.min.t12m.sd,
                                               gift_max_t12m=(gift_max_t12m-generic.train.gift.max.t12m.mean)/generic.train.gift.max.t12m.sd,
                                               gift_avg_t12m=(gift_avg_t12m-generic.train.gift.avg.t12m.mean)/generic.train.gift.avg.t12m.sd,
                                               gift_count_t12m=(gift_count_t12m-generic.train.gift.count.t12m.mean)/generic.train.gift.count.t12m.sd,
                                               promo_count_t12m=(promo_count_t12m-generic.train.promo.count.t12m.mean)/generic.train.promo.count.t12m.sd,
                                               cons_month_t12m=(cons_month_t12m-generic.train.cons.month.t12m.mean)/generic.train.cons.month.t12m.sd,
                                               gift_min_lt=(gift_min_lt-generic.train.gift.min.lt.mean)/generic.train.gift.min.lt.sd,
                                               gift_max_lt=(gift_max_lt-generic.train.gift.max.lt.mean)/generic.train.gift.max.lt.sd,
                                               gift_avg_lt=(gift_avg_lt-generic.train.gift.avg.lt.mean)/generic.train.gift.avg.lt.sd,
                                               gift_count_lt=(gift_count_lt-generic.train.gift.count.lt.mean)/generic.train.gift.count.lt.sd,
                                               promo_count_lt=(promo_count_lt-generic.train.promo.count.lt.mean)/generic.train.promo.count.lt.sd,
                                               cons_month_lt=(cons_month_lt-generic.train.cons.month.lt.mean)/generic.train.cons.month.lt.sd)

# export
write.csv(advcy.train.scaled,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/advcy_train_wo_outliers_w_scaling.csv',row.names=F)
write.csv(advcy.test.scaled,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/advcy_test_wo_outliers_w_scaling.csv',row.names=F)
write.csv(envr.train.scaled,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/envr_train_wo_outliers_w_scaling.csv',row.names=F)
write.csv(envr.test.scaled,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/envr_test_wo_outliers_w_scaling.csv',row.names=F)
write.csv(health2.train.scaled,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/health2_train_wo_outliers_w_scaling.csv',row.names=F)
write.csv(health2.test.scaled,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/health2_test_wo_outliers_w_scaling.csv',row.names=F)
write.csv(health.train.scaled,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/health_train_wo_outliers_w_scaling.csv',row.names=F)
write.csv(health.test.scaled,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/health_test_wo_outliers_w_scaling.csv',row.names=F)
write.csv(social.train.scaled,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/social_train_wo_outliers_w_scaling.csv',row.names=F)
write.csv(social.test.scaled,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/social_test_wo_outliers_w_scaling.csv',row.names=F)
write.csv(veteran.train.scaled,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/veteran_train_wo_outliers_w_scaling.csv',row.names=F)
write.csv(veteran.test.scaled,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/veteran_test_wo_outliers_w_scaling.csv',row.names=F)
write.csv(generic.train.scaled,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/generic_train_wo_outliers_w_scaling.csv',row.names=F)
write.csv(generic.test.scaled,'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/final_data_wo_outliers_w_scaling/generic_test_wo_outliers_w_scaling.csv',row.names=F)