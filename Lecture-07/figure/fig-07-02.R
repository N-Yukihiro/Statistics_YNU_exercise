library(pacman)
p_load(withr, purrr, dplyr, magrittr, ggplot2, forcats)

pop <- with_seed(2718,
                 rnorm(n = 1000) |> 
                   as_tibble())
pop_var <- pop %$% 
  subtract(value,
           value |> 
             mean()) |>  
  raise_to_power(2) |> 
  mean()
pop_mean <- pop %$% 
  mean(value)

#サイズ10で95%信頼区間
size <-  10
with_seed(round(exp(1) * 10E3),
          map(1:100,
              \(x) slice_sample(pop,
                                n = size)) |> 
            map(summarise, 
                mean = mean(value),
                lowerCI = add(
                  mean,
                  multiply_by(
                    qt(0.025, df = size - 1),
                    divide_by(var(value),
                              n()) |>
                      sqrt())),
                upperCI = add(
                  mean,
                  multiply_by(
                    qt(0.975, df = size - 1),
                    divide_by(var(value),
                              n()) |>
                      sqrt()))) |> 
            list_rbind(names_to = "number")) |>
  mutate(TF = lowerCI <= pop_mean & upperCI >= pop_mean) |> 
  mutate(across(TF, as_factor)) |> 
  ggplot() +
  aes(x = number, y = mean, colour = TF) +
  geom_point() +
  geom_errorbar(aes(ymin = lowerCI,
                    ymax = upperCI), 
                width = .2) +
  geom_hline(yintercept = pop_mean, 
             linetype   = "dashed", 
             colour     = "black") +
  theme_void()