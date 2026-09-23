## Homework: Remove all the NAs
## Separate the Tide_time column into appropriate columns for analysis
## Filter out a subset of data (your choice)
## Use either pivot_longer() or pivot_wider() at least once
## Calculate some summary statistics (can be anything) and export the csv file into the output folder
## Make any kind of plot (it cannot be a boxplot) and export it into the output folder
## Make sure you comment your code and your data, outputs, and script are in the appropriate folders

### Created by Jasmine Chang ###
### Created on 2026-09-21 ###
### Last edited on 2026-09-21 ###

### Load Libraries ###
library(tidyverse)
library(here)

### Load data ###
ChemData <- read_csv(here("Week_4", "data", "chemicaldata_maunalua.csv"))
glimpse(ChemData)

### Cleaning up data ###
ChemData_clean <- ChemData |>
  filter(complete.cases(ChemData)) # filters out everything that is not a complete row

