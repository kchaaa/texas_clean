################################## House Keeping ##################################

# Require libraries
library(plyr)
library(dplyr)
library(tidyr)
library(stringr)

# Scripts
# source('scripts/rename.R')

enroll <- readRDS("NJ_enrollment2010_16.rdata")
enroll <- readRDS("TXPerformance.Rdata")

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

### Functions from rename.R
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

################################## Aggregate ##################################

### Functions
combine_grade <- function(df) {
  df <- df %>% 
    ddply(c("region", "county_name", "district_name", "campus_name", "campus_number"), 
          summarise,
          am_indian = sum(am_indian, na.rm = TRUE),
          asian = sum(asian, na.rm = TRUE),
          black = sum(black, na.rm = TRUE),
          hisp = sum(hisp, na.rm = TRUE),
          pacif_islan = sum(pacif_islan, na.rm = TRUE),
          two_or_more = sum(two_or_more, na.rm = TRUE),
          white = sum(white, na.rm = TRUE))
}

######2012
# Separate by ethnicity
data_2012 <-data_2012 %>% 
  spread(ethnicity, ethnicity_count)

# Rename columns
data_2012 <- rename_col_2(data_2012)

# Cleans up the data (-9999999 => 0)
data_2012[data_2012 == -9999999] <- 0

# Combines the grade levels together
data_2012 <- data_2012 %>% 
              ddply(c("region", "county_name", "district_name", "campus_number"), 
               summarise,
               am_indian = sum(am_indian, na.rm = TRUE),
               asian = sum(asian, na.rm = TRUE),
               black = sum(black, na.rm = TRUE),
               hisp = sum(hisp, na.rm = TRUE),
               pacif_islan = sum(pacif_islan, na.rm = TRUE),
               two_or_more = sum(two_or_more, na.rm = TRUE),
               white = sum(white, na.rm = TRUE))

# Add year
data_2012$year <- '2012'
# Puts year as the first column
data_2012 <- data_2012[, c('year', setdiff(names(data_2012), 'year'))]

#####2013
# Separate by ethnicity
data_2013 <-data_2013 %>% 
  spread(ethnicity, ethnicity_count)

# Rename columns
data_2013 <- rename_col_2(data_2013)

# Cleans up the data (-9999999 => 0)
data_2013[data_2013 == -9999999] <- 0

# Combines the grade levels together
data_2013 <- data_2013 %>% 
  ddply(c("region", "county_name", "district_name", "campus_number"), 
        summarise,
        am_indian = sum(am_indian, na.rm = TRUE),
        asian = sum(asian, na.rm = TRUE),
        black = sum(black, na.rm = TRUE),
        hisp = sum(hisp, na.rm = TRUE),
        pacif_islan = sum(pacif_islan, na.rm = TRUE),
        two_or_more = sum(two_or_more, na.rm = TRUE),
        white = sum(white, na.rm = TRUE))

# Add year
data_2013$year <- '2013'
# Puts year as the first column
data_2013 <- data_2013[, c('year', setdiff(names(data_2013), 'year'))]


######2014
# Separate by ethnicity
data_2014 <-data_2014 %>% 
  spread(ethnicity, ethnicity_count)

# Rename columns
data_2014 <- rename_col_2(data_2014)

# Cleans up the data (-9999999 => 0)
data_2014[data_2014 == -9999999] <- 0

# Combines the grade levels together
data_2014 <- data_2014 %>% 
  ddply(c("region", "county_name", "district_name", "campus_number"), 
        summarise,
        am_indian = sum(am_indian, na.rm = TRUE),
        asian = sum(asian, na.rm = TRUE),
        black = sum(black, na.rm = TRUE),
        hisp = sum(hisp, na.rm = TRUE),
        pacif_islan = sum(pacif_islan, na.rm = TRUE),
        two_or_more = sum(two_or_more, na.rm = TRUE),
        white = sum(white, na.rm = TRUE))

# Add year
data_2014$year <- '2014'
# Puts year as the first column
data_2014 <- data_2014[, c('year', setdiff(names(data_2014), 'year'))]

######2015
# Separate by ethnicity
data_2015 <-data_2015 %>% 
  spread(ethnicity, ethnicity_count)

# Rename columns
data_2015 <- rename_col_2(data_2015)

# Cleans up the data (-9999999 => 0)
data_2015[data_2015 == -9999999] <- 0

# Combines the grade levels together
data_2015 <- data_2015 %>% 
  ddply(c("region", "county_name", "district_name", "campus_number"), 
        summarise,
        am_indian = sum(am_indian, na.rm = TRUE),
        asian = sum(asian, na.rm = TRUE),
        black = sum(black, na.rm = TRUE),
        hisp = sum(hisp, na.rm = TRUE),
        pacif_islan = sum(pacif_islan, na.rm = TRUE),
        two_or_more = sum(two_or_more, na.rm = TRUE),
        white = sum(white, na.rm = TRUE))

# Add year
data_2015$year <- '2015'
# Puts year as the first column
data_2015 <- data_2015[, c('year', setdiff(names(data_2015), 'year'))]

################################## Combine Datasets ##################################
tx_enroll <- rbind.fill(data_2012, data_2013)
tx_enroll <- rbind.fill(tx_enroll, data_2014)
tx_enroll <- rbind.fill(tx_enroll, data_2015)

tx_enroll <- arrange(tx_enroll, campus_number)

################################## Finish Up ##################################

# Write to .csv files
write.csv(tx_enroll, file = "data/TX_enroll.csv")

# Save as .RData file
save.image(file="TXPerformance.Rdata")

