library(shiny)
library(readxl)
library(tidyr)

tabtest2<-read.csv2("Tabtest.csv", header=TRUE, dec=",", sep=";", encoding = "latin1")
newtab2<-pivot_longer(tabtest2,c("Eau","Protéines", "Glucides", "Lipides", "Sucres", "Fibres.alimentaires", "AG.saturés","Sel"))
colnames(newtab2)<-c("nomr", "name", "value")
#write.csv2(newtab2, file="newtab2.csv")
newtab2


# Define UI for application that draws a histogram----
shinyUI(fluidPage(

    # Application title----
    titlePanel("Nutrisara"),

    # Sidebar with a slider input for number of bins----

    sidebarPanel(
            textInput("nompre", label = "Nom prenom operateur", value = "", width=NULL, placeholder=NULL),
            dateInput(inputId = "idDateCre", label = "Date de creation", value = NULL,
                  format = "dd/mm/yyyy", startview = "decade", weekstart = 0, language = "fr"),
            dateInput(inputId = "IDdate", label = "Date de mise a jour", value = NULL,
                  format = "dd/mm/yyyy", startview = "decade", weekstart = 0, language = "fr"),
            textInput("idrecette", label = "Recette", value = "", width=NULL, placeholder=NULL),
        #
            selectInput("nomI", "ingredient",choices = c(newtab2$nomr)),
            ),
            
    mainPanel(plotOutput("scatterPlot")),
        #
        downloadButton("report", "Generate report"),
        # Show a plot of the generated distribution----

            
        )
    )

