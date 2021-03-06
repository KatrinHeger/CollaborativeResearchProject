##################################################################
# MPP-E1180: Intro. to Collab. Social Science Data Analyis       #
# November 2015                                                  #
# Collaborative Research Project                                 #
# Katrin Heger & Benedikt Abendroth                              #
# Impact of Intervention on Conflict Outcomes                    #
# For more information please read the README file or            #
# Research Proposal                                              #
##################################################################

# Retrieving current working directory
# getwd()

# Setting the working directory (in this case: Github Folder online)
# setwd(~/GitHub/CollaborativeResearchProject)

# In order to pursue our analysis, the following packages are necessary:
# (1) rio
# (2) gdata
# (3) mlogit
# (4) dplyr
# (5) testdat
# (6) car
# (7) Hmisc
# (8) ggplot2
# (9) nnet
# (10) memisc
# (11) stargazer
# Information about the packages being used in this project
# can be found in our BibTeX file.

##################################
# Load all packages being used   #
##################################

# Start all necessary packages as mentioned above
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

#######################
# Load all datasets   #
#######################

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
CIMI_Dataset <- rio::import("https://raw.githubusercontent.com/KatrinHeger/CollaborativeResearchProject/master/Datasets/CIMI.csv")

# Load and import the UCDP_ES_Dataset
# Note:
# Unfortunately we haven't been able yet to directly access this file from
# the website of UCDP directly, due to the error "Unknown format" when downloading
# it in R Studio. While we are trying to resolve this issue, we are using the file
# in our public Github repository.
# The file has been retrieved on November 1, 2015, from
# http://www.pcr.uu.se/digitalAssets/159/159834_1external_support_compact_dataset_1.00_20110325-1.xls
# # SHA-1 hash:
# f2b08a7805eb5d1a3f112486640e60a3add67045
UCDP_ES_Dataset <- rio::import("~/GitHub/CollaborativeResearchProject/Datasets/UCDP_ExternalSupportDataset.xls")

# Load the UCDP_CT_Dataset
# Note: 
# There is an R package called "UCDPtools" (https://github.com/tlscherer/UCDPtools),
# which is supposed to directly import datasets from UCDP into R Studio. Unfortunately,
# the current version of R Studio (3.2.2) is not supported.
UCDP_CT_xls = "http://www.pcr.uu.se/digitalAssets/124/124924_1ucdp_conflict_termination_2010_dyad.xls"

# Import the UCDP_CT_Dataset
UCDP_CT_Dataset = gdata::read.xls(UCDP_CT_xls, sheet = 4)

# Load and import the NSA_Dataset
NSA_Dataset <- rio::import("http://privatewww.essex.ac.uk/~ksg/data/nsa_v3.4_21November2013.asc", format = "tsv")

# Test all datasets for unicode characters
testdat::test_utf8(CIMI_Dataset)
testdat::test_utf8(NSA_Dataset)
testdat::test_utf8(UCDP_CT_Dataset)
testdat::test_utf8(UCDP_ES_Dataset)

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
Cleaned_CIMI <- subset(CIMI_Dataset, select = c(1, 3, 6, 8, 9, 10, 21, 22, 24, 25))

# Rename dependent variable "outcome_d" into "conflict_outcome"
colnames(Cleaned_CIMI)[colnames(Cleaned_CIMI)=="outcome_d"] <- "conflict_outcome"

# Remove all missing observations in dependent variable "conflict_outcome"
Cleaned_CIMI <- Cleaned_CIMI[!is.na(Cleaned_CIMI$conflict_outcome),]

###########################
# Clean NSA_Dataset       #
###########################

# Create subset of NSA_Dataset including relevant variables
Cleaned_NSA <- subset(NSA_Dataset, select = c(3, 4, 6, 7, 8, 14, 32, 33, 35, 36))

# Remove all missing values from explanatory variable "rebel.support"
Cleaned_NSA <- Cleaned_NSA[!is.na(Cleaned_NSA$rebel.support),]

# Remove all missing values from explanatory variable "gov.support"
Cleaned_NSA <- Cleaned_NSA[!is.na(Cleaned_NSA$gov.support),]

# Show variable class of rebel.support
class(Cleaned_NSA$rebel.support)

# Show variable class of gov.support
class(Cleaned_NSA$gov.support)

# Code character variable rebel.support as dummy with 1 = support, 0 = no support
Cleaned_NSA$rebel.support_d <- recode(Cleaned_NSA$rebel.support, " 'explicit' = 1;'no' = 0;'alleged' = 0 ")

# Code character gov.support as a dummy with 1 = support and 0 = no support
Cleaned_NSA$gov.support_d <- recode(Cleaned_NSA$gov.support, " 'explicit' = 1;'no' = 0;'alleged' = 0 ")

# Treat "rebel.support_d" and "gov.support_d" as factor variables
Cleaned_NSA$rebel.support_d=as.factor(Cleaned_NSA$rebel.support_d)
Cleaned_NSA$gov.support_d=as.factor(Cleaned_NSA$rebel.support_d)

# Remove all missing values from explanatory variable "rtypesup"
Cleaned_NSA <- Cleaned_NSA[!is.na(Cleaned_NSA$rtypesup),]

# Remove all missing values from explanatory variable "gtypesup"
Cleaned_NSA <- Cleaned_NSA[!is.na(Cleaned_NSA$gtypesup),]

# Show variable class of rtypesup
class(Cleaned_NSA$rtypesup)

# Show variable class of gtypesup
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
Cleaned_CIMI <- rename(Cleaned_CIMI, dyadid = dyad_id)

# Merge Cleaned_CIMI and Cleaned_NSA
Dataset_1 <- merge(x = Cleaned_CIMI, y= Cleaned_NSA, by = "dyadid" , all = TRUE)

# Check for complete cases
sum(complete.cases(Dataset_1))

#####################################
# Descriptive Statistics            #
#####################################

# Describe the whole data frame
dim(Dataset_1) # Our dataset currently entails 497 rows and 23 columns/variables

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
qplot(Dataset_1$conflict_outcome, geom = "histogram", binwidth = .5, main = "Frequency of Rebel Support Types", xlab = "Support Types", ylab = "Frequency", fill = I("lightblue"))

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
qplot(Dataset_1_gtype_HG$gtypesup_cat, geom = "histogram", binwidth = .5, main = "Frequency of Government Support Types", xlab = "Support Types", ylab = "Frequency", fill = I("lightgreen"))

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

#############################
# Inferential Statistics   ##
#############################

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