##################################################################
# MPP-E1180: Intro. to Collab. Social Science Data Analyis       #
# November 2015                                                  #
# Collaborative Research Project                                 #
# Katrin Heger & Benedikt Abendroth                              #
# For more information please read the README file               #
##################################################################

# Insert code here to set working directory

# In order to pursue our analysis, two packages are necessary:
# (1) devtools (to easily install the "repmis" package)
# (2) repmis
# Information about the packages being used in this project
# can be found in our Citations
# If users would like to check which packages are already
# installed, please use the following code: "installed.packages()"

# Starting the repmis package
library(repmis)

# Loading the data (csv file) from our Github repository
# using the repmis package
# SHA-1 hash of the downloaded data file is:
# aec313662cd7e1e5fa8b205c5c1180d542cee91a
URL <- paste0('https://raw.githubusercontent.com/KatrinHeger/','CollaborativeResearchProject/master/Datasets/CIMI.csv')
main <- repmis::source_data(URL)