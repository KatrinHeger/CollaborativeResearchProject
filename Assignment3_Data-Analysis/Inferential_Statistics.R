#############################
# Inferential Statistics   ##
#############################

# Load "nnet, "memisc" and "stargazer" packages
library(nnet)
library(memisc)
library(stargazer)

# Multinomial Logit Regression - Model 1
dat.1 <- Dataset_1[is.na(Dataset_1$conflict_outcome) == FALSE & is.na(Dataset_1$rebel.support_d) == FALSE, c("conflict_outcome", "rebel.support_d")]
m1 <- multinom(conflict_outcome ~ rebel.support_d, data = dat.1)

# Multinomial Logit Regression - Model 2
dat.2 <- Dataset_1[is.na(Dataset_1$conflict_outcome) == FALSE & is.na(Dataset_1$rebel.support_d) == FALSE & is.na(Dataset_1$gov.support_d) == FALSE, ]
m2 <- multinom(conflict_outcome ~ rebel.support_d + gov.support_d, data = dat.2)

# Multinomial Logit Regression - Model 3
dat.3 <- Dataset_1[is.na(Dataset_1$conflict_outcome) == FALSE & is.na(Dataset_1$rebel.support_d) == FALSE & is.na(Dataset_1$gov.support_d) == FALSE & is.na(Dataset_1$rtypesup_cat) == FALSE, ]
m3 <- multinom(conflict_outcome ~ rebel.support_d + gov.support_d + rtypesup_cat, data = dat.3)

# Multinomial Logit Regression - Model 4
dat.4 <- Dataset_1[is.na(Dataset_1$conflict_outcome) == FALSE & is.na(Dataset_1$rebel.support_d) == FALSE & is.na(Dataset_1$gov.support_d) == FALSE & is.na(Dataset_1$rtypesup_cat) == FALSE & is.na(Dataset_1$gtypesup_cat) == FALSE, ]
m4 <- multinom(conflict_outcome ~ rebel.support_d + gov.support_d + rtypesup_cat + gtypesup_cat, data = dat.4)

# Multinomial Logit Regression - Model 5
dat.5 <- Dataset_1[is.na(Dataset_1$conflict_outcome) == FALSE & is.na(Dataset_1$rebel.support_d) == FALSE & is.na(Dataset_1$gov.support_d) == FALSE & is.na(Dataset_1$rtypesup_cat) == FALSE & is.na(Dataset_1$gtypesup_cat) == FALSE & is.na(Dataset_1$fightcaphigh) == FALSE & is.na(Dataset_1$lngdp) == FALSE & is.na(Dataset_1$lnyears) == FALSE & is.na(Dataset_1$postCW) == FALSE, ]
m5 <- multinom(conflict_outcome ~ rebel.support_d + gov.support_d + rtypesup_cat + gtypesup_cat + fightcaphigh + lngdp + lnyears + postCW, data = dat.5)

# Model 1 Check
predicted.m1 <- predict(m1)
correct.m1 <- ifelse(predicted.m1 == dat.1$conflict_outcome, 1, 0)
table(correct.m1)
modal.m1 <- max(table(dat.1$conflict_outcome))
corr.pred.m1 <- sum(correct.m1)
pre.m1 <- 100 * ((corr.pred.m1 - modal.m1) / (nrow(dat.1) - modal.m1))
print(pre.m1, digits = 3)

# Model 2 Check
predicted.m2 <- predict(m2)
correct.m2 <- ifelse(predicted.m2 == dat.2$conflict_outcome, 1, 0)
table(correct.m2)
modal.m2 <- max(table(dat.2$conflict_outcome))
corr.pred.m2 <- sum(correct.m2)
pre.m2 <- 100 * ((corr.pred.m2 - modal.m2) / (nrow(dat.2) - modal.m2))
print(pre.m2, digits = 3)

# Model 3 Check
predicted.m3 <- predict(m3)
correct.m3 <- ifelse(predicted.m3 == dat.3$conflict_outcome, 1, 0)
table(correct.m3)
modal.m3 <- max(table(dat.3$conflict_outcome))
corr.pred.m3 <- sum(correct.m3)
pre.m3 <- 100 * ((corr.pred.m3 - modal.m3) / (nrow(dat.3) - modal.m3))
print(pre.m3, digits = 3)

# Model 4 Check
predicted.m4 <- predict(m4)
correct.m4 <- ifelse(predicted.m4 == dat.4$conflict_outcome, 1, 0)
table(correct.m4)
modal.m4 <- max(table(dat.4$conflict_outcome))
corr.pred.m4 <- sum(correct.m4)
pre.m4 <- 100 * ((corr.pred.m4 - modal.m4) / (nrow(dat.4) - modal.m4))
print(pre.m4, digits = 3)

# Model 5 Check
predicted.m5 <- predict(m5)
correct.m5 <- ifelse(predicted.m5 == dat.5$conflict_outcome, 1, 0)
table(correct.m5)
modal.m5 <- max(table(dat.5$conflict_outcome))
corr.pred.m5 <- sum(correct.m5)
pre.m5 <- 100 * ((corr.pred.m5 - modal.m5) / (nrow(dat.5) - modal.m3))
print(pre.m5, digits = 3)

# Create Table 1
mtable(m1, m2, m3, m4, m5, digits = 2)