#install.packages("ggplot2")
#install.packages("gridExtra")

library(ggplot2)
library(gridExtra)

#brownian motion
brownian_motion  <- function (n_particles, h = 0.25) {
  
  df <- data.frame(x = rep(NA, n_particles), y = rep(NA, n_particles), time = 1:n_particles)
  
  df[1,] <- c(0,0,1)
  
  for (i in 2:n_particles) {
    #setting the standard deviation for the normal distribution as normal distribution (sigma) is a fundamental property of the displacements of a particle in Brownian motion
    sigma <- h * sqrt(i-1) #setting h to be proportional to sigma by multiplying h by a scaling factor (sqrt of the time step)
    
    angle <- runif(1, min = 0, max = 2*pi)
    
    df[i,1] <- df[i-1,1] + cos(angle)*sigma
    
    df[i,2] <- df[i-1,2] + sin(angle)*sigma
    
    df[i,3] <- i
    
  }
  
  return(df)
  
}

set.seed(123) # Setting a seed for reproducibility

data1 <- brownian_motion(1000)

plot1 <- ggplot(aes(x = x, y = y), data = data1) +
  
  geom_path(aes(colour = time)) +
  
  theme_bw() +
  
  xlab("x-coordinate") +
  
  ylab("y-coordinate")


data2 <- brownian_motion(1000)
plot2 <- ggplot(aes(x = x, y = y), data = data2) +
  
  geom_path(aes(colour = time)) +
  
  theme_bw() +
  
  xlab("x-coordinate") +
  
  ylab("y-coordinate")

grid.arrange(plot1, plot2, ncol=2)


