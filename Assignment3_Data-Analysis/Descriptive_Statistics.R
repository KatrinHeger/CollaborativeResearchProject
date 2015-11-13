###########################
# Descriptive Statistics  #
###########################

# Loading Hmisc package
library("Hmisc")

# Describing the whole data frame
dim(Model_1_Dataset) # Our dataset currently entails 497 rows and 26 columns/variables

##################################
# Conflict Outcomes              #
##################################

# Displaying the distribution of all conflict outcomes ("outcome_d"),
# including the percentage distribution (last line out print).
# Coding of "outcome_d":
# 0: low activity
# 1: rebel victory
# 2: settlement
# 3: government victory
describe(Model_1_Dataset$outcome_d)

# Create histogram of conflict outcomes ("outcome_d")
# Note:
# Unfortunately we still can't create the histogram when the code is not on one single line.
# Therefore, all following histograms will be written in one line.
# See https://github.com/HertieDataScience/SyllabusAndLectures/issues/36
hist(Model_1_Dataset$outcome_d, main = "Frequency of Conflict Outcomes", xlab = "Conflict Outcomes", las = 1, breaks = seq(min(-.5),max(3.5),1), col = "lightgreen")

##################################
# Types of Government Support    #
##################################

# Displaying the distribution of all types of government support ("gtypesup_cat"),
# including the percentage distribution (last line out print).
# Coding of "gtypesup_cat":
# 1: troops
# 2: military
# 3: non-military
describe(Model_1_Dataset$gtypesup_cat)

# Histogram of third-party support types for government
hist(Model_1_Dataset$gtypesup_cat, main = "Frequency of Government Support Types", xlab = "Government Support Types", las = 1, breaks = seq(min(-.5),max(3.5),1), col = "lightblue")

##################################
# Types of Rebel Support         #
##################################

# Displaying the distribution of all types of rebel support ("rtypesup_cat"),
# including the percentage distribution (last line out print).
# Coding of "rtypesup_cat":
# 1: troops
# 2: military
# 3: non-military
describe(Model_1_Dataset$rtypesup_cat)

# !!! Histogram not working !!!
# Histogram of third-party support types for rebels
hist(Model_1_Dataset$rtypesup_cat, main = "Frequency of Rebel Support Types", xlab = "Rebel Support Types", las = 1, breaks = seq(min(-.5),max(3.5),1), col = "lightblue")