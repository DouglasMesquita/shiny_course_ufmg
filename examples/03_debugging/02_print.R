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
  filtered_data <- reactive({
    filtered_data <<- cheeses |>
      filter(grepl(x = country, pattern = input$countries))
    return(filtered_data)
  })

  output$cheeses_table <- renderTable({
    print("step 1")
    res <- filtered_data()
    print("step 2")
    return(res)
  })
}

shinyApp(ui, server)
