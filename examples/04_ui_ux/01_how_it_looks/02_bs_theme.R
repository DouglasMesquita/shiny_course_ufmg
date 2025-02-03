library(shiny)
library(bslib)

source("examples/utils.R")

cheeses <- read.csv("data/cheeses.csv")
country_choices <- split_unique(cheeses$country)

ui <- fluidPage(
  theme = bs_theme(
    bootswatch = "darkly",
    base_font = font_google("Inter"),
    navbar_bg = "#25443B"
  ),
  selectInput(
    inputId = "countries",
    label = "Countries",
    choices = country_choices
  ),
  tableOutput(outputId = "cheeses_table")
)

server <- function(input, output, session) {
  #bs_themer()

  output$cheeses_table <- renderTable({
    cheeses
  })
}

shinyApp(ui, server)

# bs_theme_preview()
# run_with_themer(shinyApp(ui, server))

