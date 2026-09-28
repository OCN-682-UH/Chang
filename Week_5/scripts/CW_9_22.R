### Classwork (i missed this class) 9_22 ###
## created by Jasmine Chang ##
## created on 2026-09-25 ##
## last edited on 2026-09-27 ##


### load libraries ###
library(tidyverse)
library(here)

### Part 1: Data Joins ###
T1 <- tibble(
  Site.ID = c("A", "B", "C", "D"),
  Temperature = c(14.1, 16.7, 15.3, 12.8)
)

T1

T2 <- tibble(
  Site.ID = c("A", "B", "D", "E"),
  pH = c(7.3, 7.8, 8.1, 7.9)
)

T2

left_join(T1, T2)
right_join(T1, T2)
inner_join(T1, T2)
full_join(T1, T2)
semi_join(T1, T2)
anti_join(T1, T2)


T3 <- tibble(
  SiteID = c("A", "B", "C", "D"),  # Note: different name!
  Chlorophyll = c(2.3, 3.1, 1.9, 2.8)
)

T3

left_join(T1, T3, by = c("Site.ID" = "SiteID"))


T4 <- tibble(
  Site.ID = c("A", "A", "B", "B"),
  Year = c(2020, 2021, 2020, 2021),
  Biomass = c(12.5, 15.3, 18.2, 16.9)
)

T5 <- tibble(
  SiteID = c("A", "A", "B"),
  Year = c(2020, 2021, 2021),
  Nutrients = c(8.2, 7.9, 9.1)
)

left_join(T4, T5, by = c("Site.ID" = "SiteID", "Year" = "Year"))

T6 <- tibble(
  Site.ID = c("A", "B", "C"),
  Notes = c("pristine", "degraded", "moderately impaired")
)

T7 <- tibble(
  Site.ID = c("A", "B", "D"),
  Notes = c("sunny", "shaded", "partially shaded"),
  Quality = c("good", "fair", "poor")
)

# Don't specify how to join — creates ambiguity with 'Notes'
left_join(T6, T7, by = "Site.ID")

##### PART 2: Dates and Times w Lubridate ######
now() #print time at time of coding, can timestamp something 
# change timezones
now(tzone = "EST")  # East Coast
now(tzone = "GMT")  # Greenwich Mean Time
now(tzone = "US/Hawaii")  # Hawaii Time
# just the date
today()
# time zone dates
today(tzone = "GMT")
# time checks
am(now())        # Is it morning?
leap_year(now()) # Is it a leap year?

# DATES HAVE TO BE CHARACTERS
# lubridate guesses date formats from character strings using year, month, day abbreviations:

# convert dates
ymd("2021-02-24") # ISO format
mdy("02/24/2021") # US format
mdy("February 24 2021") # written format
dmy("24/02/2021") # european format

# DATE and TIMES
ymd_hms("2021-02-24 10:22:20 PM") # ISO format w time
mdy_hms("02/24/2021 22:22:20") #US format with seconds
mdy_hm("February 24 2021 10:22 PM") # Written month with hour/minute

# create a vector of datetimes
datetimes <- c(
  "02/24/2021 22:22:20", # all in quotes bc HAS to be character
  "02/25/2021 11:21:10",
  "02/26/2021 8:01:52"
)

## Convert the vector to datetime objects ##

datetimes <- mdy_hms(datetimes)

datetimes

month(datetimes) # Extract the month (as number)
month(datetimes, label = TRUE) # Extract the month (as abbreviated label)
month(datetimes, label = TRUE, abbr = FALSE) # Extract the month (as full name)
day(datetimes) # Extract the day of the month
wday(datetimes, label = TRUE) #Extract the day of the week

# Extract hour, minute, and second
hour(datetimes)
minute(datetimes)
second(datetimes)

## Adding time intervals ##
datetimes + hours(4) #add 4 hours
datetimes + days(2) #add 2 days
datetimes + months(1) #add 1 month

## Rounding dates ##
round_date(datetimes, "minute") #nearest min
round_date(datetimes, "5 mins") #nearest 5 mins

### Timezone awareness: A real-world challenge ###

# Create a datetime WITHOUT timezone info
datetime_naive <- mdy_hms("02/24/2021 10:22:20")
datetime_naive

## with_tz() — View same moment in different timezone ##
# Assume the naive time is in Hawaii
hawaii_time <- with_tz(datetime_naive, tzone = "US/Hawaii")
hawaii_time
# Same moment, viewed from EST
est_time <- with_tz(hawaii_time, tzone = "EST")
est_time
## force_tz() — Change the timezone label ##
# Claim this was collected in Hawaii (though it was naive)
force_hawaii <- force_tz(datetime_naive, tzone = "US/Hawaii")
force_hawaii
# Now convert to EST (this changes the clock time!)
with_tz(force_hawaii, tzone = "EST")

### Example Challenge ###

# load data #

CondData <- read_csv(here("Week_5", "data", "CondData.csv"))
glimpse(CondData)

CondData <- read_csv(here("Week_5", "data", "CondData.csv")) |>
  mutate(datetime = mdy_hms(date)) # convert the date column to a datetime using the pipe:

## combine Topt.data and Site.characteristics
# import data
Topt_data <- read.csv(here("Week_5", "data","Topt_data.csv"))
Site_data <- read.csv(here("Week_5", "data", "site.characteristics.data.csv")) 

# pivot wider
wide_site_data <- Site_data |> 
  pivot_wider(names_from = "parameter.measured",
              values_from = "values")

glimpse(wide_site_data)

joined_files <- full_join(wide_site_data, Topt_data)



view(joined_files)
