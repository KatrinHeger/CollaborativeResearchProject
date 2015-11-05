##################################################################
# MPP-E1180: Intro. to Collab. Social Science Data Analyis       #
# November 2015                                                  #
# Collaborative Research Project                                 #
# Katrin Heger & Benedikt Abendroth                              #
# For more information please read the README file               #
##################################################################

# Setting the working directory (Benedikt in this case)
setwd("/Users/Benedikt/GitHub/CollaborativeResearchProject/")

# In order to pursue our analysis, the follogwing packages are necessary:
# (1) rio
# ??? additional packages here
# Information about the packages being used in this project
# can be found in our BibTeX file
# If users would like to check which packages are already
# installed, use the following code: "installed.packages()"

# Starting the rio package
library("rio")

# Loading the data (csv file) from our Github repository
# using the repmis package
# SHA-1 hash of the downloaded data file is:
# aec313662cd7e1e5fa8b205c5c1180d542cee91a
library("rio")
dataset1 <- rio::import("https://raw.githubusercontent.com/KatrinHeger/CollaborativeResearchProject/master/Datasets/CIMI.csv")
View(dataset1)

