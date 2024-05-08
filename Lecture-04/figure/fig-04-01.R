library(pacman)
pacman::p_load(ggplot2, tibble, dplyr)

count_iter <- function(target, n) {
  results <-  rep(NA, 10)
  for(j in 1:n) {
    trial <- rep(-1L, length(target))
    i = 0
    while(!all(target == trial)) {
      trial = c(trial[-1], rbinom(1, 1, 0.5))
      i = i + 1
    }
    results[j] = i
  }
  return(results)
}

bind_rows(tibble(count = count_iter(c(1L, 1L, 0L), 5000),
                 flip  = "表表裏"),
          tibble(count = count_iter(c(1L, 0L, 1L), 5000),
                 flip  = "表裏表")) |> 
  mutate(mean = mean(count),
         .by = flip) |> 
  ggplot() +
  aes(x = count, y = after_stat(density)) +
  geom_histogram() +
  geom_vline(aes(xintercept = mean),
             colour = "red") +
  facet_wrap(~flip,
             scales = "fixed") +
  xlab("") +
  theme_bw(base_size   = 20, 
           base_family = "IPAexGothic")