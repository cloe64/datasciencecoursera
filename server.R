#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   optionInput <- reactive({
    switch(input$option,
           "rock" = rock, 
           "pressure" = pressure,
           "cars" = cars)
  })
   model<-reactive({
     if (input$plot_type=="Visualize rock"){
       brushed_data<-brushedPoints(rock,input$brush1,
                                   xvar="peri",yvar="area")
       if(nrow(brushed_data)<2){
         return(NULL)
       }
       lm(area~peri,data=brushed_data)
     }else if(input$plot_type=="Visualize pressure"){
       brushed_data<-brushedPoints(pressure,input$brush1,
                                   xvar="temperature",yvar="pressure")
       if(nrow(brushed_data)<2){
         return(NULL)
       }
       lm(pressure~temperature,data=brushed_data)
     }else if (input$plot_type=="Visualize cars"){    
       brushed_data<-brushedPoints(cars,input$brush1,
                              xvar="speed",yvar="dist")
     if(nrow(brushed_data)<2){
       return(NULL)
     }
     lm(dist~speed,data=brushed_data)}
   })
  output$slopeOut <- renderText({
    if(is.null(model())){
      "No Model Found"
    }else{
      round(model()[[1]][2],2)
    }
  })  
  output$intOut <- renderText({
    if(is.null(model())){
      "No Model Found"
    }else{
      round(model()[[1]][1],2)
    }
  }) 
  output$summary<-renderPrint({
    optionchoice<-optionInput()
    summary(optionchoice)
  })
  output$plot1<-renderPlot({
    optionchoice<-optionInput()
    if(input$plot_type=="Visualize rock")
    {
      plot(rock$peri,rock$area,xlab="peri",
           ylab="area",main="perimeter vus area for rock samples",
           cex=1.5,pch=16,bty="n")
      if(!is.null(model())){
        abline(model(),col="red",lwd=2)
      }
    }
    else if(input$plot_type=="Visualize pressure")
    {
      plot(pressure$temperature,pressure$pressure,xlab="temperature",
           ylab="pressure",main="Vapor Pressure of Mercury",
           cex=1.5,pch=16,bty="n")
      if(!is.null(model())){
        abline(model(),col="red",lwd=2)
      }
    }
    else if(input$plot_type=="Visualize cars")
    {
    plot(cars$speed,cars$dist,xlab="speed",
         ylab="dist",main="Speed and Stopping Distances of Cars",
         cex=1.5,pch=16,bty="n")
    if(!is.null(model())){
      abline(model(),col="red",lwd=2)
    }
    }
  })
    
  })
  
