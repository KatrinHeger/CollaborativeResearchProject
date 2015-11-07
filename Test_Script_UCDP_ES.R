library("gdata")
UCDP_ES_xls = "http://www.pcr.uu.se/digitalAssets/159/159834_1external_support_compact_dataset_1.00_20110325-1.xls"
gdata::sheetCount(UCDP_ES_xls)
gdata::sheetNames(UCDP_ES_xls)