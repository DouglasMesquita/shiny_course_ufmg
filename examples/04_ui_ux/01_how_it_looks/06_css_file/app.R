library(shiny)

ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
    # includeCSS(path = "www/styles.css")
  ),
  actionButton(
    inputId = "my_btn",
    label = "Click me"
  )
)

server <- function(input, output, session) {}

shinyApp(ui, server)
