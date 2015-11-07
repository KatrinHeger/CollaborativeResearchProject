##################################################################
# MPP-E1180: Intro. to Collab. Social Science Data Analyis       #
# November 2015                                                  #
# Collaborative Research Project                                 #
# Katrin Heger & Benedikt Abendroth                              #
# For more information please read the README file               #
##################################################################

# The first thing we do is to make sure that our workspace in R Studio
# is clean and we delete data and values that might be left in our
# environment.
rm(list=ls())

# Setting the working directory
# getwd()
# setwd("<location of your dataset>")

# In order to pursue our analysis, the follogwing packages are necessary:
# (1) rio
# (2) gdata
# ??? additional packages here
# Information about the packages being used in this project
# can be found in our BibTeX file
# If users would like to check which packages are already
# installed, use the following code: "installed.packages()"

# Loading all necessary packages
library("rio")
library("gdata")

# Loading the CIMI dataset (csv file) from our Github repository
# SHA-1 hash of the downloaded data file is:
# aec313662cd7e1e5fa8b205c5c1180d542cee91a
# The file was retrieved from
# https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/BTKZEQ
# on November 1, 2015.
dataset_CIMI <- rio::import("https://raw.githubusercontent.com/KatrinHeger/CollaborativeResearchProject/master/Datasets/CIMI.csv")
View(dataset_CIMI)

# Note on the CIMI dataset: It was not possible so far to retrieve the necessary
# fileid in order to find out if the dataset we would like to use can be downloaded
# with a package called "DVN" (https://cran.r-project.org/web/packages/dvn/index.html)
# Therefore, the authors of the dataset have been contacted on November 7, 2015.
# We would like to keep the option of directly accessing the dataset directly
# from Dataverse into R Studio at a later point.

# Loading our first dataset from UCDP (External Support)
# Note: There is an R package called "UCDPtools" (https://github.com/tlscherer/UCDPtools),
# which is supposed to directly import datasets from UCDP into R Studio. Unfortunately,
# the current version of R Studio (3.2.2) is not supported. As we think that this tool
# might be very helpful for other researchers as well, the author has been contacted.

