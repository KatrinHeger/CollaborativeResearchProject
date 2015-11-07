# Loading the gdata package
library("gdata")

# Downlading UCDP_ES_xls dataset
UCDP_ES_xls = "http://www.pcr.uu.se/digitalAssets/159/159834_1external_support_compact_dataset_1.00_20110325-1.xls"

# Importing UCDP_ES_xls dataset
UCDP_ES_data = gdata::read.xls(UCDP_ES_xls, sheet = 1)