library(pacman)
pacman::p_load(tidyr, ggplot2)
par <- expand_grid(
  mean = c(-2, 0, 2),
  sd   = c(.5, 1, 3))
ggplot() +
  xlim(-6, 6) +
  mapply(
    \(mean, sd, colour)
    stat_function(
      fun  = pnorm,
      args = list(mean = mean,
                  sd   = sd),
      aes(colour = colour)),
    par$mean, 
    par$sd, 
    sprintf("mean=%.0f sd=%.1f", 
            par$mean, par$sd)
  ) +
  ylab("")