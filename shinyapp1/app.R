
### MY FIRST SHINY APP ###

library(shiny)
library(tidyverse)
library(tidytuesdayR)
library(ggplot2)

respondent_metadata <- read_csv("respondent_metadata.csv") # pulling dataset

ui <- fluidPage(
  titlePanel("Shiny App Homework: How likely is likely?"), # title of shiny app
  textInput("name", "Hello, whatʻs your name?"), # first question for funsies
  selectInput("country", "Country of Residence", # first dropdown option
              choices = (sort(unique(respondent_metadata$country_of_residence)))), # dropdown options
  selectInput("age", "Age band", # second dropdown option
              choices = sort(unique(respondent_metadata$age_band))), # dropdown options
  
  plotOutput("language"), # based on options selected, these are the two plot outputs
  
  plotOutput("degree"),

  textInput("number", "How was this app? Give me a rating! (0-10)") # another one for fun
)

server <- function(input, output){
  
  filtered <- reactive({ #filter dataset, link dataset?
    respondent_metadata |>
      filter(country_of_residence == input$country, # keep rows for whatever matches the dropdown
             age_band == input$age)
  })
  
  output$language <- renderPlot({ validate(need(nrow(filtered()) > 0, "NA"))
  
    
      ggplot(filtered(), aes(x = english_background)) + # customize ggplot, give data for english background
      geom_bar() +
      labs(x = "English background", y = "Number of people") +
      theme_minimal()
      
      })
      
  output$degree <- renderPlot({
    validate(need(nrow(filtered()) > 0, "NA"))
    
    ggplot(filtered(), aes(x = education_level)) + # give data for education level
      geom_bar() +
      labs(x = "Education level", y = "Number of people") +
      theme_minimal()
  })
   
}
  
shinyApp(ui = ui, server = server)
