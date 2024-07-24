library(ggplot2)
library(gridExtra)

p1 <- ggplot() +
  xlim(0, 1) +
  geom_function(fun  = dbeta,
                args = list(shape1 = 4,
                            shape2 = 4)) +
  ggtitle("事前分布") +
  theme_classic(base_family = "IPAexGothic")

p2 <- ggplot() +
  xlim(0, 1) +
  geom_function(fun  = dbeta,
                args = list(shape1 = 16,
                            shape2 = 7)) +
  ggtitle("事後分布") +
  theme_classic(base_family = "IPAexGothic")

p3 <- ggplot() +
  xlim(0, 1) +
  geom_function(fun = dbeta,
                args = list(shape1 = 1,
                            shape2 = 1)) +
  ggtitle("事前分布(無情報事前分布)") +
  theme_classic(base_family = "IPAexGothic")

p4 <- ggplot() +
  xlim(0, 1) +
  geom_function(fun = dbeta,
                args = list(shape1 = 13,
                            shape2 = 4)) +
  ggtitle("事後分布(無情報事前分布)") +
  theme_classic(base_family = "IPAexGothic")

gridExtra::grid.arrange(p1, p2, p3, p4, nrow = 2)