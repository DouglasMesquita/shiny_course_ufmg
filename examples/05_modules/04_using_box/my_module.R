box::use(
  shiny[
    h1,
    moduleServer,
    NS,
    renderUI,
    selectInput,
    tagList,
    uiOutput,
  ],
)

#' @export
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

#' @export
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
