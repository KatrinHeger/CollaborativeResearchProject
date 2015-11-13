#############################
# Inferential Statistics   ##
#############################

install.packages("nnet")
library(nnet)
install.packages("memisc")
library(memisc)


# Multinomial Logit Regression
dat.1 <- Model_1_Dataset[is.na(Model_1_Dataset$outcome_d) == FALSE & is.na(Model_1_Dataset$rebel.support_dummy) == FALSE, c("outcome_d", "rebel.support_dummy")]
M1.1 <- multinom(outcome_d ~ rebel.support_dummy, data = dat.1)

dat.2 <- Model_1_Dataset[is.na(Model_1_Dataset$outcome_d) == FALSE & is.na(Model_1_Dataset$rebel.support_dummy) == FALSE & is.na(Model_1_Dataset$gov.support_dummy) == FALSE, ]
M1.2 <- multinom(outcome_d ~ rebel.support_dummy + gov.support_dummy, data = dat.2)

dat.3 <- Model_1_Dataset[is.na(Model_1_Dataset$outcome_d) == FALSE & is.na(Model_1_Dataset$rebel.support_dummy) == FALSE & is.na(Model_1_Dataset$gov.support_dummy) == FALSE & is.na(Model_1_Dataset$rtypesup_cat) == FALSE, ]
M1.3 <- multinom(outcome_d ~ rebel.support_dummy + gov.support_dummy + rtypesup_cat, data = dat.3)

dat.4 <- Model_1_Dataset[is.na(Model_1_Dataset$outcome_d) == FALSE & is.na(Model_1_Dataset$rebel.support_dummy) == FALSE & is.na(Model_1_Dataset$gov.support_dummy) == FALSE & is.na(Model_1_Dataset$rtypesup_cat) == FALSE & is.na(Model_1_Dataset$gtypesup_cat) == FALSE, ]
M1.4 <- multinom(outcome_d ~ rebel.support_dummy + gov.support_dummy + rtypesup_cat + gtypesup_cat, data = dat.4)

dat.5 <- Model_1_Dataset[is.na(Model_1_Dataset$outcome_d) == FALSE & is.na(Model_1_Dataset$rebel.support_dummy) == FALSE & is.na(Model_1_Dataset$gov.support_dummy) == FALSE & is.na(Model_1_Dataset$rtypesup_cat) == FALSE & is.na(Model_1_Dataset$gtypesup_cat) == FALSE & is.na(Model_1_Dataset$fightcaphigh) == FALSE & is.na(Model_1_Dataset$coup) == FALSE & is.na(Model_1_Dataset$land) == FALSE & is.na(Model_1_Dataset$lngdp) == FALSE & is.na(Model_1_Dataset$lnyears) == FALSE & is.na(Model_1_Dataset$postCW) == FALSE, ]
M1.5 <- multinom(outcome_d ~ rebel.support_dummy + gov.support_dummy + rtypesup_cat + gtypesup_cat + fightcaphigh + coup + land + lngdp + lnyears + postCW, data = dat.5)

# Table 1
mtable(M1.1, M1.2, M1.3, M1.4, M1.5, digits = 3)
