##################################################################
# MPP-E1180: Intro. to Collab. Social Science Data Analyis       #
# 17 December 2015                                               #
# Collaborative Research Project                                 #
# Katrin Heger & Benedikt Abendroth                              #
# Impact of Intervention on Conflict Outcomes                    #
# For more information please read the README file or            #
##################################################################

# Retrieving current working directory
# getwd()

# Setting the working directory (in this case: Github Folder online)
# setwd(~/GitHub/CollaborativeResearchProject)

##################################
# Load all packages being used   #
##################################

# Start all necessary packages
library("rio")
library("gdata")
library("mlogit")
library("dplyr")
library("testdat")
library("car")
library("Hmisc")
library("ggplot2")
library("nnet")
library("memisc")
library("stargazer")
library("mnlogit")

# Information about the packages being used in this project
# can be found in our BibTeX file.

###################
# Load datasets   #
###################

# Load and import the CIMI_Dataset from our Github repository
# Note:
# The only package (as fas as we know) that can directly access the
# API of the Harvard Dataverse Network is a package called "DVN".
# Unfortunately, it hasn't been updated yet to work with the current
# Harvard Dataverse version 4.0. Hence, we had to download it by hand.
# Source of issue of DVN package: https://github.com/ropensci/dvn/issues/23
# The file was retrieved on November 1, 2015 from
# https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/BTKZEQ
# SHA-1 hash:
# aec313662cd7e1e5fa8b205c5c1180d542cee91a
CIMI_Dataset <- rio::import("https://raw.githubusercontent.com/KatrinHeger/CollaborativeResearchProject/master/Data_Gathering/CIMI.csv")

# Load and import the NSA_Dataset
NSA_Dataset <- rio::import("http://privatewww.essex.ac.uk/~ksg/data/nsa_v3.4_21November2013.asc", format = "tsv")

# Test all datasets for unicode characters
testdat::test_utf8(CIMI_Dataset)
testdat::test_utf8(NSA_Dataset)

###########################################################################
# Important Note:                                                         #
#################                                                         #
# Due to the fact that we are still not able to execute code/functions    #
# that are written on multiple lines, functions are always written in     #
# one line throughout the whole file.                                     #
# See https://github.com/HertieDataScience/SyllabusAndLectures/issues/36  #
###########################################################################

###########################
# Clean CIMI_Dataset      #
###########################

# Create subset of CIMI_Dataset including relevant variables
Cleaned_CIMI <- subset(CIMI_Dataset, select = c(1, 2, 3, 4, 6, 7, 8, 9, 10, 20, 21, 22, 23, 24, 25))

# Rename dependent variable "outcome_d" into "conflict_outcome"
colnames(Cleaned_CIMI)[colnames(Cleaned_CIMI)=="outcome_d"] <- "conflict_outcome"

# Rename variable "land" into "secessionist"
colnames(Cleaned_CIMI)[colnames(Cleaned_CIMI)=="land"] <- "secessionist"

# Remove all missing observations in dependent variable "conflict_outcome"
Cleaned_CIMI <- Cleaned_CIMI[!is.na(Cleaned_CIMI$conflict_outcome),]

###########################
# Clean NSA_Dataset       #
###########################

# Create subset of NSA_Dataset including relevant variables
Cleaned_NSA <- subset(NSA_Dataset, select = c(3, 7, 8, 14, 27, 32, 33, 35, 36))

# Remove all missing values from explanatory variable "rebel.support"
Cleaned_NSA <- Cleaned_NSA[!is.na(Cleaned_NSA$rebel.support),]

# Remove all missing values from explanatory variable "gov.support"
Cleaned_NSA <- Cleaned_NSA[!is.na(Cleaned_NSA$gov.support),]

# Show class of rebel.support
class(Cleaned_NSA$rebel.support)

# Show class of gov.support
class(Cleaned_NSA$gov.support)

# Show class of rebpolwinglegal
class(Cleaned_NSA$rebpolwinglegal)

# Code character variable rebel.support as dummy (rebel.support_d) with 1 = support, 0 = no support
Cleaned_NSA$rebel.support_d <- recode(Cleaned_NSA$rebel.support, " 'explicit' = 1;'no' = 0;'alleged' = 0 ")

# Code character gov.support as a dummy (gov.support_d) with 1 = support and 0 = no support
Cleaned_NSA$gov.support_d <- recode(Cleaned_NSA$gov.support, " 'explicit' = 1;'no' = 0;'alleged' = 0 ")

# Code character rebpolwinglegal as a dummy (rebpolwinglegal_d) with 1 = yes, 0 = no
Cleaned_NSA$rebpolwinglegal_d <- recode(Cleaned_NSA$rebpolwinglegal, " 'yes' = 1; 'no' = 0 ")

# Treat "rebel.support_d" and "gov.support_d" as factor variables
Cleaned_NSA$rebel.support_d=as.factor(Cleaned_NSA$rebel.support_d)
Cleaned_NSA$gov.support_d=as.factor(Cleaned_NSA$rebel.support_d)

# Removing "endorsement alleged military" before removing missing values
Cleaned_NSA$rtypesup <- gsub(';', '', Cleaned_NSA$rtypesup)
Cleaned_NSA$rtypesup[Cleaned_NSA$rtypesup == 'endorsement alleged military'] <- NA

# Remove all missing values from explanatory variable "rtypesup"
Cleaned_NSA <- Cleaned_NSA[!is.na(Cleaned_NSA$rtypesup),]

# Remove all missing values from explanatory variable "gtypesup"
Cleaned_NSA <- Cleaned_NSA[!is.na(Cleaned_NSA$gtypesup),]

# Show class of rtypesup
class(Cleaned_NSA$rtypesup)

# Show class of gtypesup
class(Cleaned_NSA$gtypesup)

# Code rtypesup as a categorical variable with 1=troops, 2=military, 3=non-military
Cleaned_NSA$rtypesup_cat <- recode(Cleaned_NSA$rtypesup, " 'troops' = 1; 'military' = 2; 'non-military' = 3 ")

# Code gtypesup as a categorical variable with 1=troops, 2=military, 3=non-military
Cleaned_NSA$gtypesup_cat <- recode(Cleaned_NSA$gtypesup, " 'troops' = 1; 'military' = 2; 'non-military' = 3 ")

# Treat "rtypesup_cat" and "gtype_cat" as factor variables
Cleaned_NSA$rtypesup_cat=as.factor(Cleaned_NSA$rtypesup_cat)
Cleaned_NSA$gtypesup_cat=as.factor(Cleaned_NSA$gtypesup_cat)

#########################################################
# Merge Cleaned_CIMI and Cleaned_NSA to Dataset_1       #
#########################################################

# Create unique identifiers dyadid as preparation for merging
Cleaned_CIMI <- rename(Cleaned_CIMI, dyad_id = "dyadid")

# Merge Cleaned_CIMI and Cleaned_NSA
Dataset_1 <- merge(x = Cleaned_CIMI, y= Cleaned_NSA, by = "dyadid" , all = TRUE)

# Removing duplicate column "postCW.1"
Dataset_1 <- dplyr::select(Dataset_1, -postCW.1)

# Create dummy variable for government victory as conflict outcome
Dataset_1$gov.vic.dummy <- recode(Dataset_1$conflict_outcome, " '3' = 1; '0' = 0; '1' = 0; '2' = 0 ")

# Create dummy variable for rebel victory as conflict outcome
Dataset_1$reb.vic.dummy <- recode(Dataset_1$conflict_outcome, " '1' = 1; '0' = 0; '2' = 0; '3' = 0 ")

# Create dummy variable for settlement as conflict outcome
Dataset_1$settle.dummy <- recode(Dataset_1$conflict_outcome, " '2' = 1; '0' = 0; '1' = 0; '3' = 0 ")

# Create dummy variable for low activity as conflict outcome
Dataset_1$low.act.dummy <- recode(Dataset_1$conflict_outcome, " '0' = 1; '1' = 0; '2' = 0; '3' = 0 ")

# Show class of "fightcaphigh"
class(Dataset_1$fightcaphigh)

# Recode "fightcaphigh" from an integer to a factor
Dataset_1$fightcaphigh <- factor(Dataset_1$fightcaphigh)

# Create interaction variable between government intervention and fighting capacity
Dataset_1$gov.supXfight.cap <- as.numeric(as.character(Dataset_1$gov.support_d)) * as.numeric(as.character(Dataset_1$fightcaphigh))

# Check for complete cases
sum(complete.cases(Dataset_1))

#####################################
# Descriptive Statistics            #
#####################################

# Describe the whole data frame
dim(Dataset_1) # Our dataset currently entails 497 rows and 27 columns/variables

##################################
# Conflict Outcomes              #
##################################

# Show the distribution of all conflict outcomes ("conflict_outcome),
# including the percentage distribution (last line out print).
# Coding of "outcome_d":
# 0: low activity
# 1: rebel victory
# 2: settlement
# 3: government victory
describe(Dataset_1$conflict_outcome)

# Create histogram of conflict outcomes ("conflict_outcome)
qplot(Dataset_1$conflict_outcome, geom = "histogram", binwidth = .5, main = "Frequency of Conflict Outcomes", xlab = "Conflict Outcomes", ylab = "Frequency", alpha = I(.9), fill = I("lightblue"))

##################################
# Types of Government Support    #
##################################

# Display the distribution of all types of government support ("gtypesup_cat"),
# including the percentage distribution (last line out print).
# Coding of "gtypesup_cat":
# 1: troops
# 2: military
# 3: non-military
describe(Dataset_1$gtypesup_cat)

# Remove missing values at "gtypesup_cat"
Dataset_1_gtype_HG <- Dataset_1[!is.na(Dataset_1$gtypesup_cat),]

# Create histogram of third-party support types for government
qplot(Dataset_1_gtype_HG$gtypesup_cat, geom = "histogram", binwidth = .5, main = "Frequency of Government Support Types", xlab = "Support Types", ylab = "Frequency", alpha = I(.9), fill = I("lightgreen"))

##################################
# Types of Rebel Support         #
##################################

# Show the distribution of all types of rebel support ("rtypesup_cat"),
# including the percentage distribution (last line out print).
# Coding of "rtypesup_cat":
# 1: troops
# 2: military
# 3: non-military
describe(Dataset_1$rtypesup_cat)

# Remove missing values at "rtypesup_cat"
Dataset_1_rtype_HG <- Dataset_1[!is.na(Dataset_1$gtypesup_cat),]

# Create histogram of third-party support types for rebels
qplot(Dataset_1_rtype_HG$rtypesup_cat, geom = "histogram", binwidth = .5, main = "Frequency of Rebel Support Types", xlab = "Support Types", ylab = "Frequency", alpha = I(.9), fill = I("brown"))

###########################
# Inferential Statistics  #
###########################

## Regression Preparation 
# Create dataframe of independent variables
DF_Independent <- data.frame(as.numeric(Dataset_1$gtypesup_cat), as.numeric(Dataset_1$rtypesup_cat), as.numeric(Dataset_1$gov.supXfight.cap), as.numeric(Dataset_1$lngdp), as.numeric(Dataset_1$coup), as.numeric(Dataset_1$secessionist), as.numeric(Dataset_1$lnyears), as.numeric(Dataset_1$postCW), as.numeric(Dataset_1$rebpolwinglegal_d))

# Check for multicollinearity with correlation matrix of independent variables
COR <- cor(DF_Independent, use = 'complete.obs')
# Findings: No multicollinearity

####################
# Logit Regression #
####################

# What kind of support is most likely to lead to an intended outcome?
# How high is the probability of the desired outcome, given a specific kind of intervention?

####################################
# Regression on government victory #
####################################

# Recode "gov.vic.dummy" into factor
Dataset_1$gov.vic.dummy <- as.factor(Dataset_1$gov.vic.dummy)

# Logit Regression on government victory (1)
reg1.1_gov.vic<-glm(Dataset_1$gov.vic.dummy ~ Dataset_1$gtypesup_cat -1, data=Dataset_1, family = binomial)
stargazer(reg1.1_gov.vic, type = "text", digits = 2)

# Logit Regression on government victory (2)
reg1.2_gov.vic<-glm(Dataset_1$gov.vic.dummy ~ Dataset_1$gtypesup_cat -1 + Dataset_1$mi_fightcap, data=Dataset_1, family = binomial)
stargazer(reg1.2_gov.vic, type = "text", digits = 2)

# Logit Regression on government victory (3)
reg1.3_gov.vic<-glm(Dataset_1$gov.vic.dummy ~ Dataset_1$gtypesup_cat + Dataset_1$mi_fightcap + Dataset_1$lngdp, data=Dataset_1, family = binomial)
stargazer(reg1.3_gov.vic, type = "text", digits = 2)

# Logit Regression on government victory (4)
reg1.4_gov.vic<-glm(Dataset_1$gov.vic.dummy ~ Dataset_1$gtypesup_cat + Dataset_1$mi_fightcap + Dataset_1$lngdp, data=Dataset_1, family = binomial)
stargazer(reg1.4_gov.vic, type = "text", digits = 2)

# Logit Regression on government victory (5)
reg1.5_gov.vic<-glm(Dataset_1$gov.vic.dummy ~ Dataset_1$gtypesup_cat + Dataset_1$mi_fightcap + Dataset_1$lngdp + Dataset_1$lnyears, data=Dataset_1, family = binomial)
stargazer(reg1.5_gov.vic, type = "text", digits = 2)

# Logit Regression on government victory (6)
reg1.6_gov.vic<-glm(Dataset_1$gov.vic.dummy ~ Dataset_1$gtypesup_cat + Dataset_1$mi_fightcap + Dataset_1$lngdp + Dataset_1$lnyears + Dataset_1$rebpolwinglegal, data=Dataset_1, family = binomial)
stargazer(reg1.6_gov.vic, type = "text", digits = 2)

# Logit Regression on government victory (7)
reg1.7_gov.vic<-glm(Dataset_1$gov.vic.dummy ~ Dataset_1$gtypesup_cat -1 + Dataset_1$mi_fightcap + Dataset_1$lngdp + Dataset_1$lnyears + Dataset_1$rebpolwinglegal + Dataset_1$secessionist, data=Dataset_1, family = binomial)
stargazer(reg1.7_gov.vic, type = "text", digits = 2)

# Confidence Intervals
confint(reg1.7_gov.vic)

###############################
# Regression on rebel victory #
###############################

# Recode "reb.vic.dummy" into factor
Dataset_1$reb.vic.dummy <- as.factor(Dataset_1$reb.vic.dummy)

# Logit Regression on rebel victory (1)
reg2.1_reb.vic <- nnet(Dataset_1$reb.vic.dummy ~ Dataset_1$rtypesup_cat, family = binomial, size = 3)
stargazer(reg2.1_reb.vic, type = "latex", digits = 2)

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

## Dropping NA's from Dataset
dat.3 <- Dataset_1[is.na(Dataset_1$conflict_outcome) == FALSE & is.na(Dataset_1$gtypesup_cat) == FALSE & is.na(Dataset_1$rtypesup_cat) == FALSE & is.na(Dataset_1$mi_fightcap) == FALSE & is.na(Dataset_1$lngdp) == FALSE & is.na(Dataset_1$lnyears) == FALSE & is.na(Dataset_1$rebpolwinglegal) == FALSE & is.na(Dataset_1$secessionist) == FALSE & is.na(Dataset_1$gov.supXfight.cap) == FALSE, ]

## Government without Interaction Variable

# Multinomial Logit Regression 1 - Government Support Type
mlogit3_gov_1 <- multinom(Dataset_1$conflict_outcome ~ Dataset_1$gtypesup_cat -1, data = dat.3)
# Table
stargazer(mlogit3_gov_1, type = "text", digits = 2, dep.var.labels = rep(c('Rebel Victory', 'Negotiation', 'Gov. Victory'), 3), covariate.labels=c('Gov. S. Troops', 'Gov. S. Military', 'Gov. S. Non-military'))
# Anova
Anova(mlogit3_gov_1)
# Confidence Intervals
confint(mlogit3_gov_1)
# Odds Ratios
exp(coef(mlogit3_gov_1))

# Multinomial Logit Regression 2 - Government Support Type
mlogit3_gov_2 <- multinom(Dataset_1$conflict_outcome ~ Dataset_1$gtypesup_cat -1 + Dataset_1$mi_fightcap, data = dat.3)
# Table
stargazer(mlogit3_gov_2, type = "text", digits = 2, dep.var.labels = rep(c('Rebel Victory', 'Negotiation', 'Gov. Victory'), 3), covariate.labels=c('Gov. S. Troops', 'Gov. S. Military', 'Gov. S. Non-military', 'Fighting Capacity', 'Interaction GovXFi'))
# Anova
Anova(mlogit3_gov_2)
# Confidence Intervals
confint(mlogit3_gov_2)
# Odds Ratios
exp(coef(mlogit3_gov_2))

# Multinomial Logit Regression 3 - Government Support Type
mlogit3_gov_3 <- multinom(Dataset_1$conflict_outcome ~ Dataset_1$gtypesup_cat -1 + Dataset_1$mi_fightcap + Dataset_1$lngdp + Dataset_1$lnyears + Dataset_1$rebpolwinglegal + Dataset_1$secessionist, data = dat.3)
# Table
stargazer(mlogit3_gov_3, type = "text", digits = 2, dep.var.labels = rep(c('Rebel Victory', 'Negotiation', 'Gov. Victory'), 3), covariate.labels=c('Gov. S. Troops', 'Gov. S. Military', 'Gov. S. Non-military', 'Fighting Capacity','Interaction GovXFi', 'GDP', 'Duration', 'Reb. Legal Wing', 'Secessionist'))
# Anova
Anova(mlogit3_gov_3)
# Confidence Intervals
confint(mlogit3_gov_3)
# Odds Ratios
exp(coef(mlogit3_gov_3))

## Government with Interaction Variable

# Multinomial Logit Regression 1 - Government Support Type
mlogit3_gov_1X <- multinom(Dataset_1$conflict_outcome ~ Dataset_1$gtypesup_cat -1, data = dat.3)
# Table
stargazer(mlogit3_gov_1X, type = "text", digits = 2, dep.var.labels = rep(c('Rebel Victory', 'Negotiation', 'Gov. Victory'), 3), covariate.labels=c('Gov. S. Troops', 'Gov. S. Military', 'Gov. S. Non-military'))
# Anova
Anova(mlogit3_gov_1X)
# Confidence Intervals
confint(mlogit3_gov_1X)
# Odds Ratios
exp(coef(mlogit3_gov_1X))

# Multinomial Logit Regression 2 - Government Support Type
mlogit3_gov_2X <- multinom(Dataset_1$conflict_outcome ~ Dataset_1$gtypesup_cat -1 + Dataset_1$mi_fightcap + Dataset_1$gov.supXfight.cap, data = dat.3)
# Table
stargazer(mlogit3_gov_2X, type = "text", digits = 2, dep.var.labels = rep(c('Rebel Victory', 'Negotiation', 'Gov. Victory'), 3), covariate.labels=c('Gov. S. Troops', 'Gov. S. Military', 'Gov. S. Non-military', 'Fighting Capacity', 'Interaction GovXFi'))
# Anova
Anova(mlogit3_gov_2X)
# Confidence Intervals
confint(mlogit3_gov_2X)
# Odds Ratios
exp(coef(mlogit3_gov_2X))

# Multinomial Logit Regression 3 - Government Support Type
mlogit3_gov_3X <- multinom(Dataset_1$conflict_outcome ~ Dataset_1$gtypesup_cat -1 + Dataset_1$mi_fightcap + Dataset_1$gov.supXfight.cap + Dataset_1$lngdp + Dataset_1$lnyears + Dataset_1$rebpolwinglegal + Dataset_1$secessionist, data = dat.3)
# Table
stargazer(mlogit3_gov_3X, type = "text", digits = 2, dep.var.labels = rep(c('Rebel Victory', 'Negotiation', 'Gov. Victory'), 3), covariate.labels=c('Gov. S. Troops', 'Gov. S. Military', 'Gov. S. Non-military', 'Fighting Capacity','Interaction GovXFi', 'GDP', 'Duration', 'Reb. Legal Wing', 'Secessionist'))
# Anova
Anova(mlogit3_gov_3X)
# Confidence Intervals
confint(mlogit3_gov_3X)
# Odds Ratios
exp(coef(mlogit3_gov_3X))

## Rebels without Interaction Variable

# Multinomial Logit Regression 1 - Rebel Support Type
mlogit3_reb_1 <- multinom(Dataset_1$conflict_outcome ~ Dataset_1$rtypesup_cat -1, data = dat.3)
# Table
stargazer(mlogit3_reb_1, type = "text", digits = 2, dep.var.labels = rep(c('Rebel Victory', 'Negotiation', 'Gov. Victory'), 3), covariate.labels=c('Rebel S. Troops', 'Rebel. S. Military', 'Rebel. S. Non-military'))
# Anova
Anova(mlogit3_reb_1)
# Confidence Intervals
confint(mlogit3_reb_1)
# Odds Ratios
exp(coef(mlogit3_reb_1))

# Multinomial Logit Regression 2 - Rebel Support Type
mlogit3_reb_2 <- multinom(Dataset_1$conflict_outcome ~ Dataset_1$rtypesup_cat -1 + Dataset_1$mi_fightcap, data = dat.3)
# Table
stargazer(mlogit3_reb_2, type = "text", digits = 2, dep.var.labels = rep(c('Rebel Victory', 'Negotiation', 'Gov. Victory'), 3), covariate.labels=c('Rebel S. Troops', 'Rebel. S. Military', 'Rebel. S. Non-military', 'Fighting Capacity'))
# Anova
Anova(mlogit3_reb_2)
# Confidence Intervals
confint(mlogit3_reb_2)
# Odds Ratios
exp(coef(mlogit3_reb_2))

# Multinomial Logit Regression 3 - Rebel Support Type
mlogit3_reb_3 <- multinom(Dataset_1$conflict_outcome ~ Dataset_1$rtypesup_cat -1 + Dataset_1$mi_fightcap + Dataset_1$lngdp + Dataset_1$lnyears + Dataset_1$rebpolwinglegal + Dataset_1$secessionist, data = dat.3)
# Table
stargazer(mlogit3_reb_3, type = "text", digits = 2, dep.var.labels = rep(c('Rebel Victory', 'Negotiation', 'Gov. Victory'), 3), covariate.labels=c('Rebel S. Troops', 'Rebel. S. Military', 'Rebel. S. Non-military', 'Fighting Capacity', 'GDP', 'Duration', 'Reb. Legal Wing', 'Secessionist'))
# Anova
Anova(mlogit3_reb_3)
# Confidence Intervals
confint(mlogit3_reb_3)
# Odds Ratios
exp(coef(mlogit3_reb_3))

#######################################################
# New Complete Final Multinomial Logit Regression     #
#######################################################

# Multinomial Logit Regression 3 - Government Support Type
mlogit3_complete <- multinom(Dataset_1$conflict_outcome ~ Dataset_1$gtypesup_cat + Dataset_1$rtypesup_cat -1 + Dataset_1$mi_fightcap + Dataset_1$gov.supXfight.cap + Dataset_1$lngdp + Dataset_1$lnyears + Dataset_1$rebpolwinglegal + Dataset_1$secessionist, data = dat.3)

# Create Table
stargazer(mlogit3_complete, type = "text", digits = 2, dep.var.labels = rep(c('Rebel Victory', 'Negotiation', 'Gov. Victory'), 3), covariate.labels=c('Gov. S. Troops', 'Gov. S. Military', 'Gov. S. Non-military', 'Rebel S. Military', 'Rebel S. Non-military', 'Fighting Capacity','Interaction GovXFi', 'GDP', 'Duration', 'Reb. Legal Wing', 'Secessionist'))

###########################
# Relative Risk Ratio     #
###########################

exp(coef(mlogit3_complete))

##############################
# Predicted Probabilities    #
##############################

# Predicting the choice probabilities
mlogit3_reb_3_pred <- predict(mlogit3_reb_3, dat.3, "probs")

# Create table
stargazer(mlogit3_reb_3_pred, type = "text", digits = 2)

# TBD

#####################################
# Tests: Quality of the Model       #
#####################################

# TBD