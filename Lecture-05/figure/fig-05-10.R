library(pacman)
pacman::p_load(tidyr, ggplot2)

par <- expand_grid(
  df1 = c(1, 5, 9),
  df2 = c(1, 5, 9))

ggplot(data = NULL) +
  xlim(0, 6) +
  mapply(
    function(df1, df2, colour){
      stat_function(
        fun  = df,
        args = list(df1 = df1,
                    df2 = df2),
        aes(colour = colour))
    },
    par$df1, 
    par$df2, 
    sprintf("df1=%.0f df2=%.1f", 
            par$df1, par$df2)
  ) +
  xlab("") +
  ylab("")