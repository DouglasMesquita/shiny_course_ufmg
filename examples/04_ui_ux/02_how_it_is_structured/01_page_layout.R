library(shiny)
library(glue)

element <- function(color, height, title) {
  div(
    style = glue("
      background-color: {color};
      color: #3e3e3e;
      font-size: 35px;
      height: calc({height} - 10px);
      line-height: calc({height} - 10px);
      text-align: center;
      margin: 5px 2.5px;
      border-radius: 10px;
    "),
    title
  )
}

ui <- fluidPage(
  fluidRow(
    column(
      width = 12,
      element("#a8feca", "10vh", "Header")
    )
  ),
  fluidRow(
    column(
      width = 4,
      element("#fdc6a7", "80vh", "Sidebar")
    ),
    column(
      width = 8,
      element("#a8f2fe", "80vh", "Main")
    )
  ),
  fluidRow(
    column(
      width = 12,
      element("#a8feca", "10vh", "Footer")
    )
  )
)

server <- function(input, output, session) {}

shinyApp(ui, server)
