### New Penguin Data ###
### created by me: Jasmine Chang
#### created on 2026-09-17
#### last edited 2026-09-17

# libraries
# load libraries everytime you open 
library (palmerpenguins)
library(tidyverse)
library(here)

## load data ##
glimpse(penguins)


## filter data ##
filter(.data = penguins, sex == "female")
