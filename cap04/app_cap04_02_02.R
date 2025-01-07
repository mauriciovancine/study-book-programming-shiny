# packages
library(shiny)

# ui
ui <- fluidPage(
    plotOutput(outputId = "plot")
)

# server
server <- function(input, output){
  
  valor_reativo <- reactive({
    sample(1:10, 1)
  })
  
  output$plot <- renderPlot({
    browser()
    hist(rnorm(100, valor_reativo(), 1))
  })
  
}

# run app
shinyApp(ui, server)