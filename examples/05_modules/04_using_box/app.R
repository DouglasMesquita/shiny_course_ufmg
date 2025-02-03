box::use(
  shiny[fluidPage, shinyApp],
  ./my_module[my_ui, my_server],
  #./my_module,
)

ui <- fluidPage(
  my_ui("my_id1"),
  my_ui("my_id2")
)

server <- function(input, output, session) {
  my_server("my_id1")
  my_server("my_id2")
}

shinyApp(ui, server)

# box::purge_cache()
