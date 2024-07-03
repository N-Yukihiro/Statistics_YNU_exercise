library(pacman)
p_load(withr, dplyr, ggplot2)

dat <- with_seed(2718,
                 tibble(x = rnorm(15, mean = 5)) |>
                   mutate(y = 2 * x + rnorm(15))) |> 
  scale()
dat |> 
  ggplot() +
  aes(x = x, y = y) +
  geom_smooth(method      = "lm",
              se          = FALSE,
              alpha       = 0.1,
              colour      = "orange",
              show.legend = FALSE) +
  geom_point() +
  geom_vline(xintercept = 0) +
  geom_hline(yintercept = 0) +
  theme_classic()