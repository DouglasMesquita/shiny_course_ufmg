library(shiny)

ui <- fluidPage(
  tags$head(
    tags$script(
      HTML(
        "
        Shiny.addCustomMessageHandler('my_js_handler', function(message) {
          debugger;
        });
        "
      )
    )
  ),
  actionButton(inputId = "my_btn", label = "Do something!")
)

server <- function(input, output, session) {
  observeEvent(input$my_btn, {
    session$sendCustomMessage("my_js_handler", input$my_btn)
  }, ignoreInit = TRUE)
}

shinyApp(ui, server)
