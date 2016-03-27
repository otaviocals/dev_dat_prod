library(shiny)
library(ggplot2)
library(markdown)

shinyServer(function(input, output) {
  
  
  
  datasetInput <- reactive({
    switch(input$dataset,
           "iris" =  iris,
           "iris3" =  iris3,
           "mtcars" =  mtcars,
           "Select a File" = NULL)
  })
  
  
  output$file <- renderUI({
    if (input$dataset=="Select a File")
        fileInput('file1', 'Choose CSV File',
                  accept=c('text/csv', 
                           'text/comma-separated-values,text/plain', 
                           '.csv'))
    })
   
  
  fileLoader <- reactive({input$file1})
  
  filedata <- reactive({
    
    inFile <- fileLoader()
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath,  header=TRUE, sep=",", quote='"')
  }) 
  
  datasetInput2 <- filedata
  
  inFile <- reactive({
    if (input$dataset!="Select a File")
      return(NULL)
  })
  
  
  
  output$controls <- renderUI({
    if (!is.null(datasetInput())){
     tagList(
          sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(datasetInput()),value=15, step=1),
        
          selectInput('x', 'X axis', names(datasetInput())),
          selectInput('y', 'Y axis', names(datasetInput()), names(datasetInput())[[2]]),
      
          selectInput('color', 'Color', c('None', names(datasetInput()))),
      
          checkboxInput('jitter', 'Jitter'),
          checkboxInput('smooth', 'Smooth'),
    
          selectInput('facet_row', 'Facet Row', c(None='.', names(datasetInput()))),
          selectInput('facet_col', 'Facet Column', c(None='.', names(datasetInput())))
      )
    }
    })
  
  output$controls2 <- renderUI({
    if (!is.null(datasetInput2()) && input$dataset=="Select a File"){
      tagList(
        sliderInput('sampleSize2', 'Sample Size', min=1, max=nrow(datasetInput2()),value=15, step=1),
        
        selectInput('x2', 'X axis', names(datasetInput2())),
        selectInput('y2', 'Y axis', names(datasetInput2()), names(datasetInput2())[[2]]),
        
        selectInput('color2', 'Color', c('None', names(datasetInput2()))),
        
        checkboxInput('jitter2', 'Jitter'),
        checkboxInput('smooth2', 'Smooth'),
        
        selectInput('facet_row2', 'Facet Row', c(None='.', names(datasetInput2()))),
        selectInput('facet_col2', 'Facet Column', c(None='.', names(datasetInput2())))
      )
    }
  })
  
  
  

  
  sampledInput <- reactive({
    if (!is.null(datasetInput()) && input$dataset!="Select a File")
      return(datasetInput()[sample(nrow(datasetInput()), input$sampleSize),])
    if (!is.null(datasetInput2()) && input$dataset=="Select a File")
      return(datasetInput2()[sample(nrow(datasetInput2()), input$sampleSize2),])
    })
  
  
  
  output$plot <- renderPlot( {
    if (input$dataset!="Select a File"){
      p <- ggplot(sampledInput(), aes_string(x=input$x, y=input$y)) + geom_point()
    
      if (input$color != 'None')
        p <- p + aes_string(color=input$color)
    
      facets <- paste(input$facet_row, '~', input$facet_col)
      if (facets != '. ~ .')
        p <- p + facet_grid(facets)
    
      if (input$jitter)
        p <- p + geom_jitter()
      if (input$smooth)
        p <- p + geom_smooth()
    
      print(p)
    }
    else if (input$dataset=="Select a File" && !is.null(datasetInput2())){
      p2 <- ggplot(sampledInput(), aes_string(x=input$x2, y=input$y2)) + geom_point()
      
      if (input$color2 != 'None')
        p2 <- p2 + aes_string(color=input$color2)
      
      facets <- paste(input$facet_row2, '~', input$facet_col2)
      if (facets != '. ~ .')
        p2 <- p2 + facet_grid(facets)
      
      if (input$jitter2)
        p2 <- p2 + geom_jitter()
      if (input$smooth2)
        p2 <- p2 + geom_smooth()
      
      print(p2)
    }
  }, height=650)
  
})
