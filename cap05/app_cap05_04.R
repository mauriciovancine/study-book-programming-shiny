library(shiny)

ui <- fluidPage(
  
  tags$head(
    tags$link(rel = "stylesheet", href = "custom.css")
  ),
  "Teste"
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)