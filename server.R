library(shiny)
library(tidyverse)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    #output$distPlot <- renderPlot({

    output$report <- downloadHandler(
        filename = "report.pdf",
        content = function(file) {
            
            tempReport <- file.path(tempdir(), "report.Rmd")
            file.copy("report.Rmd", tempReport, overwrite = TRUE)
            
            # Set up parameters to pass to Rmd document
            params <- list(nom = input$nompre, dateCre = input$idDateCre, datemsj = input$IDdate, nrecette = input$idrecette, tab = head(cars))
            
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
    
   
        output$scatterPlot <- renderPlot({
            tabtest2<-read.csv2("Tab.csv", header=TRUE, dec=",", sep=";", encoding = "latin1")
            newtab2<-pivot_longer(tabtest2,c("Eau","Protéines", "Glucides", "Lipides", "Sucres", "Fibres.alimentaires", "AG.saturés","Sel"))
            colnames(newtab2)<-c("nomr", "name", "value")
            #newtab3 <- filter(newtab2, newtab2$nomr == "Dessert (aliment moyen)")
            newtab3 <- filter(newtab2, newtab2$nomr == input$nomI)
            ggplot(data = newtab3) + 
                geom_point(mapping = aes(x = name, y = value))
        #})
    })
})
