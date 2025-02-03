library(shiny)
library(dplyr)
library(echarts4r)
library(leaflet)
library(sf)

cheeses <- read.csv("data/cheeses.csv")
worldmap <- st_read("data/worldmap/")

ui <- navbarPage(
  title = "Say Cheese :)",
  tabPanel(
    title = "Map",
    leafletOutput(
      outputId = "worldmap", width = "50%"
    )
  ),
  tabPanel(
    title = "Charts",
    echarts4rOutput(outputId = "my_chart")
  )
)

server <- function(input, output) {
  # map
  output$worldmap <- renderLeaflet({
    leaflet() |>
      addTiles() |>
      addPolygons(
        data = worldmap,
        color = "transparent",
        popup = ~name,
        layerId = ~name
      )
  })

  observeEvent(input$worldmap_shape_click, {
    print(input$worldmap_shape_click)
  })

  # echarts
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

  observeEvent(input$my_chart_clicked_data, {
    print(input$my_chart_clicked_data)
  })
}

shinyApp(ui = ui, server = server)
