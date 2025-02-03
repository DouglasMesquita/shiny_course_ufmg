library(shiny)
library(leaflet)
library(sf)

worldmap <- st_read("data/worldmap/")

ui <- fluidPage(
  leafletOutput(
    outputId = "worldmap", width = "100vw", height = "100vh"
  )
)

# Server
server <- function(input, output, session) {
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

  # observeEvent(input$worldmap_shape_click, {
  #   print(input$worldmap_shape_click)
  # })
}

shinyApp(ui = ui, server = server)
