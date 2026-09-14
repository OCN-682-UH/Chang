

#### Jasmine Chang
#### Online lecture 5
#### created on 2026-09-10
#### last edit on 2026-09-10


# libraries
# load libraries everytime you open 
library (palmerpenguins)
library(tidyverse)
library(here)
library(devtools)

# looking at the data
glimpse(penguins)

# ggplot
# the "+" layers them together, order matters!!
ggplot(data=penguins,
       mapping = aes(x=bill_depth_mm,
                     y=bill_length_mm,
                     group=species,
                     color=species)) +
geom_point()+
  geom_smooth(method= "lm")+
  labs(x="Bill depth (mm)",
       y="Bill length (mm)")
 # color=species,
 # shape=island
 # facet_wrap(~species, ncol=2)+
 # guides(color="none",shape="none")#make it 2 columns
#faceted by species^^
  #facet_grid(species~sex)
# faceting is making smaller graphs. Above translates to: species faceted by sex
  #labs(title = "Bill Depth and Bill Length",
     #  subtitle="Dimensions for Adelie, Chinstrap, and Gentoo",
    #   x="Bill Depth (mm)", y="Bill Length (mm)",
     #  color="Species",
    #   shape="Islands",
    #   caption="Source: Palmer Station LTER")
scale_colour_viridis_d()



## dont forget to put commas after everything!!
## labs means labels, all labels have to fall within those parenthesis
## viridis d uses descrete colors for people with color blindness


