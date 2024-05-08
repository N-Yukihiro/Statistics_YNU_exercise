pacman::p_load(ggplot2)

p_base <- ggplot() +
  xlim(-4, 4)

p_base +
  stat_function(fun = \(x) -1 * abs(x) + 4)

p_base +
  stat_function(fun = \(x) 2^-abs(x))

p_base +
  stat_function(fun = \(x) 2^-x^2)

p_base +
  mapply(
    \(base, colour) 
    stat_function(
      fun = \(x) base^-(x^2),
      aes(colour = colour)
    ),
    2:9,
    sprintf("base=%.0f", 
            2:9)
  )

p_base +
  stat_function(fun = \(x) exp(-x^2 / 2),
                xlim = c(-4, 4))

p_base +
  stat_function(fun = \(x) (1 / sqrt(2 * pi)) * exp(-x^2 / 2))