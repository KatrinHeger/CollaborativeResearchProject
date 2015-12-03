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

# Recode "fightcaphigh" into from an integer to a factor
Dataset_1$fightcaphigh <- factor(Dataset_1$fightcaphigh)

# Create interaction variable between government intervention and fighting capacity
Dataset_1$gov.supXfight.cap <- as.numeric(as.character(Dataset_1$gov.support_d)) * 
                                as.numeric(as.character(Dataset_1$fightcaphigh))

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
