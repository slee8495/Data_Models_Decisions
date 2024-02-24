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

      .navbar-brand {
        font-size: 25px; 
        margin-bottom: 30px;
        font-family: 'Verdana', sans-serif; 
      }
    "))
  ),
  
  navbarPage(
    id = "main_nav",
    title = div(class = "navbar-brand", "Sangho's Business Analytics Case Study & Solutions"),
    tabPanel("🏠", value = "home", uiOutput("home")),
    navbarMenu("Introduction",
               tabPanel("Overview", value = "overview", uiOutput("overview")), 
               tabPanel("About Me", value = "about_me", uiOutput("about_me")), 
               tabPanel("About the Book", value = "about_the_book", uiOutput("about_the_book"))
    ),
    navbarMenu("Case Study - My Interpretations/Solutions",
               tabPanel("Chapter 1: Decision Analysis", value = "chapter1",
                        fluidPage(
                          pickerInput("chapter1_select", "Choose a Case:",
                                      choices = c("Bill Sampras Summer Job Decision", 
                                                  "Bio-Imaging Development Strategies")),
                          uiOutput("chapter1_content"))),
               
               
               tabPanel("Chapter 6: Regression Models: Concepts and Practice", value = "chpater6",
                        fluidPage(
                          pickerInput("chapter6_select", "Choose a Case:",
                                      choices = c("The Construction Department at Croq'Pain")),
                          uiOutput("chapter6_content")))
               
    ),
    navbarMenu("Real Field - Hands on Applied Projects",
               tabPanel("Supply Chain Analytics", value = "sc_analytics",
                        fluidPage(
                          pickerInput("sup1_select", "Choose a Case:",
                                      choices = c("Under Construction: Analyizing")),
                          uiOutput("sup1_content")
                        )),
               
               
               tabPanel("People Analytics", value = "pep_analytics",
                        fluidPage(
                          pickerInput("pep1_select", "Choose a Case:",
                                      choices = c("Forecasting Attrition Rates for Each Manufacturing Facility")),
                          uiOutput("pep1_content")
                        ))
               
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
  
  
  ################################################## Home ##################################################
  observeEvent(input$main_nav, {
    if(input$main_nav == "home") {
      rendered_html <- rmarkdown::render("home.Rmd", output_dir = "www", output_file = "home.html")
      
      active_tab(input$main_nav)
    }
  })
  
  output$home <- renderUI({
    if (active_tab() == "home") {
      tags$iframe(src = "home.html", style = "width:100%; height:800px;")
    }
  })
  
  active_tab <- reactiveVal("home")
  
  ################################################## Overview ##################################################
  observeEvent(input$main_nav, {
    if(input$main_nav == "overview") {
      rendered_html <- rmarkdown::render("overview.Rmd", output_dir = "www", output_file = "overview.html")
      
      active_tab(input$main_nav)
    }
  })
  
  output$overview <- renderUI({
    if (active_tab() == "overview") {
      tags$iframe(src = "overview.html", style = "width:100%; height:800px;")
    }
  })
  
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
      tags$iframe(src = "about_me.html", style = "width:100%; height:800px;")
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
      tags$iframe(src = "about_the_book.html", style = "width:100%; height:800px;")
    }
  })
  
  active_tab <- reactiveVal("home")
  
  
  ################################## Chapter 1: Descision Analysis ###########################################
  
  
  output$chapter1_content <- renderUI({
    req(input$chapter1_select) 
    
    file_name <- switch(input$chapter1_select,
                        "Bill Sampras Summer Job Decision" = "Chapter_1_bill_sampras_summer_job_decision.html",
                        "Bio-Imaging Development Strategies" = "Chapter_1_bio_imaging_development_strategies.html")
    
    if (!is.null(file_name)) {
      tags$iframe(src = file_name, style = "width:100%; height:800px;")
    }
  })
  
  observeEvent(input$main_nav, {
    active_tab(input$main_nav)
  })
  





################################## Chapter 6: Regression Models: Concepts and Practice ###########################################


output$chapter6_content <- renderUI({
  req(input$chapter6_select) 
  
  file_name <- switch(input$chapter6_select,
                      "The Construction Department at Croq'Pain" = "Chapter_6_the_construction_department_at_croqpain.html")
  
  if (!is.null(file_name)) {
    tags$iframe(src = file_name, style = "width:100%; height:800px;")
  }
})

observeEvent(input$main_nav, {
  active_tab(input$main_nav)
})



################################## Supply Chain Analytics ###########################################


output$sup1_content <- renderUI({
  req(input$sup1_select) 
  
  file_name <- switch(input$sup1_select,
                      "Under Construction: Analyzing" = "under_construction.html")
  
  if (!is.null(file_name)) {
    tags$iframe(src = file_name, style = "width:100%; height:800px;")
  }
})

observeEvent(input$main_nav, {
  active_tab(input$main_nav)
})




################################## People Analytics - Forecasting Attrition rate ###########################################


output$pep1_content <- renderUI({
  req(input$pep1_select) 
  
  file_name <- switch(input$pep1_select,
                      "Forecasting Attrition Rates for Each Manufacturing Facility" = "people_analytics_forecasting_attrition.html")
  
  if (!is.null(file_name)) {
    tags$iframe(src = file_name, style = "width:100%; height:800px;")
  }
})

observeEvent(input$main_nav, {
  active_tab(input$main_nav)
})





#########################################################################################################################################################


}

shinyApp(ui = ui, server = server)


