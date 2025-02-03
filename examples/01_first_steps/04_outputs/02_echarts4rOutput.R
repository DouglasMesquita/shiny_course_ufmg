library(shiny)
library(echarts4r)
library(dplyr)

cheeses <- read.csv("data/cheeses.csv")

ui <- fluidPage(
  echarts4rOutput(outputId = "my_chart")
)

server <- function(input, output, session) {
  output$my_chart <- renderEcharts4r({
    cheeses |>
      count(color) |>
      arrange(desc(n)) |>
      na.omit() |>
      e_charts(color) |>
      e_bar(n) |>
      e_x_axis(
        name = "Color",
        axisLabel = list(rotate = 45)
      )
  })

  # observeEvent(input$my_chart_clicked_data, {
  #   print(input$my_chart_clicked_data)
  # })
}

shinyApp(ui, server)
