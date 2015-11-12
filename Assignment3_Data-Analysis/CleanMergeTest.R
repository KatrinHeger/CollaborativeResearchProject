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

# Create subset of CIMI_Dataset for Model 2
Cleaned_CIMI_Model2 <- subset(CIMI_Dataset, select = c(11, 13, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25))

# Delete all empty rows in Cleaned_CIMI_Model1
Cleaned_CIMI_Model1 <- Cleaned_CIMI_Model1[-(2297:2428), ]

# Delete all empty rows in Cleaned_CIMI_Model2
Cleaned_CIMI_Model2 <- Cleaned_CIMI_Model2[-(2297:2428), ]

###########################
# Clean NSA_Dataset       #
###########################

# Create subset of NSA_Dataset for Model 1
Cleaned_NSA_Model1 <- subset(NSA_Dataset, select = c(2, 3, 4, 6, 7, 8, 14, 15, 32, 33, 35, 36))

# Show variable class of rebel.support
class(Cleaned_NSA_Model1$rebel.support)

# Show variable class of gov.support
class(Cleaned_NSA_Model1$gov.support)

# Code rebel.support as a dummy with 1=support, 0=no support
Cleaned_NSA_Model1$rebel.support_dummy <- recode(Cleaned_NSA_Model1$rebel.support, " 'explicit' = 1;'no' = 0;'alleged' = 0 ")

# Code gov.support as a dummy with 1 = support and 0 = no support
Cleaned_NSA_Model1$gov.support_dummy <- recode(Cleaned_NSA_Model1$gov.support, " 'explicit' = 1;'no' = 0;'alleged' = 0 ")

# Show variable class of rtypesup
class(Cleaned_NSA_Model1$rtypesup)

# Show variable class of gtypesup
class(Cleaned_NSA_Model1$gtypesup)

# Code rtypesup as a categorical variable with 1=troops, 2=military, 3=non-military
Cleaned_NSA_Model1$rtypesup_cat <- recode(Cleaned_NSA_Model1$rtypesup, " 'troops' = 1; 'military' = 2; 'non-military' = 3 ")

# Code gtypesup as a categorical variable with 1=troops, 2=military, 3=non-military
Cleaned_NSA_Model1$gtypesup_cat <- recode(Cleaned_NSA_Model1$gtypesup, " 'troops' = 1; 'military' = 2; 'non-military' = 3 ")

###########################
# Clean UCDP_ES_Dataset   #
###########################

# Create subset of NSA_Dataset for Model 2
Cleaned_ES_Model2 <- subset(UCDP_ES_Dataset, select = c(2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 15, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30))

##########################################################################
# Merging Cleaned_CIMI_Model1 and Cleaned_NSA_Model1 to Dataset_Model_1  #
##########################################################################

# Create unique identifiers conflictid and dyadid as preparation for merging
Cleaned_NSA_Model1 <- rename(Cleaned_NSA_Model1, conflictid = ucdpid)
Cleaned_CIMI_Model1 <- rename(Cleaned_CIMI_Model1, dyadid = dyad_id)

# Sort Cleaned_NSA_Model1 by conflictid
Cleaned_NSA_Model1[ order(Cleaned_NSA_Model1$conflictid), ]

# Sort Cleaned_CIMI_Model1 by conflictid
Cleaned_CIMI_Model1[ order(Cleaned_CIMI_Model1$conflictid), ]

# Merge Cleaned_CIMI_Model1 and Cleaned_NSA_Model1
Dataset_Model_1 <- merge(Cleaned_CIMI_Model1, Cleaned_NSA_Model1, union("conflictid", "dyadid"), all = TRUE)

# Check for complete cases
sum(complete.cases(Dataset_Model_1))

# Removing all missing observations in column "outcome_d"
Dataset_Model_1 <- Dataset_Model_1[!is.na(Dataset_Model_1$outcome_d),]

# Removing all missing observations in column "rtypesup"
Dataset_Model_1 <- Dataset_Model_1[!is.na(Dataset_Model_1$rtypesup),]

# Removing all missing observations in column "gtypesup"
Dataset_Model_1 <- Dataset_Model_1[!is.na(Dataset_Model_1$gtypesup),]