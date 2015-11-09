# Loading the rio and gdata package
library("rio")

# Importing the UCDP_ES dataset from Github repository
# Note:
# Downloading the datatset directly from the website will be added later
UCDP_ES <- rio::import("~/GitHub/CollaborativeResearchProject/Datasets/UCDP_ExternalSupportDataset.xls")