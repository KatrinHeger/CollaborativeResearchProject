# Loading the rio and gdata package
library("rio")

# Importing the UCDP_ES dataset from Github repository
# Note:
# Downloading the datatset directly from the website
# will be added later
UCDP_ES <- rio::import("159834_1external_support_compact_dataset_1.00_20110325-1.xls")