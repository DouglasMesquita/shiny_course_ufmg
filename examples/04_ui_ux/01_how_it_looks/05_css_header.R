library(shiny)

ui <- fluidPage(
  tags$head(
    tags$style(
      ".btn-default {
        color: #ffffff;
          background-color: #ff0000;
      }"
    )
  ),
  actionButton(
    inputId = "my_btn",
    label = "Click me"
  )
)

server <- function(input, output, session) {}

shinyApp(ui, server)
