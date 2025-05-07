library(pacman)
pacman::p_load(tidyr, ggplot2)
par <- expand_grid(
  mean = c(-2, 0, 2),
  sd   = c(.5, 1, 2))
ggplot() +
  xlim(-6, 6) +
  # aes(xmin = -6, xmax = 6) +
  mapply(
    \(mean, sd, colour)
    geom_function(
      fun  = dnorm,
      args = list(mean = mean,
                  sd   = sd),
      aes(colour = colour)),
    par$mean, 
    par$sd, 
    sprintf("mean=%.0f sd=%.1f", 
            par$mean, par$sd)
  ) +
  ylab("")