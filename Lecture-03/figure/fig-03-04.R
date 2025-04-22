library(pacman)
pacman::p_load(dplyr, ggplot2, tidyr)

data.frame(
  a = seq(from = 0, to = 10, length.out = 1000)
) |> 
  dplyr::add_row(a  = c(0, 10)) |> 
  dplyr::mutate(b   = 10 - a) |> 
  dplyr::mutate(M_A = (a + b) / 2) |> 
  dplyr::mutate(M_G = sqrt(a * b)) |>  
  dplyr::mutate(M_H = (2 * a * b) / (a + b)) |> 
  dplyr::mutate(RMS = sqrt((a^2 + b^2) / 2)) |>  
  dplyr::select(-b) |> 
  tidyr::pivot_longer(
    col       = -a, 
    names_to  = "mean", 
    values_to = "amount"
  ) |> 
  dplyr::mutate(dplyr::across(mean, as.factor)) |> 
  ggplot(aes(a, amount, colour = mean)) +
  geom_line(linewidth = 2) +
  scale_color_manual(values = c('green', 'red', 'blue', 'yellow'),
                     breaks = c('RMS', 'M_A', 'M_G', 'M_H'),
                     labels = c("RMS",
                                bquote(bar(x)),
                                expression(M[G]),
                                expression(M[H]))) +
  labs(y = "aとbの平均値") +
  theme_bw(base_size   = 20,
           base_family = "IPAexGothic") +
  theme(plot.margin = grid::unit(c(0, 0, 0, 0), "mm"))