# packages
library(shiny)
library(dados)
library(tidyverse)

# data
pixar_avalicao_publico
pixar_bilheteria
pixar_equipe
pixar_filmes
pixar_generos
pixar_oscars

# ui
ui <- fluidPage(
  
  dateRangeInput(inputId = "lancamento", 
                 label = "Data de lançamento", 
                 start = min(pixar_filmes$data_lancamento), 
                 end = max(pixar_filmes$data_lancamento)),
  tableOutput(outputId = "pixar_filmes_data_lancamento"),
  
)

# server
server <- function(input, output, session) {
  
  pixar_filmes_data <- reactive({
    
    pixar_filmes %>% 
      dplyr::left_join(pixar_bilheteria) %>% 
      dplyr::left_join(pixar_generos) %>%   
      dplyr::left_join(pixar_oscars)  %>% 
      dplyr::left_join(pixar_avalicao_publico) %>% 
      dplyr::select(ordem_lancamento, filme, data_lancamento,
                    orcamento, bilheteria_eua_canada, bilheteria_outros_paises,
                    bilheteria_mundial, genero, tipo_premio_indicado, 
                    nota_rotten_tomatoes, nota_metacritic, 
                    nota_cinema_score, nota_critics_choice)
    
  })
  
  output$pixar_filmes_data_lancamento <- renderTable({
    pixar_filmes_data()
  })
  
}

# app
shinyApp(ui, server)