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

my_server <- function(id, excluded_letters = NULL) {
  moduleServer(
    id,
    function(input, output, session) {
      if (is.reactive(excluded_letters)) {
        observeEvent(excluded_letters(), {
          choices <- letters[letters != excluded_letters()]
          updateSelectInput(
            session = session,
            inputId = "my_input",
            choices = choices
          )
        })
      }

      output$my_selection <- renderUI({
        h1(input$my_input)
      })

      return(reactive({ input$my_input }))
    }
  )
}

ui <- fluidPage(
  my_ui("my_id1"),
  my_ui("my_id2")
)

server <- function(input, output, session) {
  selected_letter <- my_server("my_id1")
  my_server("my_id2", selected_letter)
}

shinyApp(ui, server)
