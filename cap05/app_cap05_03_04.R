library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  
  dashboardHeader(),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Página 1", tabName = "pagina1"),
      menuItem("Página 2", tabName = "pagina2")
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "pagina1"),
      tabItem(tabName = "pagina2")
    )
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)