library(shiny)
library(dplyr)

source("examples/utils.R")

cheeses <- read.csv("data/cheeses.csv")
country_choices <- split_unique(cheeses$country)

ui <- fluidPage(
  tags$style(HTML("
  .selectize-input {
      background-color: #ff0000 !important;
      color: #ffffff !important;
      border-radius: 5px !important;
    }
    .selectize-dropdown {
      background-color: red !important;
    }
    body {
      background-color: black !important;
      color: white;
    }
    table.dataTable tbody tr:nth-child(odd) {
      background-color: red !important;
    }
    table.dataTable tbody tr:nth-child(even) {
      background-color: blue !important;
    }
  ")),
  selectInput(inputId = "countries", label = "Countries", choices = country_choices),
  dataTableOutput(outputId = "cheeses_table")
)

server <- function(input, output, session) {
  filtered_data <- reactive({
    country_sel <- input$countries

    cheeses |>
      filter(
        grepl(x = country, pattern = country_sel)
      )
  })

  output$cheeses_table <- renderDataTable({
    datatable(filtered_data())
  })
}

shinyApp(ui, server)
