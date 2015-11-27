# Load packages
library("dplyr")
library("testdat")
library("car")

# Test all datasets for unicode characters
testdat::test_utf8(CIMI_Dataset)
testdat::test_utf8(NSA_Dataset)
testdat::test_utf8(UCDP_CT_Dataset)
testdat::test_utf8(UCDP_ES_Dataset)

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

# Removing "endorsement alleged military" before removing missing values
Cleaned_NSA$rtypesup_cat <- gsub(';', '', Cleaned_NSA$rtypesup_cat)
Cleaned_NSA$rtypesup_cat[Cleaned_NSA$rtypesup_cat == 'endorsement alleged military'] <- NA

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

##########################################################################
# Merge Cleaned_CIMI and Cleaned_NSA to Dataset_1  #
##########################################################################

# Create unique identifiers dyadid as preparation for merging
Cleaned_CIMI <- rename(Cleaned_CIMI, dyadid = dyad_id)

# Merge Cleaned_CIMI and Cleaned_NSA
Dataset_1 <- merge(x = Cleaned_CIMI, y= Cleaned_NSA, by = "dyadid" , all = TRUE)

# Check for complete cases
sum(complete.cases(Dataset_1))
