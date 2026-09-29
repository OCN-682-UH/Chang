# Read in both the conductivity and depth data
# Convert date columns appropriately
# Round the conductivity data to the nearest 10 seconds to match depth data
# Join the two dataframes using inner_join() (only exact matches)
# Calculate averages of date, depth, temperature, and salinity by minute
# Make a plot using the averaged data
# Use pipes throughout (minimize separate dataframes)
# Add comments to your code!
# Save output, data, and scripts appropriately
## Created on 2026-09-22 ##
## Last edited on 2026-09-28 ##
## Created by Jasmine Chang ##


### load libraries ###
library(tidyverse)
library(here)
library(ggplot2)

### load data ###

CondData <- read_csv(here("Week_5", "data", "CondData.csv"))
glimpse(CondData)

DepthData <- read_csv(here("Week_5", "data", "DepthData.csv"))
glimpse(DepthData)

### clean up data ###

CondData <- read_csv(here("Week_5", "data", "CondData.csv")) |>
  mutate(datetime = mdy_hms(date)) |> # convert the date column to a datetime using the pipe:
  mutate(datetime = round_date(datetime, "10 secs")) # rename date-rounded-column to nearest 10 sec
glimpse(CondData)

DepthData <- read_csv(here("Week_5", "data", "DepthData.csv")) |>
  mutate(datetime = ymd_hms(date)) # convert the date column to a datetime using the pipe:
glimpse(DepthData)

### join the two datasets ###

# data_joined <- inner_join(CondData, DepthData) # this didnt work...
data_joined <- inner_join(CondData, DepthData, by = "datetime")

### calculate averages of date, depth, temp, and sal by min ###

means_joined <- data_joined |> # calculate from new data set
  mutate(datetime = round_date(datetime, "minute")) |> # round to nearest minute
  group_by(datetime) |> # group by datetime
  summarise(mean_depth = mean(Depth, na.rm = TRUE), # mean depth 
            mean_temp = mean(Temperature, na.rm = TRUE), # mean temp
            mean_sal = mean(Salinity, na.rm = TRUE)) # mean sal

### creating plot ### 

ggplot(data=means_joined,
       mapping = aes(x=datetime,y=mean_sal)) +
  geom_line()+
  labs(title="Salinity Fluctuations in Field Collection",
       x="Time",
       y="Salinity") +
  theme_minimal()

ggsave(here("Week_5","outputs","HW_week_5.png"),
       width=7, height=5)
