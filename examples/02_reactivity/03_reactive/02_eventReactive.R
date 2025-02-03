library(shiny)
library(dplyr)

source("examples/utils.R")

cheeses <- read.csv("data/cheeses.csv")
country_choices <- split_unique(cheeses$country)
type_choices <- split_unique(cheeses$type)

ui <- fluidPage(
  selectInput(inputId = "countries", label = "Countries", choices = country_choices),
  selectInput(inputId = "type", label = "Type", choices = type_choices),
  actionButton(inputId = "apply_filters", label = "Apply Filters"),
  tableOutput(outputId = "cheeses_table")
)

server <- function(input, output, session) {
  filtered_data <- eventReactive(input$apply_filters, {
    country_sel <- input$countries
    type_sel <- input$type

    cheeses |>
      filter(
        grepl(x = country, pattern = country_sel),
        grepl(x = type, pattern = type_sel)
      )
  })

  output$cheeses_table <- renderTable({
    filtered_data()
  })
}


shinyApp(ui, server)
