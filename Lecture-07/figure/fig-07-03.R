library(pacman)
p_load(withr, purrr, dplyr, magrittr, ggplot2)

pop <- with_seed(round(exp(1) * 10E4),
                 rnorm(n = 100000) |> 
                   as_tibble())
pop_mean <- mean(pop$value)
pop_var <- pop %$% 
  subtract(value,
           pop_mean) |> 
  raise_to_power(2) |> 
  mean()

size1 <- 30
size2 <- 100
size3 <- 1000
with_seed(round(exp(1) * 10E4),
          list(size1, size2, size3) |> 
            map(~ map(rep(.x, 100),
                      ~ slice_sample(pop,
                                     n = .x)
            )
            )
) |>
  map(map,
      summarise,
      size    = n(),
      mean    = mean(value),
      lowerCI = add(mean,
                    multiply_by(
                      qt(0.025, df = size - 1),
                      divide_by(pop_var,
                                size) |>
                        sqrt()
                    )
      ),
      upperCI = add(mean,
                    multiply_by(
                      qt(0.975, df = size - 1),
                      divide_by(pop_var,
                                size) |> 
                        sqrt()
                    )
      )
  ) |> 
  map(list_rbind) |> 
  map(mutate,
      number = row_number()) |> 
  list_rbind() |> 
  mutate(TF = if_else(
    lowerCI <= pop_mean & upperCI >= pop_mean,
    T, F)) |>
  mutate(across(size, as_factor)) |>
  ggplot() +
  aes(x      = number,
      y      = mean,
      colour = TF) +
  geom_point() +
  geom_errorbar(aes(ymin = lowerCI,
                    ymax = upperCI), 
                width = .2) +
  geom_hline(yintercept = pop_mean, 
             linetype   = "dashed", 
             colour     = "black") +
  theme_void() +
  facet_wrap(~size)