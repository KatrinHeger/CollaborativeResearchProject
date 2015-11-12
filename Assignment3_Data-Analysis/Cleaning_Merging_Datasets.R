# Load dplyr package
library("dplyr")
library("testdat")

# Test all datasets for possible unicode characters
testdat::test_utf8(CIMI_Dataset)
testdat::test_utf8(NSA_Dataset)
testdat::test_utf8(UCDP_CT_Dataset)
testdat::test_utf8(UCDP_ES_Dataset)

###########################
# Clean CIMI_Dataset      #
###########################

# View names of all columns in CIMI_Dataset
head(CIMI_Dataset)

# Check whether duplicated column names contain same values

# Remove duplicated columns land, lngdp, lnyears and postCW
Cleaned_CIMI_Dataset <- subset(CIMI_Dataset, select = -c(7, 8, 9, 10))

# View new subset to check if columns have been removed
head(Cleaned_CIMI_Dataset)

# Drop variables that are specific to troop support (intervention, troops2rebs)
Cleaned_CIMI_Dataset <- subset(Cleaned_CIMI_Dataset, select = -c(2, 5))

###########################
# Clean NSA_Dataset       #
###########################

# Drop unnecessary variables (rebpresosts, presname, type.of.termination, victory.side)
Cleaned_NSA_Dataset <- subset(NSA_Dataset, select = -c(30, 31, 39, 40))

# Show variable class of rebel.support
class(NSA_Dataset$rebel.support)

# Show variabls class of gov.support
class(NSA_Dataset$gov.support)

# Load car package
install.packages("car")
library("car")

# Code rebel.support as a dummy with 1=support, 0=no support
Cleaned_NSA_Dataset$rebel.support_dummy <- recode(Cleaned_NSA_Dataset$rebel.support, " 'explicit' = 1;'no' = 0;'alleged' = 0 ")

# Code gov.support as a dummy with 1=support and 0= no support
Cleaned_NSA_Dataset$gov.support_dummy <- recode(Cleaned_NSA_Dataset$gov.support, " 'explicit' = 1;'no' = 0;'alleged' = 0 ")

###########################
# Clean UCDP_ES_Dataset   #
###########################

# Drop interstate conflict variables country2 and locationID2  
Cleaned_UCDP_ES_Dataset <- subset(UCDP_ES_Dataset, select = -c(12, 14))

# Drop external_alleged variable since we only look at actual cases of support
Cleaned_UCDP_ES_Dataset <- subset(Cleaned_UCDP_ES_Dataset, select = -c(16))

# Drop variables irrelevant for our analysis (external_name, external_id, locationid1
Cleaned_UCDP_ES_Dataset <- subset(Cleaned_UCDP_ES_Dataset, select = -c(12, 14, 15))

#######################################################
# Merge Cleaned_CIMI_Dataset and Cleaned_NSA_Dataset  #
#######################################################

# Rename ucdpid into conflictid as preparation for merging in order to have unique identifiers
Cleaned_NSA_Dataset <- rename(Cleaned_NSA_Dataset, conflictid = ucdpid)
head(Cleaned_NSA_Dataset)

# Merge Cleaned_CIMI_Dataset and NSA_Dataset
Merged_CIMI_NSA <- merge(x = Cleaned_CIMI_Dataset, y = Cleaned_NSA_Dataset, by = "conflictid", all = TRUE)
