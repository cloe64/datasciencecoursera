#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Visulaize Linear Model"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       selectInput(inputId = "option",
                   label = "Choose a dataset:",
                   choices = c("rock", "pressure","cars")),
       radioButtons("plot_type","Select the plot to play with",
                    c("Visualize rock","Visualize pressure","Visualize cars")),
       h4("Slope from linear model"),
       textOutput("slopeOut"),
       h4("Intercept from linear model"),
       textOutput("intOut")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h4("Data Summary"),
      verbatimTextOutput("summary"),
      h4("Plot"),
      h5("Choose data points in the plot and then automaticlly generate the preditive line corresponed with the linear model from the chosen data"),
      plotOutput("plot1",brush=brushOpts(
         id="brush1"
       ))
    )
  )
))
