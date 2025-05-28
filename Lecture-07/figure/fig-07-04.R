library(pacman)
p_load(tibble, ggplot2)
tibble(size  = 10:200,
       value = qt(p  = 0.025,
                  df = size - 1),
       diff  = qnorm(0.025) - value) |> 
  ggplot() +
  aes(x = size,
      y = diff) +
  geom_path()