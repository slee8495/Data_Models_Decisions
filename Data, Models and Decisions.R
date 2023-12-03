library(shiny)
library(shinythemes)
library(shinyWidgets)
library(DT)

ui <- fluidPage(
  theme = shinythemes::shinytheme("flatly"),
  tags$head(
    tags$style(HTML("
      .navbar .navbar-nav {
        width: 100%;
      }
      .search-bar {
        width: 200px;
        float: right;
        margin-top: 8px;
        margin-right: 10px;
      }
      .navbar-brand {
        font-size: 32px; 
        margin-bottom: 30px;
      }
    "))
  ),
  
  navbarPage(
    title = div(class = "navbar-brand", "Data, Models, and Decisions"),
    tabPanel("🏠"),
    navbarMenu("Introduction",
               tabPanel("About Me"),
               tabPanel("About the Book")
    ),
    navbarMenu("Case Study - My Interpretations/Solution",
               tabPanel("Chapter 1"),
               tabPanel("Chapter 2"),
               tabPanel("Chapter 3"),
               tabPanel("Chapter 4")
    ),
    # Custom Search Bar
    tags$ul(class = "nav navbar-nav navbar-right",
            tags$li(class = "search-bar",
                    textInput("searchInput", label = NULL, placeholder = "Search")
            )
    )
  )
)





server <- function(input, output, session) {
  # Server logic for search functionality (if needed)
}

shinyApp(ui = ui, server = server)
