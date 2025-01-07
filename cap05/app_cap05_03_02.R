library(shiny)

ui <- navbarPage(
  title = "Shiny com navbarPage",
  tabPanel(title = "Painel 1"),
  tabPanel(title = "Painel 2"),
  tabPanel(title = "Painel 3"),
  navbarMenu(
    title = "Mais opções",
    tabPanel(title = "Item 1"),
    tabPanel(title = "Item 2"),
    tabPanel(title = "Item 3")
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)