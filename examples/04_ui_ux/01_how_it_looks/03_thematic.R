library(shiny)
library(ggplot2)
library(ggthemes)
library(forcats)
library(bslib)
library(thematic)

source("examples/utils.R")

cheeses <- read.csv("data/cheeses.csv")
thematic_shiny()

ui <- fluidPage(
  theme = bs_theme(
    bootswatch = "darkly",
    base_font = font_google("Inter"),
    navbar_bg = "#25443B"
  ),
  plotOutput(outputId = "my_chart")
)

server <- function(input, output, session) {
  output$my_chart <- renderPlot({
    ggplot(data = cheeses) +
      geom_bar(mapping = aes(x = fct_infreq(color))) +
      theme(
        axis.text.x = element_text(angle = 45, hjust = 1)
      )
  })
}

shinyApp(ui, server)
