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
  user_usage <- reactiveValues(
    counter = 0,
    history = data.frame(
      counter = numeric(0),
      country = character(0),
      type = character(0)
    )
  )

  filtered_data <- eventReactive(input$apply_filters, {
    country_sel <- input$countries
    type_sel <- input$type

    user_usage$counter <- user_usage$counter + 1

    cheeses |>
      filter(
        grepl(x = country, pattern = country_sel),
        grepl(x = type, pattern = type_sel)
      )
  })

  observeEvent(c(input$countries, input$type), {
    user_usage$history <- rbind(
      user_usage$history,
      data.frame(
        counter = user_usage$counter,
        country = input$countries,
        type = input$type
      )
    )
  })

  observeEvent(user_usage$history, {
    print(user_usage$history)
  })

  output$cheeses_table <- renderTable({
    filtered_data()
  })
}


shinyApp(ui, server)
