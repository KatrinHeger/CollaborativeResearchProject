# Load dplyr package
library("dplyr")

# View names of all columns in the dataset
head(CIMI_Dataset)

# Check whether duplicated column names contain same values

# Remove duplicated columns land, lngdp, lnyears and postCW
Cleaned_Dataset_1 <- subset(CIMI_Dataset, select = -c(7, 8, 9, 10))

# View new subset to check if columns have been removed
head(Cleaned_Dataset_1)

# Rename conflictid into conflictID as preparation for merging
Cleaned_Dataset_1 <- rename(Cleaned_Dataset_1, conflictID = conflictid)
head(Cleaned_Dataset_1)

# Merging Cleaned_Dataset_1 and UCDP_ES_Dataset
Merged_Dataset_1 <- merge(x = Cleaned_Dataset_1, y = UCDP_ES_Dataset, by = "conflictID", all = TRUE)
head(Merged_Dataset_1)
