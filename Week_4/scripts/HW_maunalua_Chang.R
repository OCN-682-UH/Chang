## Homework: Remove all the NAs
## Separate the Tide_time column into appropriate columns for analysis
## Filter out a subset of data (your choice)
## Use either pivot_longer() or pivot_wider() at least once
## Calculate some summary statistics (can be anything) and export the csv file into the output folder
## Make any kind of plot (it cannot be a boxplot) and export it into the output folder
## Make sure you comment your code and your data, outputs, and script are in the appropriate folders

### Created by Jasmine Chang ###
### Created on 2026-09-21 ###
### Last edited on 2026-09-22 ###

### Load Libraries ###
library(tidyverse)
library(here)

### Load data ###
ChemData <- read_csv(here("Week_4", "data", "chemicaldata_maunalua.csv"))
glimpse(ChemData)

### Cleaning up data ###

ChemData_clean <- ChemData |>
  drop_na() |>
  separate_wider_delim(cols  = Tide_time,
                       delim = "_",
                       names = c("Tide", "Time"), # separating time and tide
                       cols_remove = FALSE)

ChemData_long <- ChemData_clean |> # assign it to chemdata_clean data frame
  pivot_longer(cols      = Temp_in:percent_sgd, # select columns to pivot
               names_to  = "Variables",         # new column for old column names
               values_to = "Values")            # new column for the values

### Filter data ###

filter(.data = ChemData_clean,pH>8) # data=the data frame, followed by any conditions
high_pH <- filter(ChemData_clean, pH>8) # creating a dataset that you can save and return to

### Summary Statistics ###
## min and max of Tide (even though its high/low)
## Range of tide

ChemData_long |>
  group_by(Variables, Tide) |> 
  summarise(Param_means = min(Values, na.rm = TRUE),
            Param_vars  = max(Values,  na.rm = TRUE))

ChemData_long |>
  group_by(Variables, Tide) |> 
  summarise(Param_means = range(Values, na.rm = TRUE),
            Param_vars  = range(Values,  na.rm = TRUE))

### ggplot ###

high_pH |>
  ggplot(aes(x = Season, y = pH,
             fill = Site,
             color=Site)) +
  geom_jitter(width = 0.2) + # looking at the high pH throughout the seasons
  labs(title= "High pH in Fall vs Spring")+
  theme_minimal()


## saving plot ##

ggsave(here("Week_4","output","HW_chang_9_22.png"),
       width=7, height=5)
