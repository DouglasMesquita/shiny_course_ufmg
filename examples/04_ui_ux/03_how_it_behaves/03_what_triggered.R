library(shiny)

ui <- fluidPage(
  tags$head(
    tags$script(
      "$(document).on('shiny:inputchanged', function(event) {
          if (event.name != 'changed') {
            Shiny.setInputValue('changed', event.name);
          }
        });"
    )
  ),
  actionButton(inputId = "test1", label = "button 1"),
  actionButton(inputId = "test2", label = "button 2")
)

server <- function(input, output, session) {
  observeEvent(input$changed, {
    showNotification(input$changed)
  })
}

shinyApp(ui, server)
