# パッケージの読み込み
pacman::p_load(tibble, ggplot2, dplyr, tidyr, modeest, withr)

# グループごとの平均・中央・最頻値を定義
mean_by_group <- function(x) {
  summarise(x, mean_x = mean(value), .by = var)
}

median_by_group <- function(x) {
  summarize(x, median_x = median(value), .by = var)
}

mode_by_group <- function(x) {
  summarise(x, 
            mode_x = mlv(value, 
                         method = "meanshift"),
            .by = var)
}

# データの作成, グラフの描画
set.seed(2718)
withr::with_preserve_seed(
  tibble(x1 = rnorm(n = 100000, mean   = 5,  sd = 0.1),
         x2 = rbeta(n = 100000, shape1 = 10, shape2 = 2),
         x3 = rbeta(n = 100000, shape1 = 2,  shape2 = 10)) |> 
    tidyr::pivot_longer(cols      = everything(),
                        names_to  = "var", 
                        values_to = "value")) |> 
  ggplot() +
  aes(x = value,
      y = after_stat(density)) +
  geom_density() +
  geom_vline(data      = mean_by_group, 
             aes(xintercept = mean_x), 
             colour    = "red",
             linewidth = 1.) +
  geom_vline(data      = median_by_group, 
             aes(xintercept = median_x), 
             colour    = "black",
             linetype  = "dashed",
             linewidth = 0.7) +  
  geom_vline(data      = mode_by_group,
             aes(xintercept = mode_x),
             colour    = "black",
             linetype  = "twodash",
             linewidth = 0.5) +
  facet_wrap(~var, 
             scales   = "free",
             ncol     = 1,
             labeller = label_bquote(rows = "")) +
  theme_void()