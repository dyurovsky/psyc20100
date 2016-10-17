library(dplyr)
library(ggplot2)
library(shiny)

ui <- shinyUI(pageWithSidebar(
  
  headerPanel = ("Power for detecting coin flip clairvoyance"),

  sidebarPanel(
    
    sliderInput("n", 
                "Sample size:", 
                value = 4,
                min = 1, 
                max = 1000),
    br(),
    
    sliderInput("percentile", 
                "Two-tail rejection percentile", 
                value = .025,
                min = .001, 
                max = .25),
    br(),
    
    sliderInput("true_prob", 
                "True guessing probability", 
                value = .75,
                min = .0, 
                max = 1)
    ),
  
  
  mainPanel(
    plotOutput("prob_plot")
    
    )))
  
  
server <- shinyServer(function(input, output) {
  
  output$prob_plot <- renderPlot({
    
    data <- c("H", "T")
    
    sample_func <- function(n) mean(sample(data, n, replace = TRUE) == "H")
    
    upper_percentile <- function(samples) {
      sort(samples)[length(samples) - (input$percentile * length(samples))]
    }
    
    lower_percentile <- function(samples) {
      sort(samples)[input$percentile * length(samples)]
    }
    
    
    samples <- replicate(10000, sample_func(input$n))
    bottom <- lower_percentile(samples)
    top <- upper_percentile(samples)
    
    samples %>%
      qplot() + 
      geom_vline(xintercept = bottom, color = "lightgray", size = 2) +
      geom_vline(xintercept = top, color = "lightgray", size = 2) +
      geom_vline(xintercept = input$true_prob, color = "darkred", size = 2) +
      theme_bw()
  })
})

shinyApp(ui = ui, server = server)

