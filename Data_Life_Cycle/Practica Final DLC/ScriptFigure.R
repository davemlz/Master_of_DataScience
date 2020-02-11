createFigure = function(x){
  
  jpeg("rplot.jpg", width = 350, height = 350)
  plot(x$Petal.Length, x$Petal.Width,
        pch = 16, frame = FALSE,asp = 1,
        xlab = "Petal Length", ylab = "Petal Width", col = x$Species)
  dev.off()
  
}

createFigure(iris)
