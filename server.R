library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    #output$distPlot <- renderPlot({

    output$report <- downloadHandler(
        filename = "report.pdf",
        content = function(file) {
            
            tempReport <- file.path(tempdir(), "report.Rmd")
            file.copy("report.Rmd", tempReport, overwrite = TRUE)
            
            # Set up parameters to pass to Rmd document
            params <- list(n = c(input$nompre, input$idDateCre))
            
            # Knit the document, passing in the `params` list, and eval it in a
            # child of the global environment (this isolates the code in the document
            # from the code in this app).
            rmarkdown::render(tempReport, output_file = file,
                              params = params,
                              envir = new.env(parent = globalenv())
            )
            
            output$dateText  <- renderText({
                paste("input$date is", as.character(input$date))
            })

    })
})

