# packages
library(shiny)
library(tidyverse)
library(dados)

# dados
dados <- voos %>% 
  dplyr::mutate(data = lubridate::as_date(data_hora))
dados

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
  
  # dados_filtrados_atraso_voos <- reactive({
  #   dados %>% 
  #     dplyr::filter(data == input$date) %>% 
  #     summarise(`Número de voos` = n())
  # })
  # 
  # dados_filtrados_atraso_saida <- reactive({
  #   dados %>% 
  #     dplyr::filter(data == input$date,
  #                   atraso_saida > 0) %>% 
  #     summarise(`Atraso médio de partida (min)` = mean(atraso_saida, na.rm =  TRUE))
  # })
  # 
  # dados_filtrados_atraso_chegada <- reactive({
  #   dados %>% 
  #     dplyr::filter(data == input$date,
  #                   atraso_chegada > 0) %>% 
  #     summarise(`Atraso médio de chegada (min)` = mean(atraso_chegada, na.rm =  TRUE))
  # })
  # 
  # dados_filtrados_atraso <- reactive({
  #   bind_cols(dados_filtrados_atraso_voos,
  #             dados_filtrados_atraso_saida, 
  #             dados_filtrados_atraso_chegada)
  # })
  # 
  # output$table <- renderTable({
  #   req(dados_filtrados_atraso())
  #   dados_filtrados_atraso()
  # })
  
  output$barplot <- renderPlot({
    req(dados_filtrados_plot())
    ggplot(data = dados_filtrados_plot(), x = companhia_aerea, y = numero_voos) +
      geom_bar() +
      labs(title = "Número de voos por empresa", x = "Empresa", y = "Número de voos")
  })
}

# shinyapp
shiny::shinyApp(ui, server)
