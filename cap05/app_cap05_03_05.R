library(shiny)
library(bs4Dash)

ui <- bs4DashPage(
  bs4DashNavbar(),
  bs4DashSidebar(
    bs4SidebarMenu(
      bs4SidebarMenuItem("Página 1", tabName = "pagina1"),
      bs4SidebarMenuItem("Página 2", tabName = "pagina2")
    )
  ),
  bs4DashBody(
    tabItems(
      tabItem(tabName = "pagina1"),
      tabItem(tabName = "pagina2")
    )
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)