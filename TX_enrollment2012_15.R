################################## Setup ##################################

# Require libraries
library(dplyr)
library(tidyr)
library(stringr)

# Read in scripts
source('compare_datasets.r') # Finds Similarities between two datasets

# Read and Rename Datasets
data_2012 <- read.csv('data/stec12sc.csv', stringsAsFactors=FALSE)
data_2013 <- read.csv('data/stec13sc.csv', stringsAsFactors=FALSE)
data_2014 <- read.csv('data/stec14sc.csv', stringsAsFactors=FALSE)
data_2015 <- read.csv('data/stec15sc.csv', stringsAsFactors=FALSE)

################################## Reorganize Datasets ##################################

# Rename Column names
rename_col <- function(df){
  colnames(df)[1] <- 'region'
  colnames(df)[2] <- 'county_name'
  colnames(df)[3] <- 'district_name'
  colnames(df)[4] <- 'district_number'
  colnames(df)[5] <- 'campus_name'
  colnames(df)[6] <- 'campus_number'
  colnames(df)[7] <- 'total'
  colnames(df)[8] <- 'grade_level'
  colnames(df)[9] <- 'ethnicity'
  colnames(df)[10] <- 'ethnicity_count'
  
  return(df)
}

data_2012 <- rename_col(data_2012)
data_2013 <- rename_col(data_2013)
data_2014 <- rename_col(data_2014)
data_2015 <- rename_col(data_2015)

# Reorder datasets by region
data_2012 <- arrange(data_2012, region)
data_2013 <- arrange(data_2013, region)
data_2014 <- arrange(data_2014, region)
data_2015 <- arrange(data_2015, region)

# Add year
data_2012$year <- '2012'
data_2013$year <- '2013'
data_2014$year <- '2014'
data_2015$year <- '2015'

# Find differences
data_2012_13 <- semi_join(data_2012, data_2013, by = "campus_name")
data_2012_13 <- arrange(data_2012_13, year)


################################## Combine Datasets ##################################

# Create a Separate Dataset
# data <- left_join (data_2012, data_2013, "")

#> nrow(data_2012)
#[1] 329952
#> nrow(data_2013)
#[1] 331170
#> nrow(data_2014)
#[1] 332311
#> nrow(data_2015)
#[1] 334782

################################## Finish Up ##################################

# Write to .csv files

#enroll <- write.csv(data)
#data_2012 <- write.csv(data_2012)
#data_2013 <- write.csv(data_2013)
#data_2014 <- write.csv(data_2014)
#data_2015 <- write.csv(data_2015)