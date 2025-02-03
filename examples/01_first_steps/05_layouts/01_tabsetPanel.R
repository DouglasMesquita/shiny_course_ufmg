ui <- fluidPage(
  tabsetPanel(
    tabPanel(
      title = "Title 1",
      "Tab 1"
    ),
    tabPanel(
      title = "Title 2",
      "Tab 2"
    )
  )
)

server <- function(input, output) {}

shinyApp(ui = ui, server = server)
