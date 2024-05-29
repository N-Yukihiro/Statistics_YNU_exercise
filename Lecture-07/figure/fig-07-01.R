library(pacman)
p_load(ggplot2, withr, tibble, tidyr)

X <- with_seed(2718,
               rnorm(20))
logLikelihood <- function(args, x) {
  dnorm(x = x, mean = args[1], sd = args[2], log = TRUE) |> 
    sum()
}

mle <- optim(par     = c(0,1),
             fn      = logLikelihood,
             x       = X,
             control = list(fnscale = -1))$par

d <- tibble(x    = X,
            yend = dnorm(X, 
                         mean = mle[1],
                         sd   = mle[2]))

parms <- expand_grid(
  mean = c(mle[1], mle[1] + 1,    mle[1] - 1),
  sd   = c(mle[2], mle[2] * 1.25, mle[2] * 0.75))

ggplot() +
  xlim(-4, 4) +
  geom_rug(aes(x = X),
           sides = "b") +
  geom_segment(data      = d,
               aes(x     = x,
                   y     = 0,
                   xend  = x,
                   yend  = yend),
               linetype  = "dotted",
               linewidth = 0.25) +
  mapply(\(mean, sd) {
    stat_function(fun       = dnorm,
                  args      = list(mean = mean, 
                                   sd   = sd),
                  colour = "gray")
  },
  parms$mean,
  parms$sd) +
  stat_function(fun       = dnorm,
                args      = list(mean = mle[1], 
                                 sd   = mle[2]),
                linewidth = 2) +
  theme_bw()