###########################
# Descriptive Statistics  #
###########################

# Summary Statistics (List min., 1st qu., median, mean, 3rd qu. and max.)
summary(Dataset_Model_1)

# Histogram of dependent variable Conflict Outcomes

# Histogram of third-party support for rebels

# Histogram of third-party supoprt for government

table(Dataset_Model_1$outcome_d)

table(Dataset_Model_1$fightcaphigh)

table(Dataset_Model_1$outcome_d, Dataset_Model_1$fightcaphigh)

library("Hmisc")

describe(Dataset_Model_1$rebestimate)
