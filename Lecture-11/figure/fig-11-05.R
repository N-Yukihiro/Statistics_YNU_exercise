library(pacman)
p_load(ggdag)
fig_11_05 <- dagify(
    x ~ z,
    y ~ z,
    y ~ x
) |>
    ggdag() +
    theme_void()
print(fig_11_05)