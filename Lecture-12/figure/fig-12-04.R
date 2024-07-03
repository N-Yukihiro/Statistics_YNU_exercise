library(pacman)
p_load(withr, dplyr, ggplot2, latex2exp)

dat <- with_seed(2718,
                 tibble(x = rnorm(15, mean = 5)) |>
                   mutate(y = 2 * x + rnorm(15)))
dat |> 
  ggplot() +
  aes(x = x, y = y) +
  geom_smooth(method      = "lm",
              se          = FALSE,
              alpha       = 0.1,
              colour      = "orange",
              show.legend = FALSE) +
  geom_point() +
  geom_vline(xintercept = mean(dat$x)) +
  geom_hline(yintercept = mean(dat$y)) +
  scale_x_continuous(breaks = mean(dat$x),
                     labels = expression(bar(x))) +
  scale_y_continuous(breaks = mean(dat$y),
                     labels = expression(bar(y))) +
  theme_classic()