### Renaming functions for TX_enrollment2012_15.R

# Require libraries
library(plyr)
library(dplyr)
library(tidyr)
library(stringr)

# Function: Rename Column names for SETUP
rename_col <- function(df){
  colnames(df)[1] <- 'region'
  colnames(df)[2] <- 'county_name'
  colnames(df)[3] <- 'district_name'
  colnames(df)[4] <- 'district_number'
  colnames(df)[5] <- 'campus_name'
  colnames(df)[6] <- 'campus_number'
  colnames(df)[7] <- 'total'
  colnames(df)[8] <- 'grade'
  colnames(df)[9] <- 'ethnicity'
  colnames(df)[10] <-'ethnicity_count'
  
  return(df)
}

# Function: Change col names after separate by ethnicity
rename_col_2 <- function (df) {
  colnames(df)[9] <- 'am_indian' 
  colnames(df)[10] <- 'asian'
  colnames(df)[11] <- 'black'
  colnames(df)[12] <- 'hisp'
  colnames(df)[13] <- 'pacif_islan'
  colnames(df)[14] <- 'two_or_more'
  colnames(df)[15] <- 'white'
  
  return(df)
}

# Function (Optional): Change col names if seaparated individually by ethnicity
rename_col_3 <- function (ethn_name, df) {
  colnames(df)[14] <- paste(ethn_name, 'early', sep = "_")
  colnames(df)[15] <- paste(ethn_name, '1', sep = "_")
  colnames(df)[16] <- paste(ethn_name, '2', sep = "_")
  colnames(df)[17] <- paste(ethn_name, '3', sep = "_")
  colnames(df)[18] <- paste(ethn_name, '4', sep = "_")
  colnames(df)[19] <- paste(ethn_name, '5', sep = "_")
  colnames(df)[20] <- paste(ethn_name, '6', sep = "_")
  colnames(df)[21] <- paste(ethn_name, '7', sep = "_")
  colnames(df)[22] <- paste(ethn_name, '8', sep = "_")
  colnames(df)[23] <- paste(ethn_name, '9', sep = "_")
  colnames(df)[24] <- paste(ethn_name, '10', sep = "_")
  colnames(df)[25] <- paste(ethn_name, '11', sep = "_")
  colnames(df)[26] <- paste(ethn_name, '12', sep = "_")
  colnames(df)[27] <- paste(ethn_name, 'prek', sep = "_")
  colnames(df)[28] <- paste(ethn_name, 'k', sep = "_")
  
  return(df)
}