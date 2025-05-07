library(pacman)
pacman::p_load(ggplot2, tibble)

ggplot() +
  xlim(-4, 4) +
  stat_function(fun = dnorm) +
  geom_ribbon(
    data = tibble(
      X = seq(-2, 2, len = 1000),
      Y = dnorm(X)),
    aes(x    = X,
        y    = Y,
        ymin = 0,
        ymax = Y),
    fill = "#001E62") +
  geom_ribbon(
    data = tibble(
      X = seq(-1, 1, len=1000),
      Y = dnorm(X)),
    aes(x    = X, 
        y    = Y,
        ymin = 0,
        ymax = Y),
    fill = "#C63527") +
  xlab("") +
  ylab("")