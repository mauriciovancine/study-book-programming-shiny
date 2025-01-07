library(shiny)
library(ggplot2)

variaveis <- names(diamonds)[c(1, 5:10)]

ui <- fluidPage(
  "Histograma dos dados diamends",
  selectInput(
    inputId = "variavel",
    label = "Selecione uma variável",
    choices = names(diamonds)[c(1, 5:10)]
  ),
  plotOutput(outputId = "histograma")
)

server <- function(input, output, session) {
  
  output$histograma <- renderPlot({
    hist(diamonds[[input$variavel]])
  })
  
}

shinyApp(ui, server)