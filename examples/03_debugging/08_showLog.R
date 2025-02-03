library(shiny)
library(shinyjs)

ui <- fluidPage(
  tags$head(
    tags$script(
      HTML(
        "
        Shiny.addCustomMessageHandler('my_js_handler', function(message) {
          console.log('Number of times button was clicked: ' + message);
        });
        "
      )
    )
  ),
  useShinyjs(),
  actionButton(inputId = "my_btn", label = "Do something!")
)

server <- function(input, output, session) {
  showLog()

  observeEvent(input$my_btn, {
    session$sendCustomMessage("my_js_handler", input$my_btn)
  }, ignoreInit = TRUE)
}

shinyApp(ui, server)
