library(pacman)
pacman::p_load(tibble, dplyr, purrr, withr, forcats, ggplot2)

size1 <- 10
size2 <- 100
size3 <- 1000
with_seed(2718,
          list(size1, size2, size3) |> 
            map(~ map(rep(.x, 10000),
                      ~ tibble(x = rbinom(n    = .x,
                                          size = 1, 
                                          prob = 0.5)
                      )
            )
            ) |>  
            purrr::set_names(c("10", "100", "1000")) |> 
            map(map, 
                summarise,
                prob = mean(x)) |>
            map(list_rbind) |> 
            list_rbind(names_to = "size")) |> 
  mutate(across(.cols = size,
                .fns  = \(x) as.numeric(x) |> 
                  as_factor())) |> 
  ggplot() +
  aes(x      = prob,
      fill   = size,
      colour = size) +
  geom_histogram(
    aes(y = after_stat(density)),
    alpha       = 0.1,
    position    = "identity",
    show.legend = FALSE) +
  geom_density(
    alpha       = 0.2,
    adjust      = 2,
    show.legend = TRUE) +
  stat_function(
    fun       = dnorm,
    args      = list(mean = 0.5,
                     sd   = sqrt(0.5 * 0.5 / size1)),
    colour    = "red",
    linetype  = "dashed",
    linewidth = 1.5) +
  stat_function(
    fun       = dnorm,
    args      = list(mean = 0.5,
                     sd   = sqrt(0.5 * 0.5 / size2)),
    colour    = "green",
    linetype  = "dashed",
    linewidth = 1.5) +
  stat_function(
    fun       = dnorm,
    args      = list(mean = 0.5,
                     sd   = sqrt(0.5 * 0.5 / size3)),
    colour    = "blue",
    linetype  = "dashed",
    linewidth = 1.5) +
  ylab("") +
  xlab("標本平均") +
  theme_bw(base_size   = 20,
           base_family = "IPAexGothic") +
  theme(axis.text.y = element_blank())