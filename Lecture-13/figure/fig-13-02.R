library(pacman)
p_load(ggdag, ggplot2)
fig_13_02 <- ggdag::dagify(
    Z ~ X,
    Y ~ Z,
    exposure = "X",
    outcome = "Y",
    coords = list(
        x = c(X = 1, Y = 2, Z = 3),
        y = c(X = 2, Y = 1, Z = 2)
    )
) |>
    tidy_dagitty() |>
    ggdag_adjust() +
    theme_void() +
    theme(legend.position = "none")
print(fig_13_02)