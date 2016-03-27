library(shiny)
library(ggplot2)
library(markdown)
data(mtcars)

dataset <- iris

shinyUI(pageWithSidebar(
  
  headerPanel("Database Explorer"),
  
  sidebarPanel(
    
    selectInput("dataset", "Choose a dataset:", 
                choices = c("iris", "mtcars", "Select a File")),
    tags$hr(),
    uiOutput("file"),
    uiOutput("controls"),
    uiOutput("controls2")
  ),
  
 
  
  mainPanel(
    tabsetPanel(
      tabPanel("Plot", plotOutput('plot')),
      tabPanel("Documentation", includeMarkdown("include.md"))
    )
  )
  
))