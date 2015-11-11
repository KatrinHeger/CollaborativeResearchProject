rm(list=ls())
CIMI_Dataset <- rio::import("https://raw.githubusercontent.com/KatrinHeger/CollaborativeResearchProject/master/Datasets/CIMI.csv")
UCDP_ES_Dataset <- rio::import("~/GitHub/CollaborativeResearchProject/Datasets/UCDP_ExternalSupportDataset.xls")
UCDP_CT_xls = "http://www.pcr.uu.se/digitalAssets/124/124924_1ucdp_conflict_termination_2010_dyad.xls"
UCDP_CT_Dataset = gdata::read.xls(UCDP_CT_xls, sheet = 4)
NSA_Dataset <- rio::import("http://privatewww.essex.ac.uk/~ksg/data/nsa_v3.4_21November2013.asc", format = "tsv")
