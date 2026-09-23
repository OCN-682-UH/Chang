### New Penguin Data ###
### created by me: Jasmine Chang
#### created on 2026-09-17
#### last edited 2026-09-21
### Homework: calculates the mean and variance of body mass by species, island, and sex without any NAs
### Homework: filters out (i.e. excludes) male penguins, then calculates the log body mass, 
### then selects only the columns for species, island, sex, and log body mass, then use these 
### data to make any plot. Make sure the plot has clean and clear labels and follows best practices. 
### Save the plot in the correct output folder.

# libraries
# load libraries everytime you open 
library (palmerpenguins)
library(tidyverse)
library(here)
library(ggplot2)
library(beyonce)

## load data ##
glimpse(penguins)


## filter data ##

log_body_mass <- filter(.data = penguins, sex == "female") |>
mutate(log_body_mass = log(body_mass_g)) |>
  select(species, island, sex, log_body_mass) # creating a new data set to create the ggplot below

## mean & variance of body mass ##

penguins |> # mean & variance, species
  group_by(species) |>
  summarise(mean_body_mass = mean(body_mass_g, na.rm = TRUE),
  variance_body_mass = var(body_mass_g),
            n                = n()) |>
  drop_na(species) 

penguins |> # mean & variance, sex
  group_by(sex) |>
  summarise(mean_body_mass = mean(body_mass_g, na.rm = TRUE),
            variance_body_mass = var(body_mass_g),
            n                = n()) |>
  drop_na(sex) 

## ggplot ##

ggplot(data=log_body_mass,
       mapping = aes(x=species,
                     y=log_body_mass))+ # not sure how to fill these with color
  geom_boxplot()+
  labs(title = "Body Mass of Female Penguins",
       x="Species",
       y="Log Body Mass")+
  scale_color_manual(values = beyonce_palette(25))+
  theme_bw()
