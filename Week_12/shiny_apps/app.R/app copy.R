library(shiny)

ui <- fluidPage('Hello World') # code to create a webpage

server <- function(input, output){}

shinyApp(ui = ui, server = server) # turn user interface and server into a shiny app
