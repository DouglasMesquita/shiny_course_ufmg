library(shiny)

ui <- fluidPage(
  actionButton(
    inputId = "my_btn",
    label = "Click me",
    style = "color: #ffffff; background-color: #ff0000;"
  )
)

server <- function(input, output, session) {}

shinyApp(ui, server)
