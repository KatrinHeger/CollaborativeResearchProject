# Loading gdata package
library("gdata")

# Downloading UCDP_ES_xls
UCDP_CT_xls = "http://www.pcr.uu.se/digitalAssets/124/124924_1ucdp_conflict_termination_2010_dyad.xls"

# Show sheet count
gdata::sheetCount(UCDP_CT_xls)

# Show names of sheets
gdata::sheetNames(UCDP_CT_xls)

# Importing sheet 1 from UCDP_ES_xls datatset into R Studio
UCDP_ES_data = gdata::read.xls(UCDP_CT_xls, sheet = 1)