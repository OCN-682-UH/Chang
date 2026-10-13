## Classwork, online lecture week 5 ##
## created on 2026-09-29 ##
## created by Jasmine Chang ##
## last edited on 2026-09-29 ##
## Advanced plotting ##

## load libraries ##

library(tidyverse)
library(here)
library(palmerpenguins)
library(ggplot2)
library(patchwork)
library(ggrepel)
library(gganimate)
library(gifski)
library(plotly)
library(magick)

## load data ##

glimpse(penguins)

### Part 1: Patchwork ###

p1 <- penguins |> # create first plot
  ggplot(aes(x = body_mass_g, 
             y = bill_length_mm, 
             color = species)) +
  geom_point()

p1

p2 <- penguins |> # create second plot
  ggplot(aes(x = sex, 
             y = body_mass_g, 
             color = species)) +
  geom_jitter(width = 0.2)

p2

p1 + p2 +
  plot_layout(guides = 'collect') + # now has only one guide for "species"
  plot_annotation(tag_levels = 'A') # add plot labels

p1 / p2 + # plot one is on top of plot 2
  plot_layout(guides = 'collect') +
  plot_annotation(tag_levels = 'A')

### Part 2: ggrepel ###

head(mtcars) # load data

ggplot(mtcars, aes(x = wt, ## all the labels are overlapping
                   y = mpg, 
                   label = rownames(mtcars))) +
  geom_text() + # adds label to individual points
  geom_point(color = 'red')

ggplot(mtcars, aes(x = wt, 
                   y = mpg, 
                   label = rownames(mtcars))) +
  geom_text_repel() +  ### Repel the labels with geom_text_repel()
  geom_point(color = 'red') ## now we can read !

ggplot(mtcars, aes(x = wt, 
                   y = mpg, 
                   label = rownames(mtcars))) +
  geom_label_repel() + ## puts label boxes around each label
  geom_point(color = 'red')

### Part 3: gganimate ###

penguins |>
  ggplot(aes(x = body_mass_g, 
             y = bill_depth_mm, 
             color = species)) +
  geom_point()


penguins |>
  ggplot(aes(x = body_mass_g, 
             y = bill_depth_mm, 
             color = species)) +
  geom_point() +
  transition_states(
    year, ## animating between the year
    transition_length = 2, # 2 seconds to move from one transition to the next
    state_length = 1 # how long it stays in transition
  )

p<-penguins |>
  ggplot(aes(x = body_mass_g, 
             y = bill_depth_mm, 
             color = species)) +
  geom_point() +
  transition_states(year, 
                    transition_length = 2, 
                    state_length = 1) +
  ease_aes("sine-in-out") +
  labs(title = 'Year: {closest_state}') # tells us what year we are in, can apply this to species and what not
anim_save(here("Week_5", "outputs", "penguin_animation.gif"), animation = p)

### Part 4: Plotly ###

# interactive scatter plot
penguins |>
  plot_ly(x = ~body_mass_g,
          y = ~bill_depth_mm,
          color = ~species,
          type = "scatter",
          mode = "markers") |>
  layout(title = "Penguin Body Mass vs Bill Depth",
         xaxis = list(title = "Body Mass (g)"), # hover over points for information
         yaxis = list(title = "Bill Depth (mm)"))

# animate by species with frame
penguins |>
  plot_ly(x = ~body_mass_g,
          y = ~bill_depth_mm,
          frame = ~species,
          color = ~species,
          type = "scatter",
          mode = "markers",
          marker = list(size = 8)) |>
  layout(title = "Penguin Characteristics",
         xaxis = list(title = "Body Mass (g)"),
         yaxis = list(title = "Bill Depth (mm)"))

### Part 5: magick ###

# magick lets you read, process, and composite images programmatically
# read an image with "image_read"
penguin <- image_read("https://pngimg.com/uploads/penguin/pinguin_PNG9.png")

penguin

## Save a plot as an image ## 

penguinplot<-penguins |>
  ggplot(aes(x = body_mass_g, 
             y = bill_depth_mm, 
             color = species)) +
  geom_point() 
ggsave(here("Week_5", "outputs", "penguinplot.png"))
penguinplot

# Composite images with image_composite()

penplot <- image_read(here("Week_5", "outputs", "penguinplot.png"))
out <- image_composite(image = penplot,       composite_image = penguin, offset = "+70+30")
out

# Animate composite images

pengif <- image_read("https://media3.giphy.com/media/H4uE6w9G1uK4M/giphy.gif")
outgif <- image_composite(penplot, pengif, gravity = "center")
animation <- image_animate(outgif, fps = 10, optimize = TRUE)
animation
