library(shiny)

tabtest <- read_excel("Tabtestb.xls")
newtab<- pivot_longer(tabtest, c("Eau", "Proteines", "Glucides", "Lipides", "Sucres", "FibresAlimentaires", "AGsat", "Sel", "Autre", "total"), names_to = "class", values_to = "pourcentage")


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
        selectInput("nom", "ingredient",choices = c(tabtest$nom)),
        #
        downloadButton("report", "Generate report")
),
        # Show a plot of the generated distribution----
        mainPanel(
            plotOutput("piePlot"),
            
        )
    )
)
