library(shiny)
library(dplyr)

source("examples/utils.R")

cheeses <- read.csv("data/cheeses.csv")
country_choices <- split_unique(cheeses$country)
type_choices <- split_unique(cheeses$type)

ui <- fluidPage(
  selectInput(inputId = "countries", label = "Countries", choices = country_choices),
  selectInput(inputId = "type", label = "Type", choices = type_choices),
  actionButton(inputId = "show_modal", label = "Show modal"),
  dataTableOutput(outputId = "my_table")
)

server <- function(input, output, session) {
  counters <- reactiveValues(
    counter_df = data.frame(
      country = 0,
      type = 0
    )
  )

  observeEvent(input$countries, {
    counters$counter_df$country <- counters$counter_df$country + 1
  })

  observeEvent(input$type, {
    counters$counter_df$type <- counters$counter_df$type + 1
  })

  observeEvent(counters$counter_df, {
    print(counters$counter_df)
  })

  output$my_table <- renderDataTable({
    datatable(
      cheeses,
      rownames = FALSE,
      options = list(pageSize = 10),
      selection = "single"
    )
  })

  observeEvent(input$my_table_rows_selected, {
    title <- cheeses$cheese[input$my_table_rows_selected]
    showModal(
      modalDialog(
        title = title,
        uiOutput(outputId = "my_img")
      )
    )
  })

  output$my_img <- renderUI({
    img <- get_cheese_img(cheeses$url[input$my_table_rows_selected])
    tags$img(
      src = img,
      alt = "This is alternate text",
      style = "width: 100%"
    )
  })
}

shinyApp(ui, server)
