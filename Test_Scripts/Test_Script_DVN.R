# Loading the DVN package
library("dvn")

# Setting up the account at Harvard Dataverse
options(dvn = 'https://thedata.harvard.edu/dvn/')
options(dvn.user = "vanderroth")
options(dvn.pwd = "Copenhagen87")

# Retrieving information if our requested file can be downloaded with this API
dvDownloadInfo(fileid, dv = getOption('dvn'), browser = FALSE)

# It was not possible so far to retrieve the necessary fileid in order to find
# out if the dataset we would like to use can be downloaded with the DVN API.
# Therefore, the authors of the dataset have been contacted on November 7, 2015.
# We would like to keep the option of directly accessing the dataset directly
# from Dataverse into R Studio.