## ----setup, include = FALSE-----------------------------------------------------------------
knitr::opts_chunk$set(dev="CairoPNG",
                      fig.width = 13, 
                      message = FALSE, 
                      warning = FALSE,
                      echo = TRUE)

library(tidyverse)
theme_set(theme_minimal(25))

update_geom_defaults('path', list(size = 3))
update_geom_defaults('point', list(size = 4))
update_geom_defaults('text', list(size = 6))


## ----install, eval = FALSE------------------------------------------------------------------
## install.packages("flexdashboard")


## ### Square title

## < r code chunk >


## ----plotly-render, eval = FALSE------------------------------------------------------------
## p <- ggplot(...)
## renderPlotly(p)


## ----reactable, eval = FALSE----------------------------------------------------------------
## tbl <- reactable(...)
## renderReactable(tbl)


## ----plotly, eval = FALSE-------------------------------------------------------------------
## library(plotly)
## p <- ggplot(mpg, aes(displ, cty)) +
##   geom_point() +
##   geom_smooth()
## 
## ggplotly(p) #<<


## ----install-xaringan-gh, eval = FALSE------------------------------------------------------
## devtools::install_github("yihui/xaringan")


## ----install-xaringan-cran, eval = FALSE----------------------------------------------------
## install.packages("xaringan")


## ----list_css-------------------------------------------------------------------------------
names(xaringan:::list_css())


## ----slidex, eval = FALSE-------------------------------------------------------------------
## convert_pptx("path/to/pptx", author = "Your Name")

