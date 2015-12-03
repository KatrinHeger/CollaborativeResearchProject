###########################
# Inferential Statistics  #
###########################

#####################################
# !!! Check with Christopher !!!    #
#####################################

## Regression Preparation 
# Create dataframe of independent variables
DF_Independent <- data.frame(as.numeric(Dataset_1$gtypesup_cat), as.numeric(Dataset_1$rtypesup_cat), as.numeric(Dataset_1$gov.supXfight.cap), as.numeric(Dataset_1$lngdp), as.numeric(Dataset_1$coup), as.numeric(Dataset_1$secessionist), as.numeric(Dataset_1$lnyears), as.numeric(Dataset_1$postCW), as.numeric(Dataset_1$rebpolwinglegal))

# Check for multicollinearity with correlation matrix of independent variables
COR <- cor(DF_Independent)

# Check for multicollinearity using the "Variance Inflation Factor (VIF)"
VIF <- vif(Dataset_1$gtypesup_cat, Dataset_1$rtypesup_cat, Dataset_1$gov.supXfight.cap, Dataset_1$lngdp, Dataset_1$coup, Dataset_1$secessionist, Dataset_1$lnyears, Dataset_1$postCW, Dataset_1$rebpolwinglegal)

# Test for endogeneity with a Hausman test
# 

# Test for heteroscedasticity
# plot(XXXXX, which = 1)

# Test for non-normality of errors
# plot(XXX, which = 2)

####################
# Logit Regression #        Plot logit regressions with "car::scatterplotMatrix(XXX)" 
####################

# What kind of support is most likely to lead to an intended outcome?
# How high is the probability of the desired outcome, given a specific kind of intervention?

####################################
# Regression on government victory #
####################################

# Recode "gov.vic.dummy" into factor
Dataset_1$gov.vic.dummy <- as.factor(Dataset_1$gov.vic.dummy)

# Logit Regression on government victory (1)
reg1.1_gov.vic<-glm(Dataset_1$gov.vic.dummy ~ Dataset_1$gtypesup_cat, data=Dataset_1, family = binomial)
stargazer(reg1.1_gov.vic, type = "text", digits = 2)

# Logit Regression on government victory (2)
reg1.2_gov.vic<-glm(Dataset_1$gov.vic.dummy ~ Dataset_1$gtypesup_cat + Dataset_1$mi_fightcap, data=Dataset_1, family = binomial)
stargazer(reg1.2_gov.vic, type = "text", digits = 2)

# Logit Regression on government victory (3)
reg1.3_gov.vic<-glm(Dataset_1$gov.vic.dummy ~ Dataset_1$gtypesup_cat + Dataset_1$mi_fightcap + Dataset_1$lngdp, data=Dataset_1, family = binomial)
stargazer(reg1.3_gov.vic, type = "text", digits = 2)

# Logit Regression on government victory (4)
reg1.4_gov.vic<-glm(Dataset_1$gov.vic.dummy ~ Dataset_1$gtypesup_cat + Dataset_1$mi_fightcap + Dataset_1$lngdp + Dataset_1$coup, data=Dataset_1, family = binomial)
stargazer(reg1.4_gov.vic, type = "text", digits = 2)

# Logit Regression on government victory (5)
reg1.5_gov.vic<-glm(Dataset_1$gov.vic.dummy ~ Dataset_1$gtypesup_cat + Dataset_1$mi_fightcap + Dataset_1$lngdp + Dataset_1$coup + Dataset_1$lnyears, data=Dataset_1, family = binomial)
stargazer(reg1.5_gov.vic, type = "text", digits = 2)

# Logit Regression on government victory (6)
reg1.6_gov.vic<-glm(Dataset_1$gov.vic.dummy ~ Dataset_1$gtypesup_cat + Dataset_1$mi_fightcap + Dataset_1$lngdp + Dataset_1$coup + Dataset_1$lnyears + Dataset_1$rebpolwinglegal, data=Dataset_1, family = binomial)
stargazer(reg1.6_gov.vic, type = "text", digits = 2)

# Logit Regression on government victory (7)
reg1.7_gov.vic<-glm(Dataset_1$gov.vic.dummy ~ Dataset_1$gtypesup_cat + Dataset_1$mi_fightcap + Dataset_1$lngdp + Dataset_1$coup + Dataset_1$lnyears + Dataset_1$rebpolwinglegal + Dataset_1$secessionist, data=Dataset_1, family = binomial)
stargazer(reg1.7_gov.vic, type = "text", digits = 2)

# Confidence Intervals
confint(reg1.7_gov.vic)


###############################
# Regression on rebel victory #
###############################

# Recode "reb.vic.dummy" into factor
Dataset_1$reb.vic.dummy <- as.factor(Dataset_1$reb.vic.dummy)

# Logit Regression on rebel victory (1)
reg2.1_reb.vic <- glm(Dataset_1$reb.vic.dummy ~ Dataset_1$rtypesup_cat, family = binomial)
stargazer(reg2.1_reb.vic, type = "text", digits = 2)

# Logit Regression on rebel victory (2)
reg2.2_reb.vic <- glm(Dataset_1$reb.vic.dummy ~ Dataset_1$rtypesup_cat + Dataset_1$fightcaphigh, family = binomial)
stargazer(reg2.2_reb.vic, type = "text", digits = 2)

# Logit Regression on rebel victory (3)
reg2.3_reb.vic <- glm(Dataset_1$reb.vic.dummy ~ Dataset_1$rtypesup_cat + Dataset_1$fightcaphigh + Dataset_1$lngdp, family = binomial)
stargazer(reg2.3_reb.vic, type = "text", digits = 2)

# Logit Regression on rebel victory (4)
reg2.4_reb.vic <- glm(Dataset_1$reb.vic.dummy ~ Dataset_1$rtypesup_cat + Dataset_1$fightcaphigh + Dataset_1$lngdp + Dataset_1$coup, family = binomial)
stargazer(reg2.4_reb.vic, type = "text", digits = 2)

# Logit Regression on rebel victory (5)
reg2.5_reb.vic <- glm(Dataset_1$reb.vic.dummy ~ Dataset_1$rtypesup_cat + Dataset_1$fightcaphigh + Dataset_1$lngdp + Dataset_1$coup + Dataset_1$lnyears, family = binomial)
stargazer(reg2.5_reb.vic, type = "text", digits = 2)

# Logit Regression on rebel victory (6)
reg2.6_reb.vic <- glm(Dataset_1$reb.vic.dummy ~ Dataset_1$rtypesup_cat + Dataset_1$fightcaphigh + Dataset_1$lngdp + Dataset_1$coup + Dataset_1$lnyears + Dataset_1$rebpolwinglegal, family = binomial)
stargazer(reg2.6_reb.vic, type = "text", digits = 2)

# Logit Regression on rebel victory (7)
reg2.7_reb.vic <- glm(Dataset_1$reb.vic.dummy ~ Dataset_1$rtypesup_cat + Dataset_1$fightcaphigh + Dataset_1$lngdp + Dataset_1$coup + Dataset_1$lnyears + Dataset_1$rebpolwinglegal + Dataset_1$secessionist, family = binomial)
stargazer(reg2.7_reb.vic, type = "text", digits = 2)

# Confidence Intervals
confint(reg2.7_reb.vic)

#######################################
# Regression on negotiated settlement #
#######################################

# Recode "settle.dummy" into factor
Dataset_1$settle.dummy <- as.factor(Dataset_1$settle.dummy)

# Logit Regression on negotiated settlement (1)
reg3.1_settle <- glm(Dataset_1$settle.dummy ~ Dataset_1$rtypesup_cat + Dataset_1$gtypesup_cat, family = binomial)
stargazer(reg3.1_settle, type = "text", digits = 2)

# Logit Regression on negotiated settlement (2)
reg3.2_settle <- glm(Dataset_1$settle.dummy ~ Dataset_1$rtypesup_cat + Dataset_1$gtypesup_cat + Dataset_1$mi_fightcap, family = binomial)
stargazer(reg3.2_settle, type = "text", digits = 2)

# Logit Regression on negotiated settlement (3)
reg3.3_settle <- glm(Dataset_1$settle.dummy ~ Dataset_1$rtypesup_cat + Dataset_1$gtypesup_cat + Dataset_1$mi_fightcap + Dataset_1$lngdp, family = binomial)
stargazer(reg3.3_settle, type = "text", digits = 2)

# Logit Regression on negotiated settlement (4)
reg3.4_settle <- glm(Dataset_1$settle.dummy ~ Dataset_1$rtypesup_cat + Dataset_1$gtypesup_cat + Dataset_1$mi_fightcap + Dataset_1$lngdp + Dataset_1$coup + Dataset_1$lnyears + Dataset_1$rebpolwinglegal + Dataset_1$secessionist, family = binomial)
stargazer(reg3.4_settle, type = "text", digits = 2)

# Confidence Intervals
confint(reg3.4_settle)

#######################################
# Regression on low activity #
#######################################

# Recode "low.act.dummy" into factor
Dataset_1$low.act.dummy <- as.factor(Dataset_1$low.act.dummy)

# Logit Regression on low activity (1)
reg4.1_low.act <- glm(Dataset_1$low.act.dummy ~ Dataset_1$rtypesup_cat + Dataset_1$gtypesup_cat, family = binomial)
stargazer(reg4.1_low.act, type = "text", digits = 2)

# Logit Regression on low activity (2)
reg4.2_low.act <- glm(Dataset_1$low.act.dummy ~ Dataset_1$rtypesup_cat + Dataset_1$gtypesup_cat + Dataset_1$mi_fightcap, family = binomial)
stargazer(reg4.2_low.act, type = "text", digits = 2)

# Logit Regression on low activity (3)
reg4.3_low.act <- glm(Dataset_1$low.act.dummy ~ Dataset_1$rtypesup_cat + Dataset_1$gtypesup_cat + Dataset_1$mi_fightcap + Dataset_1$lngdp, family = binomial)
stargazer(reg4.3_low.act, type = "text", digits = 2)

# Logit Regression on low activity (4)
reg4.4_low.act <- glm(Dataset_1$low.act.dummy ~ Dataset_1$rtypesup_cat + Dataset_1$gtypesup_cat + Dataset_1$mi_fightcap + Dataset_1$lngdp + Dataset_1$coup + Dataset_1$lnyears + Dataset_1$rebpolwinglegal + Dataset_1$secessionist, family = binomial)
stargazer(reg4.4_low.act, type = "text", digits = 2)

# Confidence Intervals
confint(reg4.4_low.act)



################################
# Multinomial Logit Regression #
################################

#####################################
# !!! Add missing Hausman Tests !!! #
#####################################

# Hausman-McFadden Test for testing independence of irrelevant alternatives
hmftest(x, )

# Multinomial Logit Regression - Model 1
dat.1 <- Dataset_1[is.na(Dataset_1$conflict_outcome) == FALSE & is.na(Dataset_1$gtypesup_cat) == FALSE & is.na(Dataset_1$rtypesup_cat) == FALSE, ]
mlogit1 <- multinom(Dataset_1$conflict_outcome ~ Dataset_1$gtypesup_cat + Dataset_1$rtypesup_cat -1, data = dat.1)
stargazer(mlogit1, type = "text", digits = 2, dep.var.labels = rep(c('Rebel', 'Nego.', 'Gov.'), 3))

# Multinomial Logit Regression - Model 2
dat.2 <- Dataset_1[is.na(Dataset_1$conflict_outcome) == FALSE & is.na(Dataset_1$gtypesup_cat) == FALSE & is.na(Dataset_1$rtypesup_cat) == FALSE & is.na(Dataset_1$mi_fightcap) == FALSE & is.na(Dataset_1$lngdp) == FALSE, ]
mlogit2 <- multinom(Dataset_1$conflict_outcome ~ Dataset_1$gtypesup_cat + Dataset_1$rtypesup_cat + Dataset_1$mi_fightcap + Dataset_1$lngdp -1, data = dat.2)
stargazer(mlogit2, type = "text", digits = 2, dep.var.labels = rep(c('Rebel', 'Nego.', 'Gov.'), 3))

# Multinomial Logit Regression - Model 3
dat.3 <- Dataset_1[is.na(Dataset_1$conflict_outcome) == FALSE & is.na(Dataset_1$gtypesup_cat) == FALSE & is.na(Dataset_1$rtypesup_cat) == FALSE & is.na(Dataset_1$mi_fightcap) == FALSE & is.na(Dataset_1$lngdp) == FALSE & is.na(Dataset_1$coup) == FALSE & is.na(Dataset_1$lnyears) == FALSE & is.na(Dataset_1$rebpolwinglegal) == FALSE & is.na(Dataset_1$secessionist) == FALSE, ]
mlogit3 <- multinom(Dataset_1$conflict_outcome ~ Dataset_1$gtypesup_cat + Dataset_1$rtypesup_cat + Dataset_1$mi_fightcap + Dataset_1$lngdp + Dataset_1$coup + Dataset_1$lnyears + Dataset_1$rebpolwinglegal + Dataset_1$secessionist -1, data = dat.3)
stargazer(mlogit3, type = "text", digits = 2, dep.var.labels = rep(c('Rebel', 'Nego.', 'Gov.'), 3))

# Confidence Intervals
confint(mlogit3)

# Transform into fitted values
predicted.mlogit1 <- predict(mlogit1)
table(predicted.mlogit1)
stargazer(predicted.mlogit1, type = "text", digits = 2, dep.var.labels = rep(c('Rebel', 'Nego.', 'Gov.'), 3))

predicted.mlogit2 <- predict(mlogit2)
stargazer(predicted.mlogit2, type = "text", digits = 2, dep.var.labels = rep(c('Rebel', 'Nego.', 'Gov.'), 3))

predicted.mlogit3 <- predict(mlogit3)
stargazer(mlogit3, type = "text", digits = 2, dep.var.labels = rep(c('Rebel', 'Nego.', 'Gov.'), 3))
