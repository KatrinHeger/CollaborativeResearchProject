#############################
# Inferential Statistics   ##
#############################

install.packages("nnet")
library(nnet)
install.packages("memisc")
library(memisc)


# Multinomial Logit Regression
dat.1 <- Dataset_1[is.na(Dataset_1$conflict_outcome) == FALSE & is.na(Dataset_1$rebel.support_d) == FALSE, c("conflict_outcome", "rebel.support_d")]
m1 <- multinom(conflict_outcome ~ rebel.support_d, data = dat.1)

dat.2 <- Dataset_1[is.na(Dataset_1$conflict_outcome) == FALSE & is.na(Dataset_1$rebel.support_d) == FALSE & is.na(Dataset_1$gov.support_d) == FALSE, ]
m2 <- multinom(conflict_outcome ~ rebel.support_d + gov.support_d, data = dat.2)

dat.3 <- Dataset_1[is.na(Dataset_1$conflict_outcome) == FALSE & is.na(Dataset_1$rebel.support_d) == FALSE & is.na(Dataset_1$gov.support_d) == FALSE & is.na(Dataset_1$rtypesup_cat) == FALSE, ]
m3 <- multinom(conflict_outcome ~ rebel.support_d + gov.support_d + rtypesup_cat, data = dat.3)

dat.4 <- Dataset_1[is.na(Dataset_1$conflict_outcome) == FALSE & is.na(Dataset_1$rebel.support_d) == FALSE & is.na(Dataset_1$gov.support_d) == FALSE & is.na(Dataset_1$rtypesup_cat) == FALSE & is.na(Dataset_1$gtypesup_cat) == FALSE, ]
m4 <- multinom(conflict_outcome ~ rebel.support_d + gov.support_d + rtypesup_cat + gtypesup_cat, data = dat.4)

dat.5 <- Dataset_1[is.na(Dataset_1$conflict_outcome) == FALSE & is.na(Dataset_1$rebel.support_d) == FALSE & is.na(Dataset_1$gov.support_d) == FALSE & is.na(Dataset_1$rtypesup_cat) == FALSE & is.na(Dataset_1$gtypesup_cat) == FALSE & is.na(Dataset_1$fightcaphigh) == FALSE & is.na(Dataset_1$lngdp) == FALSE & is.na(Dataset_1$lnyears) == FALSE & is.na(Dataset_1$postCW) == FALSE, ]
m5 <- multinom(conflict_outcome ~ rebel.support_d + gov.support_d + rtypesup_cat + gtypesup_cat + fightcaphigh + lngdp + lnyears + postCW, data = dat.5)

# Table 1
mtable(m1, m2, m3, m4, m5, digits = 3)
