##################################################################
# MPP-E1180: Intro. to Collab. Social Science Data Analyis       #
# November 2015                                                  #
# Collaborative Research Project                                 #
# Katrin Heger & Benedikt Abendroth                              #
# For more information please read the README file               #
##################################################################

# Cleaning the environment in R Studio
rm(list=ls())

# Setting the working directory
# getwd()
# setwd(add at end) !!!
# # Create list of commonly used working directories
# possible_dir <- c('/git_repos/Assignment1', 'C:\class\Assignment1')
# Set to first valid directory in the possible_dir vector
# repmis::set_valid_wd(possible_dir)

# In order to pursue our analysis, the follogwing packages are necessary:
# (1) rio
# (2) gdata
# (3) mlogit
# (4) car
# ??? additional packages here
# Information about the packages being used in this project
# can be found in our BibTeX file.
# If users would like to check which packages are already
# installed, use the following code: "installed.packages()"

# Starting the rio package
library("rio")
library("gdata")
library("mlogit")

# Loading the CIMI_Dataset from our Github repository
# Note:
# The only package (as fas as we know) that can directly access the
# API of the Harvard Dataverse Network is a package called "DVN".
# Unfortunately, it hasn't been updated yet to work with the current
# Harvard Dataverse version 4.0. Hence, we had to download it by hand.
# Source of issue of DVN package: https://github.com/ropensci/dvn/issues/23
# The file was retrieved on November 1, 2015 from
# https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/BTKZEQ
# SHA-1 hash:
# aec313662cd7e1e5fa8b205c5c1180d542cee91a
CIMI_Dataset <- rio::import("https://raw.githubusercontent.com/KatrinHeger/CollaborativeResearchProject/master/Datasets/CIMI.csv")

# Importing the UCDP_ES_Dataset
# Note:
# Unfortunately we haven't been able yet to directly access this file from
# the website of UCDP directly, due to the error "Unknown format" when downloading
# it in R Studio. While we are trying to resolve this issue, we are using the file
# in our public Github repository.
# The file has been retrieved on November 1, 2015, from
# http://www.pcr.uu.se/digitalAssets/159/159834_1external_support_compact_dataset_1.00_20110325-1.xls
# # SHA-1 hash:
# f2b08a7805eb5d1a3f112486640e60a3add67045
UCDP_ES_Dataset <- rio::import("~/GitHub/CollaborativeResearchProject/Datasets/UCDP_ExternalSupportDataset.xls")

# Importing the UCDP_CT_Dataset
UCDP_CT_xls = "http://www.pcr.uu.se/digitalAssets/124/124924_1ucdp_conflict_termination_2010_dyad.xls"
UCDP_CT_Dataset = gdata::read.xls(UCDP_CT_xls, sheet = 4)

# Note on UCDP datasets: 
# There is an R package called "UCDPtools" (https://github.com/tlscherer/UCDPtools),
# which is supposed to directly import datasets from UCDP into R Studio. Unfortunately,
# the current version of R Studio (3.2.2) is not supported. As we think that this tool
# might be very helpful for other researchers as well, the author has been contacted.

# Importing the NSA_Dataset
NSA_Dataset <- rio::import("http://privatewww.essex.ac.uk/~ksg/data/nsa_v3.4_21November2013.asc", format = "tsv")
