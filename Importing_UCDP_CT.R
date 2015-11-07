# Loading the gdata package
library("gdata")

# Downlading UCDP_CT_xls dataset
UCDP_CT_xls = "http://www.pcr.uu.se/digitalAssets/124/124924_1ucdp_conflict_termination_2010_dyad.xls"

# Importing sheet 4 from UCDP_CT_xls datatset into R Studio
UCDP_CT_data = gdata::read.xls(UCDP_CT_xls, sheet = 4)