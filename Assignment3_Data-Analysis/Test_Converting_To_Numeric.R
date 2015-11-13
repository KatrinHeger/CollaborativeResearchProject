Model_1_Dataset_test <- Model_1_Dataset[!(Model_1_Dataset$rtypesup_cat=="endorsement; alleged military"),]



Model_1_Dataset <- Model_1_Dataset[!is.na(Model_1_Dataset$rtypesup_cat),]



is.character(Model_1_Dataset$rtypesup_cat)

as.numeric(Model_1_Dataset$rtypesup_cat)

is.numeric(Model_1_Dataset$rtypesup_cat)





# Histogram of third-party support types for rebels
hist(Model_1_Dataset$rtypesup_cat, main = "Frequency of Rebel Support Types", xlab = "Rebel Support Types", las = 1, breaks = seq(min(-.5),max(3.5),1), col = "lightblue")
