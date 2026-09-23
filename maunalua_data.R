### Today we are going to practice tidyr with biogeochemistry data from Hawaii ###
### Created by: Jasmine Chang ###
### Created on: 2026-09-21 ###
### Last edited: 2026-09-21 ###

### Load Libraries ###
library(tidyverse)
library(here)

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
  mutate(Site_Zone = paste(Site, Zone, sep = "."))

ChemData_long |>
  group_by(Variables, Site) |>
  summarise(Param_means = mean(Values, na.rm = TRUE),
            Param_vars  = var(Values,  na.rm = TRUE))

head(ChemData_clean)

paste("Maunalua", "Fringing", sep = ".")

