library(pacman)
pacman::p_load(tibble, forcats, ggplot2)

par <- tibble(df = 1:9)
ggplot(data = NULL) + 
  xlim(-5, 5) +
  mapply(
    function(df, colour){
      geom_function(fun  = dt,
                    args = list(df = df),
                    aes(colour = colour))
    },
    par$df, 
    sprintf("df=%.0f", par$df |> 
              as_factor())) +
  stat_function(
    fun      = dnorm, 
    linetype = "dashed") +
  xlab("") +
  ylab("")