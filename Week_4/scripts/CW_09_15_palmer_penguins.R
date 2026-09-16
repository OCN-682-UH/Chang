### New Penguin Data ###
### created by me: Jasmine Chang
#### created on 2026-09-15
#### last edited 2026-09-15

# libraries
# load libraries everytime you open 
library (palmerpenguins)
library(tidyverse)
library(here)

## dad joke package & library
library(dadjokeapi)
groan()

## load data ##
glimpse(penguins)

## filter data ##
filter(.data = penguins,body_mass_g>5000) # data=the data frame, followed by any conditions
fat_penguins <- filter(penguins, body_mass_g>5000) # creating a dataset that you can save and return to

filter(.data = penguins, sex == "female", body_mass_g > 5000)
fat_girl_penguins <- filter(penguins, sex=="female", body_mass_g>5000)

filter(.data=penguins, year==2008|year==2009) # data from 2008 EITHER/OR 2009
filter(.data=penguins, year %in% c(2008,2009)) # another way to group, less typing
filter(.data=penguins, island!="Dream") # data NOT from "Dream" island
filter(.data=penguins, !(island=="Dream")) # another way to negate
filter(.data=penguins, species %in% c("Adelie","Gentoo")) # "c"=joining things,& wont work, penguins cant be 2 species


## mutate data ##

mutate(.data=penguins, body_mass_kg=body_mass_g/1000,
       bill_length_depth=bill_length_mm / bill_depth_mm) #create a new column using equations from pre-existing ones
# mutating multiple columns at once
penguins |>
  mutate(across(where(is.numeric), ~ round(.x, 1))) #every column that is numeric, the decimal will be rounded up to 0.1
# ifelse --> conditional tests within mutate
what_year <- mutate(.data = penguins,
       after_2008 = if_else(year > 2008, "After 2008", "Before 2008")) # first quotes is agreeing with condition, second quotes is everthing that doesnʻt

make_no_sense <- mutate(.data=penguins, flipper_body_mass=flipper_length_mm+body_mass_g)
skinny <- mutate(.data=penguins,
       big_or_small=if_else(body_mass_g>4000, "Big", "Small"))

## piping data ##
penguins |>
filter(sex == "female") |>
  mutate(log_mass = log(body_mass_g)) |>
  select(species, island, sex, log_mass) # select renames columns, start with og name followed by new names

penguins |>
  arrange(body_mass_g) # arrange to sort rows by a column - ascending by default

penguins |>
  arrange(desc(body_mass_g)) # desc() to sort in descending order

penguins |> # summarise --> compute summarized data
  summarise(mean_flipper = mean(flipper_length_mm, na.rm = TRUE)) # calculate mean flipper length (and exclude any NAs)

penguins |>
  summarise(mean_flipper = mean(flipper_length_mm, na.rm = TRUE), # calculate mean and min flipper length
            min_flipper  = min(flipper_length_mm, na.rm = TRUE)) 

penguins |>
  group_by(island) |> # group_by() by itself doesn’t do anything, but it is powerful when put before summarise()
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE), #summarize values by certain groups
            max_bill_length  = max(bill_length_mm, na.rm = TRUE),
            n                = n()) # n() counts the number of rows in each group

penguins |>
  group_by(island, sex) |> # group by both island and sex
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE),
            max_bill_length  = max(bill_length_mm, na.rm = TRUE))

penguins |>
  count(species) #count() is a quick shortcut for counting rows per group 

penguins |>
  count(species, island) # count by multiple variables at once

penguins |> # drops rows with NAs from a specific column
  drop_na(sex) # drop all the rows that are missing data on sex

penguins |>
  drop_na(sex) |> # drop all the rows that are missing data on sex
  group_by(island, sex) |> # then calculate mean bill length by island and sex
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE))

penguins |>
  drop_na(sex) |> # drop NAs from sex, and then plot boxplots of flipper length by sex
  ggplot(aes(x = sex, y = flipper_length_mm)) + # you can connect your data wrangling to a ggplot with the pipe 
  geom_boxplot()
