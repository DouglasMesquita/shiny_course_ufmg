library(shiny)
library(dplyr)

source("examples/utils.R")

cheeses <- read.csv("data/cheeses.csv")
country_choices <- split_unique(cheeses$country)
type_choices <- split_unique(cheeses$type)

ui <- fluidPage(
  selectInput(inputId = "countries", label = "Countries", choices = country_choices),
  selectInput(inputId = "type", label = "Type", choices = type_choices),
  tableOutput(outputId = "cheeses_table")
)

server <- function(input, output, session) {
  observeEvent(input$countries, {
    country_sel <- input$countries
    type_sel <- input$type

    output$cheeses_table <- renderTable({
      cheeses |>
        filter(
          grepl(x = country, pattern = country_sel),
          grepl(x = type, pattern = type_sel)
        )
    })
  })
}

shinyApp(ui, server)
