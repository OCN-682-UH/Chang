### Today we are going to practice tidyr with biogeochemistry data from Hawaii ###
### Created by: Jasmine Chang ###
### Created on: 2026-09-21 ###
### Last edited: 2026-09-21 ###

### Load Libraries ###
library(tidyverse)
library(here)
library(cowsay)

#fun
say("horsegirl808", by = "yoda")

### Load data ###
ChemData <- read_csv(here("Week_4", "data", "chemicaldata_maunalua.csv"))
glimpse(ChemData)

### Cleaning up data ###
ChemData_clean <- ChemData |>
  filter(complete.cases(ChemData)) # filters out everything that is not a complete row

ChemData_clean <- ChemData |>
  drop_na() |>
  separate_wider_delim(cols  = Tide_time,
                       delim = "_",
                       names = c("Tide", "Time"),
                       cols_remove = FALSE)|>
  mutate(Site_Zone = paste(Site, Zone, sep = ".")) ## Combining columns with "paste", separated by a "."

## wide and long data ##
## wide data: one observation per row
## long data: one unique measurement type per row
## the data that I am working on here is wide, so Iʻm going to convert it to long below

ChemData_long <- ChemData_clean |> # assign it to chemdata_clean data frame
  pivot_longer(cols      = Temp_in:percent_sgd, # select columns to pivot
               names_to  = "Variables",         # new column for old column names
               values_to = "Values")            # new column for the values

# making long data --> wide

ChemData_wide <- ChemData_long |>
  pivot_wider(names_from  = Variables,
              values_from = Values)

## data analysis ##

ChemData_long |>
  group_by(Variables, Site) |> 
  summarise(Param_means = mean(Values, na.rm = TRUE), # calculating mean and variance
            Param_vars  = var(Values,  na.rm = TRUE)) # ^ this is easier to do using long data
ChemData_long |>
  group_by(Variables, Zone) |> 
  summarise(Param_means = mean(Values, na.rm = TRUE), # calculating mean and variance
            Param_vars  = var(Values,  na.rm = TRUE))
ChemData_long |>
  group_by(Variables, Tide) |> 
  summarise(Param_means = mean(Values, na.rm = TRUE), # calculating mean and variance
            Param_vars  = var(Values,  na.rm = TRUE))

## facet wrap ##

ChemData_long |> # Create boxplots of every parameter by site
  ggplot(aes(x = Site, y = Values)) +
  geom_boxplot() +
  facet_wrap(~Variables, scales = "free") # releases both the x and y axes
## great way to visualize all the data at once!

head(ChemData_clean)

## Combining columns with "paste" ###

paste("Maunalua", "Fringing", sep = ".")

## New data frame !! ##

ChemData_clean <- ChemData |>
  drop_na() |>
  separate_wider_delim(cols        = Tide_time,
                       delim       = "_",
                       names       = c("Tide", "Time"),
                       cols_remove = FALSE) |>
  pivot_longer(cols      = Temp_in:percent_sgd,
               names_to  = "Variables",
               values_to = "Values") |>
  group_by(Variables, Site, Time) |>
  summarise(mean_vals = mean(Values, na.rm = TRUE)) |>
  pivot_wider(names_from  = Variables,
              values_from = mean_vals) |>
  write_csv(here("Week_4", "output", "summary.csv"))

