#server.R
library(shiny)
library(datasets)
library(ggplot2)
data(iris)

fitList <- lapply(split(iris,iris$Species), lm, formula=Petal.Length~Sepal.Length)

shinyServer(function(input, output){
    output$newplot <- renderPlot({
        y <- reactive({summary(fitList[[as.numeric(input$x)]])$coef[1,1] + 
                           input$len * summary(fitList[[as.numeric(input$x)]])$coef[2,1]})        
        plot(iris$Sepal.Length, iris$Petal.Length, col=iris$Species, pch=20, cex=2,
             xlab="Sepal Length", ylab="Petal Length", xlim=c(3.5,10), ylim=c(1,8))
        abline(summary(fitList[[1]])$coef[1,1], summary(fitList[[1]])$coef[2,1], col=1)
        abline(summary(fitList[[2]])$coef[1,1], summary(fitList[[2]])$coef[2,1], col=2)
        abline(summary(fitList[[3]])$coef[1,1], summary(fitList[[3]])$coef[2,1], col=3)
        points(input$len, y(), col="darkblue", pch = 4, cex = 2.5, lwd = 4)    
        legend("topleft", legend=c("setosa", "versicolor","virginica"), col=c(1,2,3), pch=19, cex=1.5)
    })
    output$maintext <- renderText({"First choose the Sepcies. Then play with the slider.
                                   The slider adjusts the Sepal Width.
                                   The server.R code then calculates the Petal Width.
                                   A simple lm model is used for extrapolating the Petal width, 
                                   so all the extrapolated values will fall on the fitted line"})
})    
    
