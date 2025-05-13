library(pacman)
pacman::p_load(tibble, forcats, ggplot2)

par <- tibble(df = 1:9)

ggplot(data = NULL) + 
  xlim(0, 15) +
  mapply(
    function(df, colour){
      stat_function(fun  = dchisq,
                    args = list(df = df),
                    aes(color = colour))
    },
    par$df, 
    sprintf("df=%.0f", par$df |> 
              as_factor())) +
  xlab("") +
  ylab("")