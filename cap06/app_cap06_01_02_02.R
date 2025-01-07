# Esse exemplo não pode ser rodado,
# pois a função conectar_com_o_banco()
# não existe.

library(shiny)

ui <- fluidPage(
  titlePanel("Últimos 10 jogos do time"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "temporada",
        label = "Selecione uma temporada",
        choices = 2003:2022
      ),
      uiOutput("select_time")
    ),
    mainPanel(
      tableOutput("tabela")
    )
  )
)

server <- function(input, output, session) {
  
  dados <- reactive({
    con <- conectar_com_o_banco()
    dplyr::tbl(con, "partidas") |> 
      dplyr::filter(season == input$temporada) |> 
      dplyr::collect()
  })
  
  output$select_time <- renderUI({
    selectInput(
      "time",
      label = "Selecione um time",
      choices = unique(dados()$home)
    )
  })
  
  output$tabela <- renderTable({
    dados() |>
      dplyr::filter(
        score != "x",
        home == input$time | away == input$time
      ) |>
      dplyr::slice_max(order_by = date, n = 10) |>
      dplyr::mutate(
        date = format(date, "%d/%m/%Y")
      ) |>
      dplyr::select(date, home, score, away)
  })
  
}

shinyApp(ui, server)