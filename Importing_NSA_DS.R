# Loading the rio package
library("rio")

# Downloading and importing the NSA_DS
dyads <- rio:: import("http://privatewww.essex.ac.uk/~ksg/data/nsa_v3.4_21November2013.asc", format = "tsv")