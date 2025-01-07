library(shiny)

ui <- fluidPage(
  titlePanel("Shiny com sidebarLayout"),
  sidebarLayout( 
    sidebarPanel(
      sliderInput(
        "num",
        "Número de observações:",
        min = 0,
        max = 1000,
        value = 500
      )
    ),
    mainPanel(
      plotOutput("hist")
    )
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)