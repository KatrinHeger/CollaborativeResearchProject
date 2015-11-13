###########################
# Descriptive Statistics  #
###########################

# Load Hmisc and ggplot2 packages
library("Hmisc")
library("ggplot2")

# Describe the whole data frame
dim(Dataset_1) # Our dataset currently entails 497 rows and 23 columns/variables

##################################
# Conflict Outcomes              #
##################################

# Show the distribution of all conflict outcomes ("outcome_d"),
# including the percentage distribution (last line out print).
# Coding of "outcome_d":
# 0: low activity
# 1: rebel victory
# 2: settlement
# 3: government victory
describe(Dataset_1$conflict_outcome)

# Create histogram of conflict outcomes ("outcome_d")
# Note:
# Unfortunately we still can't create the histogram when the code is not on one single line.
# Therefore, all following histograms will be written in one line.
# See https://github.com/HertieDataScience/SyllabusAndLectures/issues/36
qplot(Dataset_1$conflict_outcome, geom = "histogram", binwidth = .5, main = "Frequency of Rebel Support Types", xlab = "Support Types", ylab = "Frequency", fill = I("lightblue"))

##################################
# Types of Government Support    #
##################################

# Display the distribution of all types of government support ("gtypesup_cat"),
# including the percentage distribution (last line out print).
# Coding of "gtypesup_cat":
# 1: troops
# 2: military
# 3: non-military
describe(Dataset_1$gtypesup_cat)

# Remove missing values at "gtypesup_cat"
Dataset_1_gtype_HG <- Dataset_1[!is.na(Dataset_1$gtypesup_cat),]

# Histogram of third-party support types for government
qplot(Dataset_1_gtype_HG$gtypesup_cat, geom = "histogram", binwidth = .5, main = "Frequency of Government Support Types", xlab = "Support Types", ylab = "Frequency", fill = I("lightgreen"))

##################################
# Types of Rebel Support         #
##################################

# Show the distribution of all types of rebel support ("rtypesup_cat"),
# including the percentage distribution (last line out print).
# Coding of "rtypesup_cat":
# 1: troops
# 2: military
# 3: non-military
describe(Dataset_1$rtypesup_cat)

# Remove missing values at "rtypesup_cat"
Dataset_1_rtype_HG <- Dataset_1[!is.na(Dataset_1$gtypesup_cat),]

# Histogram of third-party support types for rebels
qplot(Dataset_1_rtype_HG$rtypesup_cat, geom = "histogram", binwidth = .5, main = "Frequency of Rebel Support Types", xlab = "Support Types", ylab = "Frequency", alpha = I(.9), fill = I("brown"))