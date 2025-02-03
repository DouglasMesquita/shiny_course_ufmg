library(shiny)
library(dplyr)

source("examples/utils.R")

cheeses <- read.csv("data/cheeses.csv")
country_choices <- split_unique(cheeses$country)

ui <- fluidPage(
  selectInput(inputId = "countries", label = "Countries", choices = country_choices),
  tableOutput(outputId = "cheeses_table")
)

server <- function(input, output, session) {
  observe({
    country_sel <- input$countries

    output$cheeses_table <- renderTable({
      cheeses |>
        filter(grepl(x = country, pattern = country_sel))
    })
  })
}

shinyApp(ui, server)
