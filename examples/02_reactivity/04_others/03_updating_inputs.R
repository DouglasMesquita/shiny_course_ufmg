library(shiny)
library(dplyr)

source("examples/utils.R")

cheeses <- read.csv("data/cheeses.csv")
country_choices <- split_unique(cheeses$country)

ui <- fluidPage(
  selectInput(inputId = "countries", label = "Countries", choices = country_choices),
  selectInput(inputId = "type", label = "Type", choices = type_choices),
  tableOutput(outputId = "cheeses_table")
)

server <- function(input, output, session) {
  counter <- reactiveVal(0)

  observeEvent(input$countries, {
    type_choices <- cheeses |>
      filter(grepl(x = country, pattern = input$countries)) |>
      pull(type) |>
      split_unique()

    updateSelectInput(
      session = session,
      inputId = "type",
      choices = type_choices
    )
  })

  filtered_data <- reactive({
    country_sel <- input$countries
    type_sel <- input$type

    i <- isolate({ counter() })
    counter(i + 1)
    print(i)

    cheeses |>
      filter(
        grepl(x = country, pattern = country_sel),
        grepl(x = type, pattern = type_sel)
      )
  })

  filtered_data_debounced <- debounce(
    r = filtered_data,
    millis = 2000
  )

  output$cheeses_table <- renderTable({
    req(nrow(filtered_data_debounced()) > 0)

    filtered_data_debounced()
  })
}

shinyApp(ui, server)
