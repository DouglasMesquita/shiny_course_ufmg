library(shiny)
library(ggplot2)
library(ggthemes)
library(forcats)

source("examples/utils.R")

cheeses <- read.csv("data/cheeses.csv")

ui <- fluidPage(
  plotOutput(outputId = "my_chart")
)

server <- function(input, output, session) {
  output$my_chart <- renderPlot({
    ggplot(data = cheeses) +
      geom_bar(mapping = aes(x = fct_infreq(color))) +
      theme_bw() +
      theme(
        axis.text.x = element_text(angle = 45, hjust = 1)
      )
  })
}

shinyApp(ui, server)
