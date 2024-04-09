library(shiny)

ui <- fluidPage(
  
  titlePanel(title = "Interactive correlation plots"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      selectInput(inputId = "dataset",
                  label = "Select Dataset:",
                  choices = c("Data 1", "Data 2")),
      
      uiOutput("variable_inputs")
    ),
    mainPanel(
      
      plotOutput("correlation_plot"),
      tableOutput("data_head"),
      textOutput("correlation")
      
    )
  )
)