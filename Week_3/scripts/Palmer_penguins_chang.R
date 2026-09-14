

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
library(beyonce)
library(ggthemes)

# looking at the data
glimpse(penguins)

# ggplot
# the "+" layers them together, order matters!!
ggplot(data=penguins,
       mapping = aes(x=bill_depth_mm,
                     y=bill_length_mm,
                     group=species,
                     color=species)) +
geom_point(size=2)+
  geom_smooth(method= "lm")+
  labs(title= "Bill Depth and Length of Adelie, Chinstrap, and Gentoo Penguins",
    x="Bill depth (mm)",
       y="Bill length (mm)",
       color="Species")+
scale_color_manual(values = beyonce_palette(23))+
  theme_bw()+
  theme(axis.title = element_text(size = 10),
        (plot.title=element_text(size=20)))

ggsave(here("Week_3","Outputs","penguin.png"))

       
#panel.background = element_rect(fill = "linen"))
#theme_classic()
# coord_fixed() # fix axes
# coord_polar("x") # make the polar 
# coord_flip() # flip x and y axes
# color=species,
# shape=island
# facet_wrap(~species, ncol=2)+ #faceted by species
  # guides(color="none",shape="none")#make it 2 columns
  #facet_grid(species~sex) # faceting is making smaller graphs,species faceted by sex
  #labs(title = "Bill Depth and Bill Length",
     #  subtitle="Dimensions for Adelie, Chinstrap, and Gentoo",
    #   x="Bill Depth (mm)", y="Bill Length (mm)",
     #  color="Species",
    #   shape="Islands",
    #   caption="Source: Palmer Station LTER")




## dont forget to put commas after everything!!
## labs means labels, all labels have to fall within those parenthesis
## viridis d uses descrete colors for people with color blindness


