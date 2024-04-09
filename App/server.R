library(shiny)
library(tidyverse)
library(ggplot2)

server <- function(input, output, session) {
  
  observeEvent(input$dataset, {
    
    if (input$dataset == "Data 1") {
      output$variable_inputs <- renderUI({
        tagList(
          selectInput(inputId = "var_x",
                      label = "Health Variable (X-axis):",
                      choices = colnames(data)),
          
          selectInput(inputId = "var_y",
                      label = "Health Variable (Y-axis):",
                      choices = colnames(data)),
          
          selectInput(inputId = "var_z",
                      label = "Select variable for color:",
                      choices = colnames(data)),
          
        )
      })
      
    } else if (input$dataset == "Data 2") {
      output$variable_inputs <- renderUI({
        tagList(
          selectInput(inputId = "var_x",
                      label = "Air Quality Variable (X-axis):",
                      choices = colnames(data2)),
          
          selectInput(inputId = "var_y",
                      label = "Air Quality Variable (Y-axis):",
                      choices = colnames(data2)),
          
          selectInput(inputId = "var_z",
                      label = "Select variable for color:",
                      choices = colnames(data2))
          
        )
      })
    }
    
  })
  
  output$correlation_plot <- renderPlot({
    if (input$dataset == "Data 1") {
      ggplot(data = data, aes(x = .data[[input$var_x]], y = .data[[input$var_y]], color = as.factor(.data[[input$var_z]]))) +
        geom_point() +
        labs(x = input$var_x, y = input$var_y) +
        theme_bw()
      
    } else if (input$dataset == "Data 2") {
      ggplot(data = data2, aes(x = .data[[input$var_x]], y = .data[[input$var_y]], color = as.factor(.data[[input$var_z]]))) +
        geom_point() +
        labs(x = input$var_x, y = input$var_y) +
        theme_bw()
    }
  })
  
  output$data_head <- renderTable({
    if (input$dataset == "Data 1") {
      data %>% group_by(State) %>% summarize_all(mean)
      
    } else if (input$dataset == "Data 2") {
      data2 %>% group_by(State) %>% summarize_all(mean)
    }
  }, spacing = "xs")
  
  output$correlation <- renderText({
    if (input$dataset == "Data 1") {
      paste("Correlation coefficient for Data 1:", round(cor(data[[input$var_x]], data[[input$var_y]])[1], 2), sep = " ")
      
    } else if (input$dataset == "Data 2") {
      paste("Correlation coefficient for Data 2:", round(cor(data2[[input$var_x]], data2[[input$var_y]])[1], 2), sep = " ")
    }
  })
  
}
