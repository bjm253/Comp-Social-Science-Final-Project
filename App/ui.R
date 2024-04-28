library(shiny)

ui <- fluidPage(
  
  titlePanel(title = "Mental Health and Air Quality"),
  
  tabsetPanel(
    tabPanel("Bootstrap Analysis",
             fluidRow(
               column(width = 6,
                      selectInput("numIterations", "Choose Number of Iterations:", choices = c(1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000), selected = 1000)
               )
             ),
             fluidRow(
               column(width = 6,
                      titlePanel("Air BootStrap Graph"),
                      plotOutput("air_bootstrap_plot")
               ),
               column(width = 6,
                      titlePanel("Mental Health BootStrap Graph"),
                      plotOutput("health_bootstrap_plot")
               )
             ),
             fluidRow(
               column(width = 6,
                      titlePanel("Air Quality Top 10 Highest Values"),
                      tableOutput("top_air_states")
               ),
               column(width = 6,
                      titlePanel("Mental Health Quality Top 10 Highest Values"),
                      tableOutput("health_top_10_states")
               )
             )
    ),
    
    tabPanel("Mental Health Data",
             selectInput(inputId = "var_x",
                         label = "Health Variable (X-axis):",
                         choices = colnames(data)[5]),
             
             selectInput(inputId = "var_y",
                         label = "Health Variable (Y-axis):",
                         choices = colnames(data)[4]),
             
             selectInput(inputId = "var_z",
                         label = "Select variable for color:",
                         choices = colnames(data)[-4:-5]),
             
             plotOutput("correlation_plot1"),
             tableOutput("data_head1"),
             textOutput("correlation1")
    ),
    
    tabPanel("Air Quality Data",
             selectInput(inputId = "var_x2",
                         label = "Air Quality Variable (X-axis):",
                         choices = colnames(data2)[3]),
             
             selectInput(inputId = "var_y2",
                         label = "Air Quality Variable (Y-axis):",
                         choices = colnames(data2)[4]),
             
             selectInput(inputId = "var_z2",
                         label = "Select variable for color:",
                         choices = colnames(data2)[2]),
             
             plotOutput("correlation_plot2"),
             tableOutput("data_head2"),
             textOutput("correlation2")
    )
  )
)
