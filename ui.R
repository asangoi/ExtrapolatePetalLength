#ui.R
#setwd("C:\\Users\\16050\\All other stuff\\JHU class\\DataProducts")

library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("Extrapolating Petal Length"),
    sidebarPanel(
        selectInput("x", "Choose Species",c("setosa" = 1, "versicolor" = 2, "virginica" = 3),selected = 1),
        sliderInput('len', 'Adjust the Sepal Length',value = 6.5, min = 3.5, max = 10, step = 0.2)
    ),
    mainPanel(
        h5(textOutput("maintext")),
        plotOutput("newplot")
    )
))