## ----setup, include = FALSE, cache = FALSE--------------------------
knitr::opts_chunk$set(fig.width = 13, 
                      message = FALSE, 
                      warning = FALSE,
                      echo = TRUE,
                      cache = TRUE)
knitr::dep_auto()

source(here::here("wilke-purl", "wilke-redundant_coding.R"))
source(here::here("wilke-purl", "wilke-color_basics.R"))

library(tidyverse)
update_geom_defaults('path', list(size = 3))
update_geom_defaults('point', list(size = 4))


## ----popgrowth------------------------------------------------------
popgrowth_df


## ----theme_set1, include = FALSE------------------------------------
theme_set(theme_minimal(base_size = 15) +
            theme(plot.margin = margin(-0.1, -0.1, 0, 0, unit = "cm")))


## ----popgrowthvis1, eval = FALSE------------------------------------
## ggplot(popgrowth_df,
##        aes(x = state,
##            y = 100*popgrowth)) +
##   geom_col(alpha = 0.7) +
##   coord_flip()


## ----ref.label="popgrowthvis1", echo=FALSE, fig.width = 7, fig.height = 9.6----


## ----popgrowthvis2, eval = FALSE------------------------------------
## ggplot(popgrowth_df,
##        aes(x = state,
##            y = 100*popgrowth)) +
##   geom_col(aes(fill = region),
##            alpha = 0.7) +
##   coord_flip()


## ----ref.label="popgrowthvis2", echo=FALSE, fig.width = 7, fig.height = 9.6----


## ----colorblind1, echo = FALSE, fig.height = 8----------------------
p <- ggplot(popgrowth_df, 
       aes(x = state, 
           y = 100*popgrowth)) + 
  geom_col(aes(fill = region),
           alpha = 0.7) + 
  coord_flip() +
  theme_void()
colorblindr::cvd_grid(p)


## ----viridis1, eval = FALSE-----------------------------------------
## ggplot(popgrowth_df,
##        aes(x = state,
##            y = 100*popgrowth)) +
##   geom_col(aes(fill = region),
##            alpha = 0.7) +
##   scale_fill_viridis_d() + #<<
##   coord_flip()


## ----ref.label="viridis1", echo=FALSE, fig.width = 7, fig.height = 9.6----


## ----echo = FALSE, fig.height = 8-----------------------------------
p2 <- ggplot(popgrowth_df, 
       aes(x = state, 
           y = 100*popgrowth)) + 
  geom_col(aes(fill = region),
           alpha = 0.7) + 
  coord_flip() +
  scale_fill_viridis_d() +
  theme_void()

colorblindr::cvd_grid(p2)


## ----OkabeIto1, eval = FALSE----------------------------------------
## library(colorblindr) #<<
## 
## ggplot(popgrowth_df,
##        aes(x = state,
##            y = 100*popgrowth)) +
##   geom_col(aes(fill = region),
##            alpha = 0.7) +
##   scale_fill_OkabeIto() + #<<
##   coord_flip()


## ----ref.label="OkabeIto1", echo=FALSE, fig.width = 7, fig.height = 9.6----


## ----echo = FALSE, fig.height = 8-----------------------------------
p3 <- ggplot(popgrowth_df, 
       aes(x = state, 
           y = 100*popgrowth)) + 
  geom_col(aes(fill = region),
           alpha = 0.7) + 
  scale_fill_OkabeIto() + #<<
  coord_flip()  +
  theme_void()

colorblindr::cvd_grid(p3)


## ----install-colorblindr, eval = FALSE------------------------------
## devtools::install_github("wilkelab/cowplot")
## install.packages("colorspace", repos = "http://R-Forge.R-project.org")
## 
## devtools::install_github("clauswilke/colorblindr")


## ----okabe-ito2, fig.height = 5-------------------------------------
p <- ggplot(popgrowth_df, 
       aes(x = state, 
           y = 100*popgrowth)) + 
  geom_col(aes(fill = region),
           alpha = 0.7) + 
  scale_fill_OkabeIto() + 
  coord_flip()  +
  theme_void() # not necessary but I like it #<<

colorblindr::cvd_grid(p) #<<


## ----theme_set2, include = FALSE------------------------------------
theme_set(theme_minimal(base_size = 25) +
            theme(plot.margin = margin(-0.1, -0.1, 0, 0, unit = "cm")))


## ----heatmap1, fig.height = 4---------------------------------------
iris %>%
	gather(var, value, -Species) %>%
ggplot(aes(Species, fct_reorder(var, value))) +
	geom_tile(aes(fill = value))


## ----heatmap2-------------------------------------------------------
iris %>%
	gather(var, value, -Species) %>%
ggplot(aes(Species, fct_reorder(var, value))) +
	geom_tile(aes(fill = value)) +
	scale_fill_distiller(palette = "Blues") #<<


## ----heatmap3-------------------------------------------------------
iris %>%
	gather(var, value, -Species) %>%
ggplot(aes(Species, fct_reorder(var, value))) +
	geom_tile(aes(fill = value)) +
	scale_fill_viridis_c() #<<


## ----heatmap4-------------------------------------------------------
iris %>%
	gather(var, value, -Species) %>%
ggplot(aes(Species, fct_reorder(var, value))) +
	geom_tile(aes(fill = value)) +
	scale_fill_viridis_c(option = "magma") #<<


## ----lane1, echo = FALSE--------------------------------------------
library(tidycensus)
library(tigris)
options(tigris_use_cache = TRUE)
options(tigris_class="sf")

lane <- get_decennial(geography = "tract", variables = "P005003", 
                  state = "OR", county = "Lane", geometry = TRUE,
                  summary_var = "P001001")

or <- get_decennial(geography = "county", variables = "P005003", 
                  state = "OR", geometry = TRUE,
                  summary_var = "P001001")

ca <- get_decennial(geography = "county", variables = "P005003", 
                  state = "CA", geometry = TRUE,
                  summary_var = "P001001")

lane %>%
  mutate(pct = 100 * (value / summary_value)) %>%
  ggplot(aes(fill = pct, color = pct)) +
  geom_sf() +
  coord_sf(crs = 26915) + 
  theme_dviz_map(font_size = 25, font_family = "Roboto") +
  labs(title = "Percentage of people identifying as White",
       subtitle = "Lane County",
       caption = "US Census Decennial Tract Data")


## ----lane2, echo = FALSE--------------------------------------------
lane %>%
  mutate(pct = 100 * (value / summary_value)) %>%
  ggplot(aes(fill = pct, color = pct)) +
  geom_sf() +
  coord_sf(crs = 26915) + 
  theme_dviz_map(font_size = 25, font_family = "Roboto") +
  scale_fill_continuous_sequential("Heat") +
  scale_color_continuous_sequential("Heat") +
  labs(title = "Percentage of people identifying as White",
       subtitle = "Lane County",
       caption = "US Census Decennial Tract Data")



## ----lane3, echo = FALSE--------------------------------------------
lane %>%
  mutate(pct = 100 * (value / summary_value)) %>%
  ggplot(aes(fill = pct, color = pct)) +
  geom_sf() +
  coord_sf(crs = 26915) + 
  theme_dviz_map(font_size = 25, font_family = "Roboto") +
  scale_fill_viridis_c() +
  scale_color_viridis_c() +
  labs(title = "Percentage of people identifying as White",
       subtitle = "Lane County",
       caption = "US Census Decennial Tract Data")



## ----or1, echo = FALSE----------------------------------------------
or %>%
  mutate(pct = 100 * (value / summary_value)) %>%
  ggplot(aes(fill = pct, color = pct)) +
  geom_sf() +
  coord_sf(crs = 26915) + 
  theme_dviz_map(font_size = 25, font_family = "Roboto") +
  scale_fill_continuous_divergingx(palette = "Earth", 
                                   mid = 50, 
                                   limits = c(0, 100)) +
  scale_color_continuous_divergingx(palette = "Earth", 
                                    mid = 50,
                                    limits = c(0, 100)) +
  labs(title = "Percentage of people identifying as White",
       subtitle = "Oregon",
       caption = "US Census Decennial Tract Data")



## ----ca1, echo = FALSE, fig.height = 9------------------------------
ca %>%
  mutate(pct = 100 * (value / summary_value)) %>%
  ggplot(aes(fill = pct, color = pct)) +
  geom_sf() +
  coord_sf(crs = 26915) + 
  theme_dviz_map(font_size = 25, font_family = "Roboto") +
  scale_fill_continuous_divergingx(palette = "Earth", 
                                   mid = 50, 
                                   limits = c(0, 100)) +
  scale_color_continuous_divergingx(palette = "Earth", 
                                    mid = 50,
                                    limits = c(0, 100)) +
  labs(title = "Percentage of people identifying as White",
       subtitle = "California",
       caption = "US Census Decennial County Data")



## ----theme_set3, include = FALSE, cache = FALSE---------------------
theme_set(theme_minimal(base_size = 25))


## ----basic-scatter, fig.height = 5.5--------------------------------
ggplot(mpg, aes(displ, hwy)) +
	geom_point()


## ----compact-cars-scatter, fig.height = 6---------------------------
ggplot(mpg, aes(displ, hwy)) +
	geom_point(color = "gray80") +
	geom_point(data = filter(mpg, class == "compact"),
	           color = "#C55644")


## ----compact-cars-scatter-h1, fig.height = 6------------------------
ggplot(mpg, aes(displ, hwy)) +
	geom_point(color = "gray80") +
	geom_point(data = filter(mpg, str_detect(trans, "manual")),
	           color = "#C55644")


## ----basic-highlight-or-echo, eval = FALSE--------------------------
## ggplot(popgrowth_df,
##        aes(x = state,
##            y = 100*popgrowth)) +
##   geom_col(aes(fill = region),
##            alpha = 0.3) +
## 	geom_col(data = filter(popgrowth_df,
## 	                       state == "Oregon" |
## 	                       state == "Washington"),
##            fill = "#C55644") +
##   scale_fill_OkabeIto() + #<<
##   coord_flip()


## ----basic-highlight-or-eval, echo = FALSE, fig.height = 10---------
ggplot(popgrowth_df, 
       aes(x = state, 
           y = 100*popgrowth)) + 
  geom_col(aes(fill = region),
           alpha = 0.3) + 
	geom_col(data = filter(popgrowth_df,
	                       state == "Oregon" |
	                       state == "Washington"),
           fill = "#C55644") +
  scale_fill_OkabeIto() + #<<
  coord_flip() +
  theme(axis.text.y = element_text(size = 11))


## ----highlight-or---------------------------------------------------
states <- unique(popgrowth_df$state)

label_color <- ifelse(states == "Oregon" | states == "Washington", 
                "#C55644",
                "gray30")
label_color

label_face <- ifelse(states == "Oregon" | states == "Washington", 
                "bold",
                "plain")

label_face


## ----orwa-highlight-echo, eval = FALSE------------------------------
## ggplot(popgrowth_df,
##        aes(x = state,
##            y = 100*popgrowth)) +
##   geom_col(aes(fill = region),
##            alpha = 0.3) +
## 	geom_col(data = filter(popgrowth_df,
## 	                       state == "Oregon" |
## 	                       state == "Washington"),
##            fill = "#C55644") +
##   scale_fill_OkabeIto() +
##   coord_flip() +
##   theme(axis.text.y = element_text(color = label_color, #<<
##                                    face = label_face)) #<<


## ----orwa-highlight-eval, echo = FALSE, fig.height = 10-------------
ggplot(popgrowth_df, 
       aes(x = state, 
           y = 100*popgrowth)) + 
  geom_col(aes(fill = region),
           alpha = 0.3) + 
	geom_col(data = filter(popgrowth_df,
	                       state == "Oregon" |
	                       state == "Washington"),
           fill = "#C55644") +
  scale_fill_OkabeIto() + 
  coord_flip() +
  theme(axis.text.y = element_text(size = 11, #<<
                                   color = label_color, #<<
                                   face = label_face)) #<< 


## ----fig.height = 4-------------------------------------------------
accent_OkabeIto <- palette_OkabeIto[c(1, 2, 7, 4, 5, 3, 6)]
accent_OkabeIto[1:4] <- desaturate(lighten(accent_OkabeIto[1:4], .4), .8)
accent_OkabeIto[5:7] <- darken(accent_OkabeIto[5:7], .3)
gg_color_swatches(7) +
	scale_fill_manual(values = accent_OkabeIto)


## ----orwa-highlight-echo2, eval = FALSE-----------------------------
## ggplot(popgrowth_df,
##        aes(x = state,
##            y = 100*popgrowth)) +
##   geom_col(aes(fill = region)) +
## 	geom_col(data = filter(popgrowth_df,
## 	                       state == "Oregon" |
## 	                       state == "Washington"),
##            fill = "#C55644") +
##   scale_fill_manual(values = accent_OkabeIto) + #<<
##   coord_flip() +
##   theme(axis.text.y = element_text(color = label_color,
##                                    face = label_face))


## ----orwa-highlight-eval2, echo = FALSE, fig.height = 10------------
ggplot(popgrowth_df, 
       aes(x = state, 
           y = 100*popgrowth)) + 
  geom_col(aes(fill = region)) + 
	geom_col(data = filter(popgrowth_df,
	                       state == "Oregon" |
	                       state == "Washington"),
           fill = "#C55644") +
  scale_fill_manual(values = accent_OkabeIto) + 
  coord_flip() +
  theme(axis.text.y = element_text(size = 11, 
                                   color = label_color, 
                                   face = label_face)) 


## ----set_theme4, echo = FALSE---------------------------------------
theme_set(theme_minimal(20))



## ----sleepstudy-----------------------------------------------------
data(sleepstudy, package = "lme4")
head(sleepstudy)


## ----plot1, fig.height = 6------------------------------------------
ggplot(sleepstudy, aes(Days, Reaction, group = Subject)) +
	geom_line() 


## ----gghighlight1---------------------------------------------------
library(gghighlight) #<<
ggplot(sleepstudy, aes(Days, Reaction, group = Subject)) +
	geom_line() +
	gghighlight(max(Reaction) > 400)


## ----gghighlight2---------------------------------------------------
library(gghighlight) #<<
ggplot(sleepstudy, aes(Days, Reaction, color = Subject)) +
	geom_line() +
	gghighlight(max(Reaction) > 400) + #<<
	scale_color_OkabeIto()


## ----gghighlight3, fig.height = 6-----------------------------------
library(gghighlight) #<<
ggplot(sleepstudy, aes(Days, Reaction, color = Subject)) +
	geom_line() +
	facet_wrap(~Subject) + #<<
	gghighlight(max(Reaction) > 400) + #<<
	scale_color_OkabeIto()


## ----iris-scatter1, echo = FALSE------------------------------------
iris_scatter


## ----color-blind-iris_scatter, echo = FALSE-------------------------
cvd_grid(iris_scatter_small)


## ----iris-scatter, echo = FALSE-------------------------------------
iris_scatter2


## ----color-blind-iris_scatter2, echo = FALSE------------------------
cvd_sim2(iris_scatter2_small)


## ----too-many-colors, fig.height = 5--------------------------------
ggplot(popgrowth_df, aes(pop2000, popgrowth, color = state)) +
	geom_point()


## ----states-labeled, fig.height = 5---------------------------------
library(ggrepel) #<<

ggplot(popgrowth_df, aes(pop2000, popgrowth)) +
	geom_point(color = "gray70") +
	geom_text_repel(aes(label = state)) #<<


## ----subset-states--------------------------------------------------
to_label <- c("Alaska", "Arizona", "California", "Florida", "Wisconsin", 
              "Louisiana", "Nevada", "Michigan", "Montana", "New Mexico", 
              "Pennsylvania", "New York", "Oregon", "Rhode Island",
              "Tennessee", "Texas", "Utah", "Vermont")
subset_states <- popgrowth_df %>%
	filter(state %in% to_label)


## ----repeled-labels, fig.height = 5---------------------------------
library(ggrepel) #<<

ggplot(popgrowth_df, aes(pop2000, popgrowth)) +
	geom_point(color = "gray70") +
	geom_text_repel(aes(label = state), #<<
	                data = subset_states, #<<
	                min.segment.length = 0) #<<



## ----theme_set5, include = FALSE------------------------------------
theme_set(theme_minimal(base_size = 13))


## ----rainbow1-------------------------------------------------------
rainbow(3)
rainbow(7)


## ----rainbow-pop, fig.height = 6.5----------------------------------
ggplot(popgrowth_df, 
       aes(x = state, 
           y = 100*popgrowth)) + 
  geom_col(aes(fill = state)) +
  scale_fill_manual(values = rainbow(51)) + 
  coord_flip() +
  guides(fill = "none") 


## ----brewer, eval = FALSE-------------------------------------------
## ggplot(popgrowth_df,
##        aes(x = state,
##            y = 100*popgrowth)) +
##   geom_col(aes(fill = region),
##            alpha = 0.7) +
##   scale_fill_brewer(palette = "Set2") + #<<
##   coord_flip() +
##   guides(fill = "none")


## ----ref.label="brewer", echo=FALSE,  fig.height = 9.5--------------

