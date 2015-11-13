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

# Create subset of CIMI_Dataset for Model 1
Cleaned_CIMI_Model1 <- subset(CIMI_Dataset, select = c(1, 3, 6, 7, 8, 9, 10, 21, 22, 23, 24, 25))

# !!! ADD NOTE CONCERNING MODEL 2 !!!
# Create subset of CIMI_Dataset for Model 2
Cleaned_CIMI_Model2 <- subset(CIMI_Dataset, select = c(11, 13, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25))

# Remove all missing observations in column "outcome_d"
Cleaned_CIMI_Model1 <- Cleaned_CIMI_Model1[!is.na(CIMI_Dataset$outcome_d),]

###########################
# Clean NSA_Dataset       #
###########################

# Create subset of NSA_Dataset for Model 1
Cleaned_NSA_Model1 <- subset(NSA_Dataset, select = c(2, 3, 4, 6, 7, 8, 14, 15, 32, 33, 35, 36))

# Show variable class of rebel.support
class(Cleaned_NSA_Model1$rebel.support)

# Show variable class of gov.support
class(Cleaned_NSA_Model1$gov.support)

# Code rebel.support as a dummy with 1 = support, 0 = no support
Cleaned_NSA_Model1$rebel.support_dummy <- recode(Cleaned_NSA_Model1$rebel.support, " 'explicit' = 1;'no' = 0;'alleged' = 0 ")

# Code gov.support as a dummy with 1 = support and 0 = no support
Cleaned_NSA_Model1$gov.support_dummy <- recode(Cleaned_NSA_Model1$gov.support, " 'explicit' = 1;'no' = 0;'alleged' = 0 ")

# Show variable class of rtypesup
class(Cleaned_NSA_Model1$rtypesup)

# Show variable class of gtypesup
class(Cleaned_NSA_Model1$gtypesup)

# Remove all missing values in column "rtypesup"
Cleaned_NSA_Model1 <- Cleaned_NSA_Model1[!is.na(Cleaned_NSA_Model1$rtypesup),]

# Remove all missing values in column "gtypesup"
Cleaned_NSA_Model1 <- Cleaned_NSA_Model1[!is.na(Cleaned_NSA_Model1$gtypesup),]

# Remove observations "endorsement; alleged military" in column "rtypesup_cat"
# Note:
# As we only take into account military support that has actually taken place,
# we remove the category "endorsement; alleged military" (2 observations in total).
# Delete two empty rows in Cleaned_CIMI_Model1
# !!! Cleaned_NSA_Model1 <- Cleaned_NSA_Model1[-131, ]
# !!! Cleaned_NSA_Model1 <- Cleaned_NSA_Model1[-423, ]

# Code rtypesup as a categorical variable with 1=troops, 2=military, 3=non-military
Cleaned_NSA_Model1$rtypesup_cat <- recode(Cleaned_NSA_Model1$rtypesup, " 'troops' = 1; 'military' = 2; 'non-military' = 3 ")

# Code gtypesup as a categorical variable with 1=troops, 2=military, 3=non-military
Cleaned_NSA_Model1$gtypesup_cat <- recode(Cleaned_NSA_Model1$gtypesup, " 'troops' = 1; 'military' = 2; 'non-military' = 3 ")

###########################
# Clean UCDP_ES_Dataset   #
###########################

# !!! ADD NOTE CONCERNING MODEL 2 !!!
# Create subset of NSA_Dataset for Model 2
Cleaned_ES_Model2 <- subset(UCDP_ES_Dataset, select = c(2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 15, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30))

##########################################################################
# Merging Cleaned_CIMI_Model1 and Cleaned_NSA_Model1 to Dataset_Model_1  #
##########################################################################

# Create unique identifiers conflictid and dyadid as preparation for merging
Cleaned_NSA_Model1 <- rename(Cleaned_NSA_Model1, conflictid = ucdpid)
Cleaned_CIMI_Model1 <- rename(Cleaned_CIMI_Model1, dyadid = dyad_id)

# Merge Cleaned_CIMI_Model1 and Cleaned_NSA_Model1
Model_1_Dataset <- merge(Cleaned_CIMI_Model1, Cleaned_NSA_Model1, union("conflictid", "dyadid"), all = TRUE)

# Check for complete cases
sum(complete.cases(Model_1_Dataset))