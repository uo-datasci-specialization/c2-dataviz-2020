## ----setup, include = FALSE-----------------------
knitr::opts_chunk$set(dev="CairoPNG",
                      fig.width = 13, 
                      message = FALSE, 
                      warning = FALSE,
                      echo = TRUE)

library(tidyverse)
library(dviz.supp)
theme_set(theme_minimal(25))

#source(here::here("resources", "wilke-redundant_coding.R"))
#source(here::here("resources", "wilke-proportions.R"))

update_geom_defaults('path', list(size = 3))
update_geom_defaults('point', list(size = 4))
#update_geom_defaults('text_repel', list(size = 6))
update_geom_defaults('text', list(size = 6))


## ----eval = FALSE---------------------------------
## remotes::install_github("rstudio/distill")

