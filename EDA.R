library(dplyr)
library(car)
library(ggplot2)
library(reshape2)

advcy.file = 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/advcy_data_final.csv'
envr.file = 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/envr_data_final.csv'
health2.file = 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/health2_data_final.csv'
health.file = 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/health_data_final.csv'
social.file = 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/social_data_final.csv'
veteran.file = 'D:/Calvin/Documents/GTOMSA/Applied Analytics Practicum - CSE 6748/final_data/veteran_data_final.csv'

advcy.data <- read.csv(advcy.file,header=T)[,-c(4,6,7,8,9,22)]
envr.data <- read.csv(envr.file,header=T)[,-c(4,6,8,9,21,22,23)] %>% mutate(age=ifelse(is.na(age),-1,age))
health2.data <- read.csv(health2.file,header=T)[,-c(4,6,8,9,20,22,24,25)] %>% mutate(age=ifelse(is.na(age),-1,age))
health.data <- read.csv(health.file,header=T)[,-c(4,6,7,8,9,17,21,22,24,25)]
social.data <- read.csv(social.file,header=T)[,-c(4,6,7,8,9,24,25)]
veteran.data <- read.csv(veteran.file,header=T)[,-c(4,6,8,9,17,20,21,24,25)] %>% mutate(age=ifelse(is.na(age),-1,age))
all.data <- rbind(read.csv(advcy.file,header=T),read.csv(envr.file,header=T),read.csv(health2.file,header=T),
                  read.csv(health.file,header=T),read.csv(social.file,header=T),read.csv(veteran.file,header=T))[,-c(8,9)] %>% mutate(age=ifelse(is.na(age),-1,age))

# for after the model is created, make sure to check for multicollinearity (VIF), linearity of the logit, and independence of errors

#advcy.data
# drtv_t12m removed because they were all FALSE. No added info
# for client specific, remove the all_state and all_zip rank data
# gift count, promo count, and cons month (both t12m and lt) have very strong correlations with eachother. unsure if they are multicollinearity issue
# gift min, max and avg ahve pretty high correlations with eachother
# many of the predictors have a very weak to no correlation with the response
# the only few predictors that do have some correlation (around 0.2) with the response are const_month_lt, promo_count_lt, gift_count_lt, digital_t12m, 
# cons_month_t12m, promo_count_t12m, gift_count_t12m

ggplot(data=melt(round(cor(advcy.data),2)),aes(x=Var1,y=Var2,fill=value)) + geom_tile() + geom_text(aes(Var2, Var1,label=value),color='white',size=4)
boxplot(advcy.data$gender~advcy.data$sustainer) # non-sutainrs are the only ones with the weird 2 and 3 gender denomination
boxplot(advcy.data$client_state_rank~advcy.data$sustainer)
boxplot(advcy.data$client_zip_rank~advcy.data$sustainer)
boxplot(advcy.data$gift_min_t12m~advcy.data$sustainer)
boxplot(advcy.data$gift_max_t12m~advcy.data$sustainer)
boxplot(advcy.data$gift_avg_t12m~advcy.data$sustainer)
boxplot(advcy.data$gift_count_t12m~advcy.data$sustainer) # sustainers have a higher than usual amount of donations comparatively as well as a larger range
boxplot(advcy.data$cons_month_t12m~advcy.data$sustainer) # susatiners ahve more cons month
boxplot(advcy.data$promo_count_t12m~advcy.data$sustainer) # sustainers have more promo
boxplot(advcy.data$dm_t12m~advcy.data$sustainer) # weirdly all non-sustainers usually donate to dm but susatiners are mixed
boxplot(advcy.data$tm_t12m~advcy.data$sustainer)
boxplot(advcy.data$wm_t12m~advcy.data$sustainer)
boxplot(advcy.data$digital_t12m~advcy.data$sustainer) # sustainers are the ones that reply to digital
boxplot(advcy.data$f2f_t12m~advcy.data$sustainer)
boxplot(advcy.data$events_t12m~advcy.data$sustainer)
boxplot(advcy.data$other_t12m~advcy.data$sustainer)
boxplot(advcy.data$no_channel_t12m~advcy.data$sustainer)
boxplot(advcy.data$member_t12m~advcy.data$sustainer)
boxplot(advcy.data$gift_min_lt~advcy.data$sustainer)
boxplot(advcy.data$gift_max_lt~advcy.data$sustainer)
boxplot(advcy.data$gift_avg_lt~advcy.data$sustainer)
boxplot(advcy.data$gift_count_lt~advcy.data$sustainer) # sustainres have slightly higher gift count
boxplot(advcy.data$promo_count_lt~advcy.data$sustainer) # sustainers have slightly higher promo count
boxplot(advcy.data$cons_month_lt~advcy.data$sustainer) # sustainers have slgihtly higher cons month

#envr.data
# 15% of age data missing, consider just saying age is -1 to mark it as did not give age?
# remove other_t12m, drtv_t12m, and events_t12m because all are 0 response
# gift varaibles (t12m with eachother and lt with eachother) as well as the cons and promo are all pretty correlation with eachother
# most predictors have a pretty low correlation with the response

ggplot(data=melt(round(cor(envr.data),2)),aes(x=Var1,y=Var2,fill=value)) + geom_tile() + geom_text(aes(Var2, Var1,label=value),color='white',size=4)
boxplot(envr.data$gender~envr.data$sustainer)
boxplot(envr.data$client_state_rank~envr.data$sustainer)
boxplot(envr.data$client_zip_rank~envr.data$sustainer)
boxplot(envr.data$age~envr.data$sustainer)
boxplot(envr.data$gift_min_t12m~envr.data$sustainer)
boxplot(envr.data$gift_max_t12m~envr.data$sustainer)
boxplot(envr.data$gift_avg_t12m~envr.data$sustainer)
boxplot(envr.data$gift_count_t12m~envr.data$sustainer)
boxplot(envr.data$cons_month_t12m~envr.data$sustainer) # slightly higher cons month count on average for susatainers than non-sustainers
boxplot(envr.data$promo_count_t12m~envr.data$sustainer) # suatiners have a slightly more higher average promo count
boxplot(envr.data$dm_t12m~envr.data$sustainer)
boxplot(envr.data$tm_t12m~envr.data$sustainer)
boxplot(envr.data$wm_t12m~envr.data$sustainer)
boxplot(envr.data$digital_t12m~envr.data$sustainer) # sustainers are the only ones that really respnded to digital promotions
boxplot(envr.data$f2f_t12m~envr.data$sustainer)
boxplot(envr.data$no_channel_t12m~envr.data$sustainer)
boxplot(envr.data$member_t12m~envr.data$sustainer)
boxplot(envr.data$gift_min_lt~envr.data$sustainer)
boxplot(envr.data$gift_max_lt~envr.data$sustainer)
boxplot(envr.data$gift_avg_lt~envr.data$sustainer)
boxplot(envr.data$gift_count_lt~envr.data$sustainer)
boxplot(envr.data$promo_count_lt~envr.data$sustainer)
boxplot(envr.data$cons_month_lt~envr.data$sustainer)

#health2.data
# 13% of age missing so data missing people have -1
# removing member_t12m, no_channel_t12m, drtv_t12m, and f2f_t12m because all values are single value (doesnt add anything of use)
# gift count lt has the highest correlation with response at 0.42, almost all other predictors have a decently low correlation

ggplot(data=melt(round(cor(health2.data),2)),aes(x=Var1,y=Var2,fill=value)) + geom_tile() + geom_text(aes(Var2, Var1,label=value),color='white',size=4)
boxplot(health2.data$gender~health2.data$sustainer)
boxplot(health2.data$client_state_rank~health2.data$sustainer)
boxplot(health2.data$client_zip_rank~health2.data$sustainer) # non-sustainers have a 25% quartile much lower than sustainers
boxplot(health2.data$age~health2.data$sustainer) # wider quartile range for non-sustainers than sustainers
boxplot(health2.data$gift_min_t12m~health2.data$sustainer)
boxplot(health2.data$gift_max_t12m~health2.data$sustainer)
boxplot(health2.data$gift_avg_t12m~health2.data$sustainer)
boxplot(health2.data$gift_count_t12m~health2.data$sustainer) # susatiners have higher gift count but also wider quartile range
boxplot(health2.data$cons_month_t12m~health2.data$sustainer) # same as above
boxplot(health2.data$promo_count_t12m~health2.data$sustainer)
boxplot(health2.data$dm_t12m~health2.data$sustainer)
boxplot(health2.data$tm_t12m~health2.data$sustainer)
boxplot(health2.data$wm_t12m~health2.data$sustainer) # mainly susatiners are the ones replying to wm
boxplot(health2.data$digital_t12m~health2.data$sustainer)
boxplot(health2.data$events_t12m~health2.data$sustainer) # sustainers are the ones replying to events
boxplot(health2.data$other_t12m~health2.data$sustainer)
boxplot(health2.data$gift_min_lt~health2.data$sustainer)
boxplot(health2.data$gift_max_lt~health2.data$sustainer)
boxplot(health2.data$gift_avg_lt~health2.data$sustainer)
boxplot(health2.data$gift_count_lt~health2.data$sustainer) # sustainrs have a lot higher average gift count lifetime
boxplot(health2.data$promo_count_lt~health2.data$sustainer) # sustainers have higher avg promo count
boxplot(health2.data$cons_month_lt~health2.data$sustainer) # same as above

#health.data
# age is missing 100%
# tm, events, drtv, no_channel, and member all same value (no good data here) removing
# same high possibility of multicollineaity with the gift, promo, and cons features
# digital has the highest cor with response at 0.55, rest are somewhat weak, to very weak

ggplot(data=melt(round(cor(health.data),2)),aes(x=Var1,y=Var2,fill=value)) + geom_tile() + geom_text(aes(Var2, Var1,label=value),color='white',size=4)
boxplot(health.data$gender~health.data$sustainer)
boxplot(health.data$client_state_rank~health.data$sustainer)
boxplot(health.data$client_zip_rank~health.data$sustainer) # higher zip rank on average for sustainers
boxplot(health.data$gift_min_t12m~health.data$sustainer)
boxplot(health.data$gift_max_t12m~health.data$sustainer)
boxplot(health.data$gift_avg_t12m~health.data$sustainer)
boxplot(health.data$gift_count_t12m~health.data$sustainer) # sutainers have slightly higher gift count
boxplot(health.data$cons_month_t12m~health.data$sustainer)
boxplot(health.data$promo_count_t12m~health.data$sustainer)
boxplot(health.data$dm_t12m~health.data$sustainer)
boxplot(health.data$wm_t12m~health.data$sustainer)
boxplot(health.data$digital_t12m~health.data$sustainer) # only sustainrs are really replying to digital
boxplot(health.data$f2f_t12m~health.data$sustainer)
boxplot(health.data$other_t12m~health.data$sustainer)
boxplot(health.data$gift_min_lt~health.data$sustainer)
boxplot(health.data$gift_max_lt~health.data$sustainer)
boxplot(health.data$gift_avg_lt~health.data$sustainer)
boxplot(health.data$gift_count_lt~health.data$sustainer)
boxplot(health.data$promo_count_lt~health.data$sustainer)
boxplot(health.data$cons_month_lt~health.data$sustainer)

#social.data
# 67.5% of age is missing, safer to just remove this feature
# no_channel and member removed as they all have only 1 value
# same multicollinearity possibility with gift, cons, and promo
# response has a somewhat weak cor with cons, promo, and gift lt

ggplot(data=melt(round(cor(social.data),2)),aes(x=Var1,y=Var2,fill=value)) + geom_tile() + geom_text(aes(Var2, Var1,label=value),color='white',size=4)
boxplot(social.data$gender~social.data$sustainer)
boxplot(social.data$client_state_rank~social.data$sustainer)
boxplot(social.data$client_zip_rank~social.data$sustainer)
boxplot(social.data$gift_min_t12m~social.data$sustainer)
boxplot(social.data$gift_max_t12m~social.data$sustainer)
boxplot(social.data$gift_avg_t12m~social.data$sustainer)
boxplot(social.data$gift_count_t12m~social.data$sustainer)
boxplot(social.data$cons_month_t12m~social.data$sustainer)
boxplot(social.data$promo_count_t12m~social.data$sustainer)
boxplot(social.data$dm_t12m~social.data$sustainer)
boxplot(social.data$tm_t12m~social.data$sustainer)
boxplot(social.data$wm_t12m~social.data$sustainer)
boxplot(social.data$digital_t12m~social.data$sustainer)
boxplot(social.data$f2f_t12m~social.data$sustainer)
boxplot(social.data$events_t12m~social.data$sustainer)
boxplot(social.data$drtv_t12m~social.data$sustainer)
boxplot(social.data$other_t12m~social.data$sustainer)
boxplot(social.data$gift_min_lt~social.data$sustainer)
boxplot(social.data$gift_max_lt~social.data$sustainer)
boxplot(social.data$gift_avg_lt~social.data$sustainer)
boxplot(social.data$gift_count_lt~social.data$sustainer)
boxplot(social.data$promo_count_lt~social.data$sustainer)
boxplot(social.data$cons_month_lt~social.data$sustainer)
# overall, many of the promo flags for social data have very few actual TRUE flags (or most are outside of the 25% and 75% quartile range)

#veteran.data
# almost 12% of age data missing. safe to say -1 can be placed as no age given
# tm, f2f, events, no_channel, and member removed as they are all the same value
# same multicollinearity possibility with gift, cons, and promo
# again the lt gift, cons, and promo have the highest cor with response

ggplot(data=melt(round(cor(veteran.data),2)),aes(x=Var1,y=Var2,fill=value)) + geom_tile() + geom_text(aes(Var2, Var1,label=value),color='white',size=4)
boxplot(veteran.data$gender~veteran.data$sustainer)
boxplot(veteran.data$client_state_rank~veteran.data$sustainer)
boxplot(veteran.data$client_zip_rank~veteran.data$sustainer)
boxplot(veteran.data$age~veteran.data$sustainer)
boxplot(veteran.data$gift_min_t12m~veteran.data$sustainer)
boxplot(veteran.data$gift_max_t12m~veteran.data$sustainer)
boxplot(veteran.data$gift_avg_t12m~veteran.data$sustainer)
boxplot(veteran.data$gift_count_t12m~veteran.data$sustainer) # sustainres have slightly higher count
boxplot(veteran.data$cons_month_t12m~veteran.data$sustainer)
boxplot(veteran.data$promo_count_t12m~veteran.data$sustainer) # sustainers have slightly higher promo count
boxplot(veteran.data$dm_t12m~veteran.data$sustainer) # both sustainres and non usually reply to dm
boxplot(veteran.data$wm_t12m~veteran.data$sustainer) # both sustainers and nonusually don't reply to wm
boxplot(veteran.data$digital_t12m~veteran.data$sustainer) # both sustainers and nonusually don't reply to digital
boxplot(veteran.data$drtv_t12m~veteran.data$sustainer) # both sustainers and nonusually don't reply to drtv
boxplot(veteran.data$other_t12m~veteran.data$sustainer) # both sustainers and nonusually don't reply to other
boxplot(veteran.data$gift_min_lt~veteran.data$sustainer)
boxplot(veteran.data$gift_max_lt~veteran.data$sustainer)
boxplot(veteran.data$gift_avg_lt~veteran.data$sustainer)
boxplot(veteran.data$gift_count_lt~veteran.data$sustainer) # susatiners have slightly higher avg gift count
boxplot(veteran.data$promo_count_lt~veteran.data$sustainer) # sustainers have a slightly higher avg promo count
boxplot(veteran.data$cons_month_lt~veteran.data$sustainer) # sustainers have a slightly higher cons month

#all.data
# missing 45% of age data but might be necessary to keep
# same multicollinearity possibility with gift, cons, and promo
# most features have a low cor with the response (except for cons, promo, and gift cont lt)

ggplot(data=melt(round(cor(all.data),2)),aes(x=Var1,y=Var2,fill=value)) + geom_tile() + geom_text(aes(Var2, Var1,label=value),color='white',size=4)
boxplot(all.data$gender~all.data$sustainer) # only non sutainers have weird gender data
boxplot(all.data$client_state_rank~all.data$sustainer)
boxplot(all.data$all_state_rank~all.data$sustainer)
boxplot(all.data$client_zip_rank~all.data$sustainer)
boxplot(all.data$all_zip_rank~all.data$sustainer)
boxplot(all.data$age~all.data$sustainer) # susatainers may usually be older
boxplot(all.data$gift_min_t12m~all.data$sustainer)
boxplot(all.data$gift_max_t12m~all.data$sustainer)
boxplot(all.data$gift_avg_t12m~all.data$sustainer)
boxplot(all.data$gift_count_t12m~all.data$sustainer)
boxplot(all.data$cons_month_t12m~all.data$sustainer)
boxplot(all.data$promo_count_t12m~all.data$sustainer) # susatiners have an ever so slightly higher than average count
boxplot(all.data$dm_t12m~all.data$sustainer)
boxplot(all.data$tm_t12m~all.data$sustainer) # both sustainers and non usually don't reply to tm
boxplot(all.data$wm_t12m~all.data$sustainer)
boxplot(all.data$digital_t12m~all.data$sustainer) # susatiners are usually the ones the react to digital
boxplot(all.data$f2f_t12m~all.data$sustainer) # both sustainers and non usually don't reply to f2f
boxplot(all.data$events_t12m~all.data$sustainer) # both sustainers and non usually don't reply to events
boxplot(all.data$drtv_t12m~all.data$sustainer) # both sustainers and non usually don't reply to drtv
boxplot(all.data$other_t12m~all.data$sustainer) # both sustainers and non usually don't reply to other
boxplot(all.data$no_channel_t12m~all.data$sustainer) # both sustainers and non usually don't reply to other
boxplot(all.data$member_t12m~all.data$sustainer) # both sustainers and non are usually not members
boxplot(all.data$gift_min_lt~all.data$sustainer)
boxplot(all.data$gift_max_lt~all.data$sustainer)
boxplot(all.data$gift_avg_lt~all.data$sustainer)
boxplot(all.data$gift_count_lt~all.data$sustainer) # susatiners have slightly higher avg count
boxplot(all.data$promo_count_lt~all.data$sustainer) # sustainers have slightly higher avg count
boxplot(all.data$cons_month_lt~all.data$sustainer) # sustainers have slightly higher avg cons
