library(pacman)
pacman::p_load(ggplot2, dplyr, tibble)
fig_01_04 <- tibble(
    x = c(0, 4),
    y = c(1, 3)
) |>
    ggplot(aes(x, y)) +
    geom_line() +
    scale_y_continuous(
        breaks = seq(0, 3, by = 1),
        limits = c(0, 3)
    ) +
    theme_bw(base_size = 20)
print(fig_01_04)
