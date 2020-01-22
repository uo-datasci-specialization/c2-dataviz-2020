## ----setup, echo = FALSE, message = FALSE----------------------------------------
knitr::opts_chunk$set(fig.width = 13, 
                      message = FALSE, 
                      warning = FALSE,
                      echo = FALSE)

library(tidyverse)
update_geom_defaults('path', list(size = 3))
update_geom_defaults('point', list(size = 4))


## ----source-wilke----------------------------------------------------------------
source(here::here("wilke-purl", "wilke-aes-mapping.R"))
source(here::here("wilke-purl", "wilke-avoid_line_drawings.R"))
source(here::here("wilke-purl", "wilke-redundant_coding.R"))
source(here::here("wilke-purl", "wilke-proportions.R"))


## ----data-encoding, fig.width = 14-----------------------------------------------
plot_grid(aes_pos, aes_shape, aes_size,
          aes_color, aes_lwd, aes_ltp,
          ncol = 3,
          labels = c("position", "shape", "size", "color", "line width", "line type"),
          label_x = 0.05, label_y = 0.95, hjust = 0, vjust = 1, 
          label_size = 40)


## ----scales-wilke, fig.width = 14------------------------------------------------
scale_num + scale_shape + scale_color + plot_layout(ncol = 1)


## ----temp-change, fig.width = 14-------------------------------------------------
ggplot(temps_long, aes(x = date, y = temperature, color = location)) +
  geom_line() +
  scale_x_date(name = "month", 
               limits = c(ymd("0000-01-01"), ymd("0001-01-04")),
               breaks = c(ymd("0000-01-01"), 
                          ymd("0000-04-01"), 
                          ymd("0000-07-01"),
                          ymd("0000-10-01"), 
                          ymd("0001-01-01")),
               labels = c("Jan", "Apr", "Jul", "Oct", "Jan"), 
               expand = c(1/366, 0)) + 
  scale_y_continuous(limits = c(15, 110),
                     breaks = seq(20, 100, by = 20),
                     name = "temperature (°F)") +
  scale_color_OkabeIto(order = c(1:3, 7), name = NULL) +
  theme_minimal(base_size = 25) +
  theme(legend.title.align = 0.5)


## ----temp-change2, fig.width = 14------------------------------------------------
ggdraw(align_legend(p)) 


## ----five-scales, fig.width = 10, fig.height = 7---------------------------------
ggdraw() + 
  draw_plot(p_mtcars + theme(legend.position = "none")) + 
  draw_grob(legend, x = .36, y = .7, width = .7, height = .2)


## ----h3_bad, fig.width = 6-------------------------------------------------------
h3_bad


## ----h3_good, fig.width = 6------------------------------------------------------
h3_good


## ----iris_lines, fig.width = 6---------------------------------------------------
iris_lines


## ----iris_colored_lines, fig.width = 6-------------------------------------------
iris_colored_lines


## ----iris_filled-----------------------------------------------------------------
iris_filled


## ----install_packages, eval = FALSE, echo = TRUE---------------------------------
## install.packages("extrafont")
## devtools::install_github("wch/extrafontdb")
## devtools::install_github("wch/Rttf2pt1")
## devtools::install_github("hrbrmstr/waffle")


## ----create_data, echo = TRUE----------------------------------------------------
parts <- c(`Un-breached\nUS Population` = (318 - 11 - 79), 
           `Premera` = 11, 
           `Anthem` = 79)


## ----waffle1, echo = TRUE--------------------------------------------------------
library(waffle)
waffle(parts, 
       rows = 8, 
       colors = c("#969696", "#1879bf", "#009bda"))


## ----import_fonts, eval = FALSE, echo = TRUE-------------------------------------
## library(extrafont)
## font_import()
## loadfonts()


## ----waffle2, echo = TRUE, eval = FALSE------------------------------------------
## waffle(parts/10,
##        rows = 3,
##        colors = c("#969696", "#1879bf", "#009bda"),
##        use_glyph = "medkit") #<<


## ----waffle3---------------------------------------------------------------------
waffle(parts/10, 
       rows = 3, 
       colors = c("#969696", "#1879bf", "#009bda"),
       use_glyph = "medkit") #<< 


## ----iris_lines2, fig.width = 6--------------------------------------------------
iris_lines


## ----iris_filled2, fig.width = 6-------------------------------------------------
iris_filled


## ----pie, fig.height = 4, fig.width = 10-----------------------------------------
wilke_pie


## ----stacked_bars_nopie----------------------------------------------------------
ggdraw(bt_bars_stacked)


## ----horiz_stacked---------------------------------------------------------------
ggdraw(bt_bars_hstacked)


## ----dodged_bars, fig.height = 4-------------------------------------------------
bt_bars

ggplot(bundestag, aes(x = fct_reorder(factor(party, levels = bundestag$party), seats), 
                      y = seats, 
                      fill = party)) + 
  geom_col() + 
  geom_text(aes(label = seats), size = 10, hjust = 1.2, color = c("white", "white", "black")) +
  scale_x_discrete(name = NULL) +
  scale_y_continuous(expand = c(0, 0)) +
  scale_fill_manual(values = bundestag$colors[order(bundestag$party)], guide = "none") + 
  theme_dviz_grid(25, font_family = "Roboto Light") +
  theme(axis.ticks.x = element_blank()) +
  coord_flip()


## ----spurious-corr---------------------------------------------------------------
knitr::include_url("http://www.tylervigen.com/spurious-correlations")

