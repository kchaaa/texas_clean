################################## House Keeping ##################################

# Require libraries
library(dplyr)
library(tidyr)
library(stringr)
library(plyr)

# Read in scripts


# Me: setwd("/Users/phat_000/Documents/CRPE/texas_clean)
# CRPE: setwd("/Users/crpe/Documents/Clean/texas_clean")

# Read and Rename Datasets
data_2012 <- read.csv('data/stec12sc.csv', stringsAsFactors=FALSE)
data_2013 <- read.csv('data/stec13sc.csv', stringsAsFactors=FALSE)
data_2014 <- read.csv('data/stec14sc.csv', stringsAsFactors=FALSE)
data_2015 <- read.csv('data/stec15sc.csv', stringsAsFactors=FALSE)

################################## Setup ##################################

# Function: Rename Column names 
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

data_2012 <- rename_col(data_2012)
data_2013 <- rename_col(data_2013)
data_2014 <- rename_col(data_2014)
data_2015 <- rename_col(data_2015)

# Reorder datasets by region
data_2012 <- arrange(data_2012, campus_name)
data_2013 <- arrange(data_2013, campus_name)
data_2014 <- arrange(data_2014, campus_name)
data_2015 <- arrange(data_2015, campus_name)


################################## Change ##################################
# Pseudo code (kindof)
# So basically I want to be able to take the grade level AND ethnicity and put that in one col name(s)
# Then I want to be able to take the count of each and put that as the col values

# Change col names after separate by ethnicity
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

######2012
# Store for checking later
check_data_2012 <- data_2012

# Separate by ethnicity
data_2012 <-data_2012 %>% 
  spread(ethnicity, ethnicity_count)

# Rename columns
data_2012 <- rename_col_2(data_2012)

#DELETE LATER
check_data_2012_2 <- data_2012

# do one for each ethnicity and then combine them all together

# use summarise or gather fool
am_indian_12 <- data_2012 %>% 
                  spread(grade, am_indian)
# renames column names
am_indian_12 <- rename_col_3('am_indian', am_indian_12)

# deletes unnecessary columns
am_indian_12[8:13] <- NULL


################################## Finish Up ##################################

# Write to .csv files

#combined <- write.csv(data)
#data_2012 <- write.csv(data_2012)
#data_2013 <- write.csv(data_2013)
#data_2014 <- write.csv(data_2014)
#data_2015 <- write.csv(data_2015)