library(pacman)
p_load(tidyr, dplyr, seewave, ggplot2)

penguins |>
  drop_na() |>
  select(bill_length_mm) |> 
  mutate(z1 = (bill_length_mm - mean(bill_length_mm)) 
         / rms(bill_length_mm - mean(bill_length_mm)),
         z2 = (bill_length_mm - mean(bill_length_mm))
         / sd(bill_length_mm)) |> 
  pivot_longer(cols      = everything(), 
               names_to  = "var",
               values_to = "value") |> 
  ggplot() +
  aes(x = value,
      y = after_stat(density)) +
  geom_histogram() +
  geom_density() +
  facet_wrap(~var, 
             scales   = "free",
             ncol     = 1,
             labeller = label_bquote(rows = "")) +
  theme_void()