# Loading the rio package
library("rio")

# Loading and importing the CIMI dataset (csv file) from our Github repository
CIMI <- rio::import("https://raw.githubusercontent.com/KatrinHeger/CollaborativeResearchProject/master/Datasets/CIMI.csv")