library(shiny)
library(tidyverse)
library(ggplot2)

server <- function(input, output, session) {
  
  output$correlation_plot1 <- renderPlot({
    ggplot(data = data, aes(x = .data[[input$var_x]], y = .data[[input$var_y]], color = as.factor(.data[[input$var_z]]))) +
      geom_point() +
      labs(x = input$var_x, y = input$var_y) +
      theme_bw()
  })
  
  output$data_head1 <- renderTable({
    data %>% 
      group_by(State) %>% 
      summarize(Value = mean(Value)) %>%
      arrange(desc(Value)) %>% 
      head(10)
  }, spacing = "xs")
  
  output$correlation1 <- renderText({
    paste("Correlation coefficient for Mental Health Data:", round(cor(data[[input$var_x]], data[[input$var_y]])[1], 2), sep = " ")
  })
  
  output$correlation_plot2 <- renderPlot({
    ggplot(data = data2, aes(x = .data[[input$var_x2]], y = .data[[input$var_y2]], color = as.factor(.data[[input$var_z2]]))) +
      geom_point() +
      labs(x = input$var_x2, y = input$var_y2) +
      theme_bw()
  })
  
  output$data_head2 <- renderTable({
    data2 %>%
      group_by(State) %>%
      summarize(Value = mean(Value)) %>%
      arrange(desc(Value)) %>% 
      head(10)
  }, spacing = "xs")
  
  output$correlation2 <- renderText({
    paste("Correlation coefficient for Air Quality Data:", round(cor(data2[[input$var_x2]], data2[[input$var_y2]])[1], 2), sep = " ")
  })
  
  #BootStrap Sampling Code
  
  observeEvent(input$numIterations, {
    # Set the number of bootstrap iterations
    num_iterations <- input$numIterations
    
    # Empty vector to store sample
    air_bootstrap_means <- numeric(num_iterations)
    
    # Air Boot Strap sample
    for (i in 1:num_iterations) {
      bootstrap_indices <- sample(nrow(data2), size = num_iterations, replace = TRUE)
      air_bootstrap_sample <- data2[bootstrap_indices, c("State", "Value")]
      air_bootstrap_means[i] <- mean(air_bootstrap_sample$Value)
    }
    
    # Create a histogram of the bootstrap sample means for air_df
    output$air_bootstrap_plot <- renderPlot({
      ggplot() +
        geom_histogram(aes(x = air_bootstrap_means), bins = 20, fill = "blue", color = "black") +
        labs(title = "Bootstrap Resample Means - Air", x = "Mean", y = "Frequency")
    })
    
    # Air Top 10 States Code
    air_average_by_state <- air_bootstrap_sample %>%
      group_by(State) %>%
      summarize(Average_Value = mean(Value, na.rm = TRUE))
    
    air_sorted_states <- air_average_by_state %>%
      arrange(desc(Average_Value))
    
    air_top_10_states <- head(air_sorted_states, 10)
    
    # Render the table for the top 10 states of air_df
    output$top_air_states <- renderTable({
      air_top_10_states
    }, spacing = "xs")
  })
  
  #Observe needed so that output table updates during R shiny
  observeEvent(input$numIterations, {
    # Set the number of bootstrap iterations
    num_iterations <- input$numIterations
    
    health_bootstrap_means <- numeric(num_iterations)
    
    # Health Boot Strap
    for (i in 1:num_iterations) {
      bootstrap_indices <- sample(nrow(data), size = num_iterations, replace = TRUE)
      health_bootstrap_sample <- data[bootstrap_indices, c("State", "Value")]
      health_bootstrap_means[i] <- mean(health_bootstrap_sample$Value)
    }
    
    # Create a histogram of the bootstrap resample means for health_df
    output$health_bootstrap_plot <- renderPlot({
      ggplot() +
        geom_histogram(aes(x = health_bootstrap_means), bins = 20, fill = "red", color = "black") +
        labs(title = "Bootstrap Resample Means - Health", x = "Mean", y = "Frequency")
    })
    
    # Top 10 States Code - Health
    health_average_by_state <- health_bootstrap_sample %>%
      group_by(State) %>%
      summarize(Average_Value = mean(Value, na.rm = TRUE))
    
    health_sorted_states <- health_average_by_state %>%
      arrange(desc(Average_Value))
    
    health_top_10_states <- head(health_sorted_states, 10)
    
    # Render the table for the top 10 states of health_df
    output$health_top_10_states <- renderTable({
      health_top_10_states
    }, spacing = "xs")
  })
}