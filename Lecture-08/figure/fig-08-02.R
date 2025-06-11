library(pacman)
p_load(ggplot2, tibble)

test <- t.test(extra ~ group,
               data      = sleep,
               var.equal = TRUE)

ggplot() +
  xlim(-4, 4) +
  geom_function(fun = dt,
                args = list(df = test$parameter)) +
  geom_area(
    data = tibble(
      X = seq(-test$statistic,
              4,
              len = 100),
      Y = dt(X, df = test$parameter)),
    aes(x    = X,
        y    = Y),
    fill = "red") +
  geom_vline(xintercept = qt(0.975,
                             df = test$parameter),
             linetype = "dashed") +
  geom_area(
    data = tibble(
      X = seq(-4, 
              test$statistic,
              len = 100),
      Y = dt(X, df = test$parameter)),
    aes(x    = X,
        y    = Y),
    fill = "red",
    alpha = 0.5)
