
stars <- read_csv("data/stars.csv")

glimpse(stars)

library(shiny)
library(tidyverse)

ui <- fluidPage(
  selectInput(inputId = "min_stars", # ID name for the input
              label = "Show sites with at least this many sea stars:",
              choices = c(1, 5, 10, 20), # threshold options
              selected = 5 # the threshold that shows first
  ), #ends up with a drop down selection
  plotOutput("star_map") # creates space for the map
)

server <- function(input, output){
  
  kept_sites <- reactive({ #turns data into a function
    stars|>
      filter(star_no>= as.numeric(input$min_stars)) # sites above threshold
  })
  
  output$star_map <- renderPlot ({
    ggplot(kept_sites(), aes(x=long, y=lat)) +
      geom_point(aes(size=star_no),color="red")+ # points sized by count
      labs(size= "Sea Stars Counted")
  })
}

shinyApp(ui = ui, server = server)
