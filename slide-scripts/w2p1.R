## ---- setup, include = FALSE--------------------------------------------------------------------
knitr::opts_chunk$set(fig.width = 13, 
                      message = FALSE, 
                      warning = FALSE,
                      echo = FALSE)
source(here::here("wilke-purl", "wilke-dir-vis.R"))

update_geom_defaults('path', list(size = 3))
update_geom_defaults('point', list(size = 5))


## ----histo--------------------------------------------------------------------------------------
histo


## ----dens---------------------------------------------------------------------------------------
dens


## ----cum_dens-----------------------------------------------------------------------------------
cum_dens 


## ----qq-----------------------------------------------------------------------------------------
qq


## ----install-dviz.supp, eval = FALSE, echo = TRUE-----------------------------------------------
## remotes::install_github("clauswilke/dviz.supp")


## ----opts2, include = FALSE---------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
theme_set(theme_minimal(base_size = 25))


## ----show-titanic-------------------------------------------------------------------------------
head(titanic)


## ----age_hist, message = TRUE, fig.height = 6---------------------------------------------------
ggplot(titanic, aes(x = age)) +
  geom_histogram()


## ----age_hist2, message = TRUE, fig.height = 5--------------------------------------------------
ggplot(titanic, aes(x = age)) +
  geom_histogram(fill = "#56B4E9",
                 color = "white",
                 alpha = 0.9) 


## ----age_hist50, message = TRUE, fig.height = 6-------------------------------------------------
ggplot(titanic, aes(x = age)) +
  geom_histogram(fill = "#56B4E9",
                 color = "white",
                 alpha = 0.9,
                 bins = 50) #<<


## ----bins, echo = FALSE-------------------------------------------------------------------------
bw5 <- ggplot(titanic, aes(x = age)) +
  geom_histogram(fill = "#56B4E9",
                 color = "white",
                 alpha = 0.9,
                 bins = 5) +
  ggtitle("bins = 5")

bw25 <- ggplot(titanic, aes(x = age)) +
  geom_histogram(fill = "#56B4E9",
                 color = "white",
                 alpha = 0.9,
                 bins = 25) +
  ggtitle("bins = 25")

bw50 <- ggplot(titanic, aes(x = age)) +
  geom_histogram(fill = "#56B4E9",
                 color = "white",
                 alpha = 0.9,
                 bins = 50) +
  ggtitle("bins = 50")

library(patchwork)
bw5 + bw25 + bw50


## ----dens-titanic, fig.height = 6---------------------------------------------------------------
ggplot(titanic, aes(age)) +
  geom_density()


## ----dens-titanic-blue, fig.height = 6----------------------------------------------------------
ggplot(titanic, aes(age)) +
  geom_density(fill = "#56B4E9")


## ----dens-titanic5, fig.height = 5.5------------------------------------------------------------
ggplot(titanic, aes(age)) +
  geom_density(fill = "#56B4E9", 
               bw = 5)


## ----vary-bw, echo = FALSE----------------------------------------------------------------------
bw.5 <- ggplot(titanic, aes(x = age)) +
  geom_density(fill = "#56B4E9", 
               bw = .5) +
  ggtitle("bw = .5")

bw2 <- ggplot(titanic, aes(x = age)) +
  geom_density(fill = "#56B4E9", 
               bw = 2) +
  ggtitle("bw = 2")

bw5 <- ggplot(titanic, aes(x = age)) +
  geom_density(fill = "#56B4E9", 
               bw = 5) +
  ggtitle("bw = 5")

bw10 <- ggplot(titanic, aes(x = age)) +
  geom_density(fill = "#56B4E9", 
               bw = 10) +
  ggtitle("bw = 10")

(bw.5 + bw2) / (bw5 + bw10)


## ----qq-titanic, fig.height = 5.5---------------------------------------------------------------
ggplot(titanic, aes(sample = age)) +
  stat_qq_line(color = "#56B4E9") +
  geom_qq(color = "gray40") 


## ----theme-update-icon, include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(echo = FALSE)
theme_update(axis.text.x = element_blank(),
             axis.text.y = element_blank(),
             axis.title.x = element_blank(),
             axis.title.y = element_blank(),
             legend.position = "none")


## ----boxplots-----------------------------------------------------------------------------------
boxplots


## ----violin-------------------------------------------------------------------------------------
violin


## ----jittered-----------------------------------------------------------------------------------
jittered


## ----sina---------------------------------------------------------------------------------------
sina


## ----stacked-histo------------------------------------------------------------------------------
stacked_histo


## ----overlap-dens-------------------------------------------------------------------------------
overlap_dens


## ----ridgeline----------------------------------------------------------------------------------
ridgeline


## ----opts3, include = FALSE---------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
theme_set(theme_minimal(base_size = 25))


## ----boxplots-empirical, fig.height = 6.5-------------------------------------------------------
ggplot(titanic, aes(sex, age)) +
  geom_boxplot(fill = "#A9E5C5")


## ----violin-empirical, fig.height = 6.5---------------------------------------------------------
ggplot(titanic, aes(sex, age)) +
  geom_violin(fill = "#A9E5C5")


## ----jittered-empirical, fig.height = 6.5-------------------------------------------------------
ggplot(titanic, aes(sex, age)) +
  geom_jitter(width = 0.3, height = 0)


## ----sina-empirical, fig.height = 6.5-----------------------------------------------------------
ggplot(titanic, aes(sex, age)) +
  ggforce::geom_sina()


## ----stacked-histo-empirical, message = FALSE, fig.height = 5-----------------------------------
ggplot(titanic, aes(age)) +
  geom_histogram(aes(fill = sex))


## ----dodged-histo-empirical, message = FALSE, fig.height = 5------------------------------------
ggplot(titanic, aes(age)) +
  geom_histogram(aes(fill = sex), 
                 position = "dodge")


## ----wrapped-histo-empirical, message = FALSE, fig.height = 5.5---------------------------------
ggplot(titanic, aes(age)) +
  geom_histogram(fill = "#A9E5C5",
                 color = "white",
                 alpha = 0.9,) +
  facet_wrap(~sex) #<<


## ----overlap-dens-empirical, fig.height = 5-----------------------------------------------------
ggplot(titanic, aes(age)) +
  geom_density(aes(fill = sex),
               color = "white",
               alpha = 0.4)


## ----overlap-dens-empirical2--------------------------------------------------------------------
ggplot(titanic, aes(age)) +
  geom_density(aes(fill = sex),
               color = "white",
               alpha = 0.6) +
  scale_fill_manual(values = c("#11DC70", "#A9E5C5"))


## ----ridgeline-dens-empirical, fig.height = 6---------------------------------------------------
ggplot(titanic, aes(age, sex)) +
  ggridges::geom_density_ridges(color = "white",
                                fill = "#A9E5C5")


## ----theme-update, include = FALSE--------------------------------------------------------------
knitr::opts_chunk$set(echo = FALSE)
theme_update(axis.text.x = element_blank(),
             axis.text.y = element_blank(),
             axis.title.x = element_blank(),
             axis.title.y = element_blank(),
             legend.position = "none")


## ----bars---------------------------------------------------------------------------------------
bars


## ----flipped_bars-------------------------------------------------------------------------------
flipped_bars


## ----dots---------------------------------------------------------------------------------------
dots


## ----heatmap------------------------------------------------------------------------------------
heatmap


## ----opts4, include = FALSE---------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
theme_set(theme_minimal(base_size = 25))


## ----load_tuition-------------------------------------------------------------------------------
library(here)
library(rio)
tuition <- import(here("data", "us_avg_tuition.xlsx"),
                  setclass = "tbl_df")
head(tuition)


## ----state-tuition1, fig.height = 5-------------------------------------------------------------
ggplot(tuition, aes(State, `2015-16`)) +
  geom_col()


## ----state-tuition2, fig.height = 5-------------------------------------------------------------
ggplot(tuition, aes(State, `2015-16`)) +
  geom_col() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10))


## ----state-tuition3-echo, fig.height = 5, eval = FALSE------------------------------------------
## ggplot(tuition, aes(State, `2015-16`)) +
##   geom_col() +
##   coord_flip()


## ----state-tuition3-eval, echo = FALSE, fig.height = 9.5----------------------------------------
ggplot(tuition, aes(State, `2015-16`)) +
  geom_col() +
  coord_flip() +
  theme(axis.text.y = element_text(size = 13))


## ----state-tuition4-echo, eval = FALSE, fig.height = 9.5----------------------------------------
## ggplot(tuition, aes(fct_reorder(State, `2015-16`), `2015-16`)) +
##   geom_col() +
##   coord_flip()


## ----state-tuition4-eval, echo = FALSE, fig.height = 9.5----------------------------------------
ggplot(tuition, aes(fct_reorder(State, `2015-16`), `2015-16`)) +
  geom_col() +
  coord_flip() +
  theme(axis.text.y = element_text(size = 13))


## ----oregon-highlight-echo, eval = FALSE--------------------------------------------------------
## ggplot(tuition, aes(fct_reorder(State, `2015-16`), `2015-16`)) +
##   geom_col() +
##   geom_col(fill = "cornflowerblue",
##            data = filter(tuition, State == "Oregon")) +
##   coord_flip()


## ----oregon-highlight-eval, echo = FALSE, fig.height = 9.5--------------------------------------
ggplot(tuition, aes(fct_reorder(State, `2015-16`), `2015-16`)) +
  geom_col() +
  geom_col(fill = "cornflowerblue", 
           data = filter(tuition, State == "Oregon")) +
  coord_flip() +
  theme(axis.text.y = element_text(size = 13))


## ----income_df-sorted, echo = FALSE-------------------------------------------------------------
income_by_age %>% 
filter(race == "all") %>%
  ggplot(aes(x = fct_reorder(age, desc(median_income)), y = median_income)) +
    geom_col() +
    scale_y_continuous(
      expand = c(0, 0),
      name = "median income (USD)",
      breaks = c(0, 20000, 40000, 60000),
      labels = c("$0", "$20,000", "$40,000", "$60,000")
    ) +
    coord_cartesian(clip = "off") +
    xlab("age (years)") 


## ----income_df, echo = FALSE--------------------------------------------------------------------
income_by_age %>% 
filter(race == "all") %>%
  ggplot(aes(x = age, y = median_income)) +
    geom_col() +
    scale_y_continuous(
      expand = c(0, 0),
      name = "median income (USD)",
      breaks = c(0, 20000, 40000, 60000),
      labels = c("$0", "$20,000", "$40,000", "$60,000")
    ) +
    coord_cartesian(clip = "off") +
    xlab("age (years)") 


## ----tuition-data-------------------------------------------------------------------------------
head(tuition)


## ----gather-tution------------------------------------------------------------------------------
tuition %>%
  pivot_longer(`2004-05`:`2015-16`,
               names_to = "year", 
               values_to = "avg_tuition") 


## ----summaries----------------------------------------------------------------------------------
annual_means <- tuition %>%
  pivot_longer(`2004-05`:`2015-16`,
               names_to = "year", 
               values_to = "avg_tuition")  %>%
  group_by(year) %>%
  summarize(mean_tuition = mean(avg_tuition))

annual_means


## ----avg-tuition1-echo, eval = FALSE------------------------------------------------------------
## ggplot(annual_means, aes(year, mean_tuition)) +
##   geom_col()


## ----avg-tuition1-eval, echo = FALSE------------------------------------------------------------
ggplot(annual_means, aes(year, mean_tuition)) +
  geom_col() +
  theme(axis.text.x = element_text(size = 14))


## ----avg-tuition2-------------------------------------------------------------------------------
ggplot(annual_means, aes(year, mean_tuition)) +
  geom_col() +
  coord_flip()


## ----tuition3-----------------------------------------------------------------------------------
ggplot(annual_means, aes(year, mean_tuition)) +
  geom_point() +
  coord_flip()


## ----tuition4, fig.height = 5-------------------------------------------------------------------
annual_means %>%
  mutate(year = readr::parse_number(year)) %>%
  ggplot(aes(year, mean_tuition)) +
    geom_line(color = "cornflowerblue") +
    geom_point()


## ----tuition_l----------------------------------------------------------------------------------
tuition_l <- tuition %>%
    pivot_longer(-State,
                 names_to = "year", 
                 values_to = "avg_tuition") 

tuition_l


## ----heatmap2-echo, eval = FALSE----------------------------------------------------------------
## ggplot(tuition_l, aes(year, State)) +
##   geom_tile(aes(fill = avg_tuition))


## ----heatmap2-eval, echo = FALSE----------------------------------------------------------------
ggplot(tuition_l, aes(year, State)) +
  geom_tile(aes(fill = avg_tuition)) +
  theme_minimal(base_size = 12)


## ----heatmap3-echo, eval = FALSE----------------------------------------------------------------
## ggplot(tuition_l, aes(year, fct_reorder(State, avg_tuition))) +
##   geom_tile(aes(fill = avg_tuition))


## ----heatmap3-eval, echo = FALSE----------------------------------------------------------------
ggplot(tuition_l, aes(year, fct_reorder(State, avg_tuition))) +
  geom_tile(aes(fill = avg_tuition)) +
  theme_minimal(base_size = 12)


## ----heatmap4-echo, eval = FALSE----------------------------------------------------------------
## ggplot(tuition_l, aes(year, fct_reorder(State, avg_tuition))) +
##   geom_tile(aes(fill = avg_tuition)) +
##   scale_fill_viridis_c(option = "magma")


## ----heatmap4-eval, echo = FALSE----------------------------------------------------------------
ggplot(tuition_l, aes(year, fct_reorder(State, avg_tuition))) +
  geom_tile(aes(fill = avg_tuition)) +
  scale_fill_viridis_c(option = "magma") +
  theme_minimal(base_size = 12)


## ----heatmap5, echo = FALSE---------------------------------------------------------------------
hmap <- ggplot(tuition_l, aes(year, fct_reorder(State, avg_tuition))) +
  geom_tile(aes(fill = avg_tuition)) +
  scale_fill_viridis_c("Average Tuition Cost\n",
                       option = "magma",
                       labels = scales::dollar) +
  theme_minimal(base_size = 15) + 
  theme(panel.grid.major = element_line(size = 0), 
        panel.grid.minor = element_line(size = 0), 
        axis.text.x = element_text(colour = "gray"), 
        axis.text.y = element_text(colour = "gray"), 
        panel.background = element_rect(fill = "black"), 
        plot.background = element_rect(fill = "black", 
        color = "black"), 
        legend.background = element_rect(fill = "black"), 
        legend.text = element_text(size = 9, colour = "gray"), 
        legend.position = c(0.65, 1.03), 
        legend.direction = "horizontal",
        legend.title = element_text(colour = "gray"),
        legend.key.width = unit(4, unit = "cm"),
        plot.margin = margin(1.5, 0, 0, 0, "cm")) 
ggsave(here::here("slides", "img", "heatmap.png"),
       width = 16,
       height = 12)


## ----geographic---------------------------------------------------------------------------------
#install.packages(c("maps"))
state_data <- map_data("state") %>% # ggplot2::map_data
  rename(State = region)



## ----join---------------------------------------------------------------------------------------
tuition <- tuition %>% 
  mutate(State = tolower(State))
states <- left_join(state_data, tuition)
head(states)


## ----gather-states------------------------------------------------------------------------------
states <- states %>% 
  gather(year, tuition, `2004-05`:`2015-16`)
head(states)


## ----usa-plot, fig.height = 5.5-----------------------------------------------------------------
ggplot(states) +
  geom_polygon(aes(long, lat, group = group, fill = tuition)) +
  coord_fixed(1.3) + #<<
  scale_fill_viridis_c(option = "magma") +
  facet_wrap(~year) 


## ----heatmap-country, include = FALSE-----------------------------------------------------------
usa <- map_data("usa")
states_plot <- ggplot(states) +
  geom_polygon(aes(long, lat, group = group), 
               usa,
               color = "gray") +
  geom_polygon(aes(long, lat, group = group, fill = tuition)) +
  scale_fill_viridis_c("Average tution", option = "magma") +
  facet_wrap(~year) +
  coord_fixed(1.3) +
  theme(strip.background = element_rect(fill="gray0"),
        strip.text = element_text(colour = 'gray'),
        panel.grid.major = element_line(size = 0), 
        panel.grid.minor = element_line(size = 0), 
        axis.text.x = element_text(colour = "gray0"), 
        axis.text.y = element_text(colour = "gray0"), 
        legend.text = element_text(size = 7, colour = "gray"),
        legend.title = element_text(size = 10, colour = "gray"),
        panel.background = element_rect(fill = "gray0"), 
        plot.background = element_rect(fill = "gray0", 
                                       colour = "gray0"), 
        legend.background = element_rect(fill = "gray0"), 
        legend.position = c(0.03, -0.05), 
        legend.direction = "horizontal",
        plot.margin = margin(0, 0, 0, 0, "cm"))
ggsave(here::here("slides", "img", "states-heatmap.png"),
       width = 16,
       height = 12)

