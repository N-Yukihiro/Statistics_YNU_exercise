library(pacman)
p_load(ggplot2, dplyr, tibble)
tibble(
  x = c(0, 4),
  y = c(1, 3)
  ) |>  
  ggplot(aes(x, y)) +
  geom_line() +
  scale_y_continuous(breaks = seq(0, 3, by = 1),
                     limits = c(0,3)) +
  theme_bw(base_size = 20)
