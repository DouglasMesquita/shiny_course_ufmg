library(shiny)

ui <- fluidPage(
  tags$script(src = "main.js"),
  # includeScript(path = "www/main.js"),
  actionButton(inputId = "test1", label = "button 1"),
  actionButton(inputId = "test2", label = "button 2")
)

server <- function(input, output, session) {
  observeEvent(input$changed, {
    showNotification(input$changed)
  })
}

shinyApp(ui, server)
