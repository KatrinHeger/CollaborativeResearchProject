# Loading the necessary packages
library("rio")
library("gdata")

# Importing the CIMI_Dataset
CIMI_Dataset <- rio::import("https://raw.githubusercontent.com/KatrinHeger/CollaborativeResearchProject/master/Datasets/CIMI.csv")

# Importing the UCDP_ES_Dataset
UCDP_ES_Dataset <- rio::import("~/GitHub/CollaborativeResearchProject/Datasets/UCDP_ExternalSupportDataset.xls")

# Importing the UCDP_CT_Dataset
UCDP_CT_xls = "http://www.pcr.uu.se/digitalAssets/124/124924_1ucdp_conflict_termination_2010_dyad.xls"
UCDP_CT_Dataset = gdata::read.xls(UCDP_CT_xls, sheet = 4)

# Importing the NSA_Dataset
NSA_Dataset <- rio:: import("http://privatewww.essex.ac.uk/~ksg/data/nsa_v3.4_21November2013.asc", format = "tsv")