library(pacman)
p_load(ggplot2, tibble)
p_load_gh("thomasp85/patchwork")

p1 <- ggplot() + 
  xlim(-4.5, 4.5) +
  geom_function(fun = dnorm) +
  geom_vline(xintercept = qnorm(c(0.025, 0.975)),
             linetype = "dashed")

p2 <- ggplot() +
  xlim(-4.5, -3) +
  geom_area(
    data = tibble(
      X = seq(-4.5, 
              -3.68,
              len = 100),
      Y = dnorm(X)),
    aes(x    = X,
        y    = Y),
    fill = "red") +
  geom_function(fun = dnorm)

p1 + p2