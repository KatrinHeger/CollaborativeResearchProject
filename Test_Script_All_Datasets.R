# Cleaning the environment before downloading the datasets
rm(list=ls())

# Loading all necessary packages
library("rio")
library("gdata")

# Loading the CIMI dataset (csv file) from our Github repository
dataset_CIMI <- rio::import("https://raw.githubusercontent.com/KatrinHeger/CollaborativeResearchProject/master/Datasets/CIMI.csv")

# Loading the UCDP External Support dataset
UCDP_ES_xls = "http://www.pcr.uu.se/digitalAssets/159/159834_1external_support_compact_dataset_1.00_20110325-1.xls"

# Loading the UCDP Conflict Termination (dyadic) dataset
UCDP_CT_xls = "http://www.pcr.uu.se/digitalAssets/124/124924_1ucdp_conflict_termination_2010_dyad.xls"