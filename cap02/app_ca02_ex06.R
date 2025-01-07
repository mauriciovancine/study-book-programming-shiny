# packages
library(shiny)
library(tidyverse)
library(dados)

# dados
dados <- voos %>% 
  dplyr::mutate(data = lubridate::as_date(data_hora))

# ui
ui <- fluidPage(
  
  # selection date
  dateInput("date", label = h3("Escolha o dia"), value = "2013-01-01"),
  
  # tabele
  tableOutput(outputId = "table"),
  
  # grafico
  plotOutput(outputId = "barplot")
  
)

# server
server <- function(input, output, session){
  
  dados_filtrados_plot <- reactive({
    dados %>% 
      dplyr::filter(data == input$date) %>% 
      dplyr::group_by(companhia_aerea) %>% 
      dplyr::summarise(numero_voos = n())
  })
  
  dados_filtrados_atraso <- reactive({
    dados %>%
      dplyr::filter(data == input$date) %>%
      summarise(`Número de voos` = n(),
                `Atraso médio de partida (min)` = mean(atraso_saida, na.rm =  TRUE),
                `Atraso médio de chegada (min)` = mean(atraso_chegada, na.rm =  TRUE))
  })
  
  output$table <- renderTable({
    dados_filtrados_atraso()
  })
  
  output$barplot <- renderPlot({
    ggplot(data = dados_filtrados_plot(), 
           aes(x = companhia_aerea, y = numero_voos, fill = companhia_aerea)) +
      geom_col() +
      scale_fill_discrete() +
      labs(title = "Número de voos por empresa", x = "Empresa", y = "Número de voos") +
      theme_minimal() +
      theme(legend.position = "none")
  })
}

# shinyapp
shiny::shinyApp(ui, server)
