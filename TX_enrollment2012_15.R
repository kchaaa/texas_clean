################################## House Keeping ##################################

# Require libraries
library(plyr)
library(dplyr)
library(tidyr)
library(stringr)

# Scripts
source('scripts/rename.R')

# enroll <- readRDS("NJ_enrollment2010_16.rdata")

# Me: setwd("C:/Users/phato_000/Documents/CRPE/texas_clean")
# CRPE: setwd("/Users/crpe/Documents/Clean/texas_clean")

# Read and Rename Datasets
data_2012 <- read.csv('data/stec12sc.csv', stringsAsFactors=FALSE)
data_2013 <- read.csv('data/stec13sc.csv', stringsAsFactors=FALSE)
data_2014 <- read.csv('data/stec14sc.csv', stringsAsFactors=FALSE)
data_2015 <- read.csv('data/stec15sc.csv', stringsAsFactors=FALSE)

################################## Setup ##################################
data_2012 <- rename_col(data_2012)
data_2013 <- rename_col(data_2013)
data_2014 <- rename_col(data_2014)
data_2015 <- rename_col(data_2015)

# Reorder datasets by region
data_2012 <- arrange(data_2012, campus_name)
data_2013 <- arrange(data_2013, campus_name)
data_2014 <- arrange(data_2014, campus_name)
data_2015 <- arrange(data_2015, campus_name)


################################## Each Year ##################################
# So basically I want to be able to take the grade level AND ethnicity and put that in one col name(s)
# Then I want to be able to take the count of each and put that as the col values

######2012
# Separate by ethnicity
data_2012 <-data_2012 %>% 
  spread(ethnicity, ethnicity_count)

# Rename columns
data_2012 <- rename_col_2(data_2012)

#### This version combines the ethnicity count + ethnicity
data_2012_ver_1 <- data_2012

# add year
data_2012_ver_1$year <- '2012'

######2013
# Separate by ethnicity
data_2013 <-data_2013 %>% 
  spread(ethnicity, ethnicity_count)

# Rename columns
data_2013 <- rename_col_2(data_2013)

#### This version combines the ethnicity count + ethnicity
data_2013_ver_1 <- data_2013

# add year
data_2013_ver_1$year <- '2013'

######2014
# Separate by ethnicity
data_2014 <-data_2014 %>% 
  spread(ethnicity, ethnicity_count)

# Rename columns
data_2014 <- rename_col_2(data_2014)

#### This version combines the ethnicity count + ethnicity
data_2014_ver_1 <- data_2014

# add year
data_2014_ver_1$year <- '2014'

######2015
# Separate by ethnicity
data_2015 <-data_2015 %>% 
  spread(ethnicity, ethnicity_count, na.rm = TRUE)

# Rename columns
data_2015 <- rename_col_2(data_2015)

#### This version combines the ethnicity count + ethnicity
data_2015_ver_1 <- data_2015

# add year
data_2015_ver_1$year <- '2015'

################################## Combine Datasets ##################################
tx_enroll <- rbind.fill(data_2012_ver_1, data_2013_ver_1)
tx_enroll <- rbind.fill(tx_enroll, data_2014_ver_1)
tx_enroll <- rbind.fill(tx_enroll, data_2015_ver_1)

######## Check later
#### do one for each ethnicity and then combine them all together
#### This version w/ grade level 

### am_indian
am_indian_12 <- data_2012 %>% 
                  spread(grade, am_indian)
am_indian_12 <- rename_col_3('am_indian', am_indian_12)
am_indian_12[8:13] <- NULL

### asian
asian_12 <- data_2012 %>% 
                  spread(grade, asian)
asian_12 <- rename_col_3('asian', asian_12)
asian_12[8:13] <- NULL

### black
black_12 <- data_2012 %>% 
                  spread(grade, black)
black_12 <- rename_col_3('black', black_12)
black_12[8:13] <- NULL

### hisp
hisp_12 <- data_2012 %>% 
                  spread(grade, hisp)
hisp_12 <- rename_col_3('hisp', hisp_12)
hisp_12[8:13] <- NULL

### pacif_islan
pacif_islan_12 <- data_2012 %>% 
                  spread(grade, pacif_islan)
pacif_islan_12 <- rename_col_3('pacif_islan', pacif_islan_12)
pacif_islan_12[8:13] <- NULL

### two_or_more
two_or_more_12 <- data_2012 %>% 
                  spread(grade, two_or_more)
two_or_more_12 <- rename_col_3('two_or_more', two_or_more_12)
two_or_more_12[8:13] <- NULL

### white
white_12 <- data_2012 %>% 
                  spread(grade, white)
white_12 <- rename_col_3('white', white_12)
white_12[8:13] <- NULL

## combines datasets
data_2012_ver_2 <- right_join(am_indian_12, asian_12, by = c)




################################## Finish Up ##################################

# Write to .csv files

# tx_enroll_2012_15 <- write.csv(tx_enroll)
# data_2012 <- write.csv(data_2012)
# data_2013 <- write.csv(data_2013)
# data_2014 <- write.csv(data_2014)
# data_2015 <- write.csv(data_2015)