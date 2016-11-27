################################################################################
# file    : R/script.R
# author  : Xavier Laviron
# object  : Analysis for bibliographic review
################################################################################


# --- LOAD DATA FILES

rg_general  <- read.csv("datas/reading_general.csv", stringsAsFactors = FALSE)
rg_protocol <- read.csv("datas/reading_protocol.csv", stringsAsFactors = FALSE)
rg_crops    <- read.csv("datas/reading_crop.csv", stringsAsFactors = FALSE)
rg_weeds    <- read.csv("datas/reading_weeds.csv", stringsAsFactors = FALSE)
rg_results  <- read.csv("datas/reading_results.csv", stringsAsFactors = FALSE)
