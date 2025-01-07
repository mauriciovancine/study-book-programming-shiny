# packages
library(shiny)
library(ggplot2)

# ui
ui <- fluidPage(
  
  titlePanel("Bloxplot com a base ggplot2::diamonds"),
  
  sidebarLayout(
    
    sidebarPanel(
      selectInput(
        inputId = "y_var",
        label = "Selecione a variável numérica (Eixo Y):",
        choices = names(diamonds)[sapply(diamonds, is.numeric)],
        selected = 1
      ),
      
      selectInput(
        inputId = "x_var",
        label = "Selecione a variável categórica (Eixo X):",
        choices = names(diamonds)[sapply(diamonds, is.factor)],
        selected = 1
      )
    ),
    
    mainPanel(
      plotOutput(outputId = "boxplot")
    )
  )
)

# server
server <- function(input, output){
  
  plot_data <- reactive({
    req(input$y_var, input$x_var)  # Ensure inputs are available
    diamonds %>% 
      dplyr::select(input$x_var, input$y_var) %>% 
      dplyr::rename(x = 1, y = 2)
  })
  
  output$boxplot <- renderPlot({
    ggplot(data = plot_data(), aes(x = x, y = y, fill = x)) +
      geom_boxplot() +
      scale_fill_discrete() +
      labs(x = input$x_var, y = input$y_var,
           title = paste("Boxplot de ", input$y_var, "por", input$x_var)) +
      theme_minimal() +
      theme(legend.position = "none")
    
  })
  
}

# run app
shinyApp(ui, server)