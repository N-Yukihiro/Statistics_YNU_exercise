library(pacman)
p_load(dplyr, tibble, purrr, withr, ggplot2, forcats)

tate <- function(x){
  chartr("ー", "丨", x) |>  # 長音符の処理
    strsplit(split = "") |>  
    sapply(paste, collapse = "\n")
}

with_seed(2718,
          map(1:10,
              ~ tibble(x = rbinom(n    = 10000, 
                                  size = 1, 
                                  prob = 0.5))) |> 
            map(mutate, 
                cumsum = cumsum(x),
                n      = row_number(),
                prob   = cumsum / n) |>  
            list_rbind(names_to = "number") |> 
            mutate(number = number |> 
                     as_factor())) |> 
  ggplot() + 
  aes(x      = n,
      y      = prob,
      colour = number) +
  geom_path(show.legend = FALSE) +
  ylab("表が出る確率" |> tate()) +
  xlab("サンプルサイズ") +
  theme_bw(base_size   = 20,
           base_family = "IPAexGothic") +
  theme(axis.title.y = element_text(angle = 0,
                                    vjust = 0.5))