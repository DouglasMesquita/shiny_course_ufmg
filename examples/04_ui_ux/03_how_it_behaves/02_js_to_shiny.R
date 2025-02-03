library(shiny)

ui <- fluidPage(
  tags$head(
    tags$script(
      HTML(
        "
        $(document).on('shiny:sessioninitialized', function(event) {
          $('#my_btn').click(function() {
            Shiny.setInputValue('jsValue', 'My message goes here')
          })
        });
        "
      )
    )
  ),
  actionButton(inputId = "my_btn", label = "Do something!")
)

server <- function(input, output, session) {
  observeEvent(input$jsValue, {
    showNotification(input$jsValue)
  })
}

shinyApp(ui, server)
