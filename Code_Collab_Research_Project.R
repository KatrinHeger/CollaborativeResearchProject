##################################################################
# MPP-E1180: Intro. to Collab. Social Science Data Analyis       #
# November 2015                                                  #
# Collaborative Research Project                                 #
# Katrin Heger & Benedikt Abendroth                              #
# For more information please read the README file               #
##################################################################

# Setting the working directory
# Include code here at the end (probably from the repmis package
# and the slides from Lecture 6, 9 October 2015)

# In order to pursue our analysis, the follogwing packages are necessary:
# (1) rio
# ??? additional packages here
# Information about the packages being used in this project
# can be found in our BibTeX file
# If users would like to check which packages are already
# installed, use the following code: "installed.packages()"

# Starting the rio package
library("rio")

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