library(shiny)

source("examples/utils.R")

cheeses <- read.csv("data/cheeses.csv")
country_choices <- split_unique(cheeses$country)

ui <- fluidPage(
  selectInput(
    inputId = "countries",
    label = "Countries",
    choices = country_choices,
    selected = country_choices[1],
    multiple = FALSE
  )
)

server <- function(input, output, session) {}

shinyApp(ui, server)

# Allowing NULL as selection version 1

# selectInput(
#   inputId = "countries",
#   label = "Countries",
#   choices = c("", country_choices),
#   selected = NULL,
#   multiple = FALSE
# )

# Allowing NULL as selection version 2

# selectizeInput(
#   inputId = "countries",
#   label = "Countries",
#   choices = country_choices,
#   selected = NULL,
#   multiple = TRUE,
#   options = list(maxItems = 1)
# )
