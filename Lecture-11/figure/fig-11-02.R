library(pacman)
p_load(withr, purrr, dplyr, MASS, ggplot2)

r <- seq(from       = -1, 
         to         = 1, 
         length.out = 9)
with_seed(27182,
          r |> 
            map(\(r) mvrnorm(n         = 100,
                             mu        = c(0, 0), 
                             Sigma     = matrix(c(1, r, r, 1),
                                                ncol = 2),
                             empirical = TRUE)) |> 
            map(as.data.frame) |> 
            map2(.y = r,
                 \(data, r) mutate(data,
                                   r = as.factor(r))) |>  
            map(rename,
                x = 1, y = 2)) |> 
  list_rbind() |> 
  ggplot() +
  aes(x = x, y = y) +
  geom_point() +
  facet_wrap( ~ r,
              nrow   = 3, 
              scales = "free")
