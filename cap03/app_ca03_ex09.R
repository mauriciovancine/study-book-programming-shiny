# packages
library(shiny)
library(dados)
library(ggplot2)

# data
data <- voos %>% 
  dplyr::filter(ano == 2013) %>% 
  dplyr::mutate(date = floor_date(data_hora, unit = "day")) %>% 
  dplyr::group_by(date, companhia_aerea) %>% 
  dplyr::summarise(numero_voos = n()) %>% 
  dplyr::ungroup()

# ui
ui <- fluidPage(
  
  checkboxGroupInput(
    inputId = "comp",
    label = "Selecione uma ou mais empresas",
    choices = unique(data$companhia_aerea),
    selected = 1
  ),
  
  plotOutput(outputId = "line")
)

# server
server <- function(input, output){
  
  data_filtered <- reactive(
    data %>% 
      dplyr::filter(companhia_aerea == input$comp)
  )
  
  output$line <- renderPlot({
    
    ggplot(data = data_filtered(), 
           aes(x = date, y = numero_voos, color = companhia_aerea)) +
      geom_line() +
      scale_color_discrete() +
      labs(x = "Data", y = "Número de voos",
           title = "Número de voos ao longo de 2013") +
      theme_minimal()
    
  })
  
}

# run app
shinyApp(ui, server)