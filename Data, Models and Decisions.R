library(shiny)
library(shinythemes)
library(shinyWidgets)
library(DT)
library(rmarkdown)
library(shinyjs)

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
    id = "main_nav",
    title = div(class = "navbar-brand", "Data, Models, and Decisions"),
    tabPanel("🏠"),
    navbarMenu("Introduction",
               tabPanel("About Me", value = "about_me", uiOutput("about_me")), 
               tabPanel("About the Book", value = "about_the_book", uiOutput("about_the_book"))
    ),
    navbarMenu("Case Study - My Interpretations/Solution",
               tabPanel("Chapter 1: Decision Analysis", value = "chapter1",
                        fluidPage(
                          pickerInput("chapter1_select", "Choose a Case:",
                                      choices = c("Bill Sampras Summer Job Decision", 
                                                  "Case 2", 
                                                  "Case 3")),
                          uiOutput("chapter1_content"))),
               
               tabPanel("Chapter 2", value = "chapter2"),
               tabPanel("Chapter 3"),
               tabPanel("Chapter 4")
    ),
    
    
  )
)

##########################################################################################################################################
##########################################################################################################################################
##########################################################################################################################################
##########################################################################################################################################
##########################################################################################################################################



server <- function(input, output, session) {
  active_tab <- reactiveVal("home")
  
  
  
  
  ################################################## About Me ##################################################
  observeEvent(input$main_nav, {
    if(input$main_nav == "about_me") {
      rendered_html <- rmarkdown::render("about_me.Rmd", output_dir = "www", output_file = "about_me.html")
      
      active_tab(input$main_nav)
    }
  })
  
  output$about_me <- renderUI({
    if (active_tab() == "about_me") {
      tags$iframe(src = "about_me.html", style = "width:100%; height:1000px;")
    }
  })
  
  active_tab <- reactiveVal("home")
  
  
  
  ################################################## About The Book ##################################################
  observeEvent(input$main_nav, {
    if(input$main_nav == "about_the_book") {
      rendered_html <- rmarkdown::render("about_the_book.Rmd", output_dir = "www", output_file = "about_the_book.html")
      
      active_tab(input$main_nav)
    }
  })
  
  output$about_the_book <- renderUI({
    if (active_tab() == "about_the_book") {
      tags$iframe(src = "about_the_book.html", style = "width:100%; height:1000px;")
    }
  })
  
  active_tab <- reactiveVal("home")
  
  
  ################################## Chapter 1: Descision Analysis ###########################################
  
  
  output$chapter1_content <- renderUI({
    req(input$chapter1_select) 
    
    file_name <- switch(input$chapter1_select,
                        "Bill Sampras Summer Job Decision" = "chap1_subchap_1_case_1.html",
                        "Case 2" = "chap1_subchap_1_case_2.html",
                        "Case 3" = "case3.html")
    
    if (!is.null(file_name)) {
      tags$iframe(src = file_name, style = "width:100%; height:1000px;")
    }
  })
  
  observeEvent(input$main_nav, {
    active_tab(input$main_nav)
  })
  
}

shinyApp(ui = ui, server = server)
