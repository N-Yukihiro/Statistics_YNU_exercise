library(pacman)
p_load(tibble, ggplot2)
par <- tibble(lambda = 1:9)

ggplot() +
  xlim(0, 20) +
  mapply(
    \(lambda, colour){
      geom_function(fun  = dpois, 
                    n    = 21,
                    args = list(lambda = lambda),
                    aes(colour = colour))
    },
    par$lambda, 
    sprintf("lambda=%.0f", par$lambda)) +
  ylab("")