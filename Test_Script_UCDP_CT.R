library("gdata")
UCDP_CT_xls = "http://www.pcr.uu.se/digitalAssets/124/124924_1ucdp_conflict_termination_2010_dyad.xls"
gdata::sheetCount(UCDP_CT_xls)
gdata::sheetNames(UCDP_ES_xls)
View(UCDP_ES_xls)