#### Jasmine Chang
#### Lecture 16 Homework
#### created on 2026-09-14
#### last edit on 2026-09-14

### libraries ###
# load libraries every time you open 

library (palmerpenguins)
library(tidyverse)
library(here)
library(devtools)
library(beyonce)
library(ggthemes)

# looking at the data
glimpse(penguins)

# ggplot
# the "+" layers them together, order matters!!
ggplot(data=penguins,
       mapping = aes(x=sex,y=flipper_length_mm,
                    fill=species))+
geom_boxplot()+
labs(title= "Flipper Length by Sex",
     subtitle="Adelie, Chinstrap, and Gentoo Penguins",
     x="Sex",
     y="Flipper Length (mm)",
     fill="Species")+
scale_color_manual(values = beyonce_palette(23))+
  theme_minimal()

ggsave(here("Week_3","Outputs","penguin_hw.png"),
  width=7, height=6)
