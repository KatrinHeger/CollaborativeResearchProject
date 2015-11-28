#############################
# Inferential Statistics   ##
#############################

##########################
#### Logit Regression #### 
##########################
# What kind of support is most likely to lead to an intended outcome? How high is the probability of the desired outcome, given a specific kind of intervention?

# Checking for multicollinearity with correlation matrix of independent variables
COR<-cor()

# Checking for multicollinearity using the "Variance Inflation Factor (VIF)"
VIF<- vif(

# Checking for ordinal odds 

  
# Estimate an ordered logistic regression model with polr command from MASS package
# Specify HESS=TRUE to have the model return the observed information matrix from optimization which is used to get standard errors
### Regression on government victory
reg1.1_gov.vic<-polr(gov.vic.dummy ~ , method='logistic', data=dataset_1, Hess = TRUE)
summary(reg1.1)

# Store table
(ctable1 <- coef(summary(reg1_gov.vic)))
  
# Calculate and store p values
p1.1 <- pnorm(abs(ctable1[, "t value"]), lower.tail = FALSE) * 2
  
# Create combined table
(ctable1.1 <- cbind(ctable1, "p value" = p1.1))


reg1.2_gov.vic<-polr(gov.vic.dummy ~  method='logistic', data=dataset_1, Hess = TRUE)
summary(reg1.2)

# Store table
(ctable1.2 <- coef(summary(reg1.2_gov.vic)))

# Calculate and store p values
p2 <- pnorm(abs(ctable[, "t value"]), lower.tail = FALSE) * 2

# Create combined table
(ctable1.2 <- cbind(ctable1.2, "p value" = p1.2))



#### Regression on rebel victory
reg2.1_reb.vic<-polr(reb.vic.dummy ~ , method='logistic', data=dataset_1, Hess = TRUE)
summary(reg2.1)

# Store table
(ctable2.1 <- coef(summary(reg2.1_reb.vic)))

# Calculate and store p values
p2.1 <- pnorm(abs(ctable2.1[, "t value"]), lower.tail = FALSE) * 2

# Create combined table
(ctable2.1 <- cbind(ctable2.1, "p value" = p2.1))


reg2.2_reb.vic<-polr(reb.vic.dummy ~ CorruptionPresident + CorruptionTax + EconomicSituation, method='logistic', data=dataset_1, Hess = TRUE)
summary(reg2.2)

# Store table
(ctable2.2 <- coef(summary(reg2.2_reb.vic)))

# Calculate and store p values
p2.2 <- pnorm(abs(ctable2.2[, "t value"]), lower.tail = FALSE) * 2

# Create combined table
(ctable2.2 <- cbind(ctable2.2, "p value" = p2.2))


#### Regression on negotiated settlement
reg3.1_settle<-polr(settle.dummy ~ CorruptionPresident + CorruptionTax + EconomicSituation, method='logistic', data=dataset_1, Hess = TRUE)
summary(reg3.1)

# Store table
(ctable3.1 <- coef(summary(reg3.1_settlement)))

# Calculate and store p values
p3.1 <- pnorm(abs(ctable3.1[, "t value"]), lower.tail = FALSE) * 2

# Create combined table
(ctable3.1 <- cbind(ctable3.1, "p value" = p3.1))



#######################################
#### Multinomial Logit Regreesion #####
#######################################

# Hausman Specification Test

# Hausman-McFadden Test for testing independence of irrelevant alternatives
hmftest(x, )

# Multinomial Logit Regression - Model 1
dat.1 <- Dataset_1[is.na(Dataset_1$conflict_outcome) == FALSE & is.na(Dataset_1$rebel.support_d) == FALSE, c("conflict_outcome", "rebel.support_d")]
mlogit1 <- multinom(conflict_outcome ~ rebel.support_d, data = dat.1)

# Multinomial Logit Regression - Model 2
dat.2 <- Dataset_1[is.na(Dataset_1$conflict_outcome) == FALSE & is.na(Dataset_1$rebel.support_d) == FALSE & is.na(Dataset_1$gov.support_d) == FALSE, ]
mlogit2 <- multinom(conflict_outcome ~ rebel.support_d + gov.support_d, data = dat.2)

# Multinomial Logit Regression - Model 3
dat.3 <- Dataset_1[is.na(Dataset_1$conflict_outcome) == FALSE & is.na(Dataset_1$rebel.support_d) == FALSE & is.na(Dataset_1$gov.support_d) == FALSE & is.na(Dataset_1$rtypesup_cat) == FALSE, ]
mlogit3 <- multinom(conflict_outcome ~ rebel.support_d + gov.support_d + rtypesup_cat, data = dat.3)

# Multinomial Logit Regression - Model 4
dat.4 <- Dataset_1[is.na(Dataset_1$conflict_outcome) == FALSE & is.na(Dataset_1$rebel.support_d) == FALSE & is.na(Dataset_1$gov.support_d) == FALSE & is.na(Dataset_1$rtypesup_cat) == FALSE & is.na(Dataset_1$gtypesup_cat) == FALSE, ]
mlogit4 <- multinom(conflict_outcome ~ rebel.support_d + gov.support_d + rtypesup_cat + gtypesup_cat, data = dat.4)

# Multinomial Logit Regression - Model 5
dat.5 <- Dataset_1[is.na(Dataset_1$conflict_outcome) == FALSE & is.na(Dataset_1$rebel.support_d) == FALSE & is.na(Dataset_1$gov.support_d) == FALSE & is.na(Dataset_1$rtypesup_cat) == FALSE & is.na(Dataset_1$gtypesup_cat) == FALSE & is.na(Dataset_1$fightcaphigh) == FALSE & is.na(Dataset_1$lngdp) == FALSE & is.na(Dataset_1$lnyears) == FALSE & is.na(Dataset_1$postCW) == FALSE, ]
mlogit5 <- multinom(conflict_outcome ~ rebel.support_d + gov.support_d + rtypesup_cat + gtypesup_cat + fightcaphigh + lngdp + lnyears + postCW, data = dat.5)