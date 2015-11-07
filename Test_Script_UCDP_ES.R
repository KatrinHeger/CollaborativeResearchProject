# Loading gdata package
library("gdata")

# Downloading UCDP_ES_xls
UCDP_ES_xls = "http://www.pcr.uu.se/digitalAssets/159/159834_1external_support_compact_dataset_1.00_20110325-1.xls"

# Show sheet count
gdata::sheetCount(UCDP_ES_xls)

# Show names of sheets
gdata::sheetNames(UCDP_ES_xls)

# Importing sheet 1 from UCDP_ES_xls datatset into R Studio
UCDP_ES_data = gdata::read.xls(UCDP_ES_xls, sheet = 1)