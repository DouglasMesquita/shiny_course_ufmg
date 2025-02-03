library(shiny)

my_ui <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(
      inputId = ns("my_input"),
      label = "letters",
      choices = letters
    ),
    uiOutput(outputId = ns("my_selection"))
  )
}

my_server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      output$my_selection <- renderUI({
        h1(input$my_input)
      })
    }
  )
}

ui <- fluidPage(
  my_ui("my_id1"),
  my_ui("my_id2")
)

server <- function(input, output, session) {
  my_server("my_id1")
  my_server("my_id2")
}

shinyApp(ui, server)
