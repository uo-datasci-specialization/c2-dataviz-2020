## ----setup, include = FALSE-----------------------------------------
knitr::opts_chunk$set(fig.width = 13, 
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


## ----loc_point, echo = FALSE----------------------------------------
ggplot(data.frame(x = -5:5, y = -5:5), aes(x, y)) +
  geom_point(data = data.frame(x = 3, y = 2),
             color = "magenta",
             size = 5) +
  geom_segment(aes(x = 5, xend = 3.2, y = 4, yend = 2.2),
               arrow = arrow(length = unit(0.5, "cm"),
                             type = "closed"),
               color = "gray40") +
  geom_vline(xintercept = 0, 
             color = "gray40",
             size = 1.4) +
  geom_hline(yintercept = 0,
             color = "gray40",
             size = 1.4) +
  scale_x_continuous(limits = c(-5, 5), breaks = seq(-5, 5, 2)) +
  scale_y_continuous(limits = c(-5, 5), breaks = seq(-5, 5, 2)) +
  coord_fixed()


## ----error_bars, echo = FALSE, fig.height = 6-----------------------
ggplot(data.frame(x = -5:5, y = -5:5), aes(x, y)) +
  geom_errorbar(data = data.frame(x = 3, y = 2),
               aes(ymin = 1.5, ymax = 2.5),
               color = "gray40",
               size = 1.4) +
  geom_point(data = data.frame(x = 3, y = 2),
             color = "magenta",
             size = 5) +
  geom_vline(xintercept = 0, 
             color = "gray40",
             size = 1.4) +
  geom_hline(yintercept = 0,
             color = "gray40",
             size = 1.4) +
  scale_x_continuous(limits = c(-5, 5), breaks = seq(-5, 5, 2)) +
  scale_y_continuous(limits = c(-5, 5), breaks = seq(-5, 5, 2)) +
  coord_fixed()


## ----mpg_se---------------------------------------------------------
mpg_by_man <- mpg %>%
  group_by(manufacturer) %>%
  summarize(mean_cty = mean(cty),
            se_cty = sundry::se(cty))

head(mpg_by_man)


## ----mpg_plot1------------------------------------------------------
ggplot(mpg_by_man, aes(fct_reorder(manufacturer, mean_cty), mean_cty)) +
  geom_errorbar(aes(ymin = mean_cty + qnorm(0.025)*se_cty, 
                    ymax = mean_cty + qnorm(0.975)*se_cty))



## ----mpg_plot2, fig.height = 6--------------------------------------
ggplot(mpg_by_man, aes(fct_reorder(manufacturer, mean_cty), mean_cty)) +
  geom_errorbar(aes(ymin = mean_cty + qnorm(0.025)*se_cty, 
                    ymax = mean_cty + qnorm(0.975)*se_cty),
                color = "gray40") +
   geom_point()


## ----mpg_plot3, fig.height = 6--------------------------------------
ggplot(mpg_by_man, aes(fct_reorder(manufacturer, mean_cty), mean_cty)) +
  geom_errorbar(aes(ymin = mean_cty - 1.96*se_cty, 
                    ymax = mean_cty + 1.96*se_cty),
                color = "gray40") +
   geom_point() +
   coord_flip()


## ----props_df-------------------------------------------------------
props <- mpg %>%
  count(drv, year) %>%
  mutate(prop = n/sum(n), 
         prop_se = sqrt((prop*(1-prop)) / n))

head(props)


## ----props_plot1----------------------------------------------------
ggplot(props, aes(drv, prop)) +
  geom_col(aes(fill = factor(year)), position = "dodge")


## ----props_plot2----------------------------------------------------
ggplot(props, aes(drv, prop)) +
  geom_col(aes(fill = factor(year)), position = "dodge") +
  geom_errorbar(aes(ymin = prop - 1.96*prop_se, 
                    ymax = prop + 1.96*prop_se),
                color = "gray40")


## ----props_plot3, fig.height = 6------------------------------------
pd <- position_dodge(.9) #<<
ggplot(props, aes(drv, prop)) +
  geom_col(aes(fill = factor(year)), position = pd) + #<<
  geom_errorbar(aes(ymin = prop - 1.96*prop_se, 
                    ymax = prop + 1.96*prop_se),
                color = "gray40",
                position = pd) #<<


## ----props_plot4, fig.height = 5.5----------------------------------
pd <- position_dodge(.9)
ggplot(props, aes(drv, prop)) +
  geom_col(aes(fill = factor(year)), position = pd) +
  geom_errorbar(aes(ymin = prop - 1.96*prop_se, 
                    ymax = prop + 1.96*prop_se,
                    group = year), #<<
                color = "gray40",
                position = pd)


## ----props_plot5-echo, eval = FALSE---------------------------------
## pd <- position_dodge(.9)
## ggplot(props, aes(drv, prop)) +
##   geom_col(aes(fill = factor(year)), position = pd) +
##   geom_errorbar(aes(ymin = ifelse(prop - 1.96*prop_se < 0, #<<
##                                   0, #<<
##                                   prop - 1.96*prop_se), #<<
##                     ymax = prop + 1.96*prop_se,
##                     group = year),
##                 color = "gray40",
##                 position = pd,
##                 width = 0.5, #<<
##                 size = 1.4) #<<


## ----props_plot5-eval, echo = FALSE---------------------------------
pd <- position_dodge(.9)
ggplot(props, aes(drv, prop)) +
  geom_col(aes(fill = factor(year)), position = pd) +
  geom_errorbar(aes(ymin = ifelse(prop - 1.96*prop_se < 0, 
                                  0, 
                                  prop - 1.96*prop_se), 
                    ymax = prop + 1.96*prop_se,
                    group = year),
                color = "gray40",
                position = pd,
                width = 0.5,
                size = 1.4) 


## ----single-probability, options------------------------------------
grid <- expand.grid(x = 1:20, y = 1:20)
head(grid)
tail(grid)


## ----see-grid-------------------------------------------------------
ggplot(grid, aes(x, y)) +
  geom_tile(color = "gray40",
            fill = "white")


## ----prevalence1----------------------------------------------------
nrow(grid)*.10 # n to sample

set.seed(86753098)
samp <- sample(seq_len(nrow(grid)), nrow(grid)*.10)
head(samp)
length(samp)


## ----create_occurence-----------------------------------------------
grid <- grid %>% 
  rownames_to_column("row_id") %>% 
  mutate(event = ifelse(row_id %in% samp, "Yes", "No"))
head(grid)


## ----theatre1-------------------------------------------------------
ggplot(grid, aes(x, y)) +
  geom_tile(aes(fill = event), color = "white")


## ----theatre2-echo, eval = FALSE------------------------------------
## ggplot(grid, aes(x, y)) +
##   geom_tile(aes(fill = event), color = "white", size = 1.4) +
##   scale_fill_manual("Event Occurred",
##                     values = c(
##                       colorspace::desaturate(
##                         colorspace::lighten("#1694E8", 0.5),
##                       0.7),
##                       "#1694E8")
##                     ) +
##   coord_fixed() +
##   theme_void() +
##   theme(legend.position = c(0.75, 0),
##         legend.direction = "horizontal",
##         plot.margin = margin(b = 1, unit = "cm"))


## ----theatre2-eval, echo = FALSE, fig.height = 9--------------------
ggplot(grid, aes(x, y)) +
  geom_tile(aes(fill = event), color = "white", size = 1.4) +
  scale_fill_manual("Event Occurred", 
                    values = c(
                      colorspace::desaturate(
                        colorspace::lighten("#1694E8", 0.5),
                      0.7),
                      "#1694E8")
                    ) +
  coord_fixed() +
  theme_void(base_size = 35) +
  theme(legend.position = "bottom",
        legend.key.size = unit(2,"line"),
        plot.margin = margin(b = 2, unit = "cm"))


## ----rain1, echo = FALSE, fig.height = 8.5--------------------------
grid <- expand.grid(x = 1:20, y = 1:20)
samp <- sample(seq_len(nrow(grid)), nrow(grid)*.80)

grid %>% 
  rownames_to_column("row_id") %>% 
  mutate(event = ifelse(row_id %in% samp, "Yes", "No")) %>% 
  ggplot(aes(x, y)) +
  geom_tile(aes(fill = event), color = "white", size = 1.4) +
  scale_fill_manual("Event Occurred", 
                    values = c(
                      colorspace::desaturate(
                        colorspace::lighten("#1694E8", 0.5),
                      0.7),
                      "#1694E8")) +
  coord_fixed() +
  theme_void(base_size = 35) +
  theme(legend.position = "bottom",
        legend.key.size = unit(2,"line"),
        plot.margin = margin(b = 2, unit = "cm"))


## ----rain2, echo = FALSE--------------------------------------------
g10 <- expand.grid(x = 1:10, y = 1:10)
g20 <- expand.grid(x = 1:20, y = 1:20)
g30 <- expand.grid(x = 1:30, y = 1:30)

samp10 <- sample(seq_len(nrow(g10)), nrow(g10)*.80)
samp20 <- sample(seq_len(nrow(g20)), nrow(g20)*.80)
samp30 <- sample(seq_len(nrow(g30)), nrow(g30)*.80)

p10 <- g10 %>% 
  rownames_to_column("row_id") %>% 
  mutate(event = ifelse(row_id %in% samp10, "Yes", "No")) %>% 
  ggplot(aes(x, y)) +
  geom_tile(aes(fill = event), color = "white", size = 1.4) +
  scale_fill_manual("Event Occurred", 
                    values = c(
                      colorspace::desaturate(
                        colorspace::lighten("#1694E8", 0.5),
                      0.7),
                      "#1694E8")) +
  coord_fixed() +
  theme_void() +
  guides(fill = "none")

p20 <- g20 %>% 
  rownames_to_column("row_id") %>% 
  mutate(event = ifelse(row_id %in% samp20, "Yes", "No")) %>% 
  ggplot(aes(x, y)) +
  geom_tile(aes(fill = event), color = "white", size = 1.4) +
  scale_fill_manual("Event Occurred", 
                    values = c(
                      colorspace::desaturate(
                        colorspace::lighten("#1694E8", 0.5),
                      0.7),
                      "#1694E8")) +
  coord_fixed() +
  theme_void() +
  guides(fill = "none")

p30 <- g30 %>% 
  rownames_to_column("row_id") %>% 
  mutate(event = ifelse(row_id %in% samp30, "Yes", "No")) %>% 
  ggplot(aes(x, y)) +
  geom_tile(aes(fill = event), color = "white", size = 1.4) +
  scale_fill_manual("Event Occurred", 
                    values = c(
                      colorspace::desaturate(
                        colorspace::lighten("#1694E8", 0.5),
                      0.7),
                      "#1694E8")) +
  coord_fixed() +
  theme_void() +
  guides(fill = "none")
p10 


## ----grid-size20, echo = FALSE--------------------------------------
p20


## ----grid-size30, echo = FALSE--------------------------------------
p30


## ----pdf, echo = FALSE, fig.height = 5.5----------------------------
# Wilke code
x <- c(seq(-2.5, 0, length.out = 50), seq(0.00001, 5, length.out = 100))
mu <- 1.02
sd <- .9

df_norm <- data.frame(
  x,
  y = dnorm(x, mu, sd),
  type = ifelse(x <= 0, "A", "B")
)

ci_x <- c(qnorm(.025, mu, sd), qnorm(0.975, mu, sd))
ci_y <- dnorm(ci_x, mu, sd)

df_annot <- data.frame(
  x = c(mu + 0.05, mu + 0.1, mu + 2.3*sd, mu - 2.5*sd),
  y = c(dnorm(mu, mu, sd) + 0.04, ci_y[1] + 0.01, 3*ci_y[1], 3*ci_y[1]),
  hjust = c(0, 0, 0.5, 0.5),
  vjust = c(1, 0, 0.5, 0.5),
  label = c("best estimate", "margin of error", "blue wins", "yellow wins")
)

ggplot(df_norm, aes(x, y)) +
  geom_area(aes(fill = type)) +
  geom_vline(xintercept = 0, linetype = 4, color = "gray50", size = 1.4) +
  geom_line() +
  geom_segment(
    data = data.frame(x = 1),
    x = ci_x[1], xend = ci_x[2], y = ci_y[1], yend = ci_y[2],
    arrow = arrow(angle = 15, length = grid::unit(15, "pt"), ends = "both", type = "closed"),
    inherit.aes = FALSE
  ) +
  geom_segment(
    data = data.frame(x = 1),
    x = mu, xend = mu, y = 0, yend = dnorm(mu, mu, sd) + 0.04,
    inherit.aes = FALSE
  ) +
  geom_text(
    data = df_annot,
    aes(x, y, label = label, hjust = hjust, vjust = vjust),
    family = dviz_font_family
  ) +
  scale_x_continuous(
    name = "percentage point advantage for blue",
    labels = scales::percent_format(accuracy = 0.1, scale = 1)
  ) +
  scale_y_continuous(
    name = NULL,
    breaks = NULL,
    expand = c(0, 0),
    limits = c(0, dnorm(mu, mu, sd) + 0.045)
  ) +
  scale_fill_manual(
    values = c(A = "#f8f1a9", B = "#b1daf4"),
    guide = "none"
  ) +
  theme_dviz_open(20, font_family = "Roboto Light")


## ----dnorm, fig.height = 5------------------------------------------
x <- seq(-5, 5, 0.001)
likelihood <- dnorm(x, 1.02, 0.9)
sim <- data.frame(x, likelihood)
ggplot(sim, aes(x, likelihood)) +
  geom_line(size = 1.2)


## ----auc, echo = FALSE----------------------------------------------
x <- seq(-5, 5, 0.001)
likelihood <- dnorm(x, 1.02, 0.9)
sim <- data.frame(x, likelihood)
ggplot(sim, aes(x, likelihood)) +
  geom_area(data = filter(sim, x <= 0),
            fill = "orchid1") +
  geom_line() 


## ----integrate------------------------------------------------------
zab <- filter(sim, x <= 0)
pracma::trapz(zab$x, zab$likelihood)


## ----label, options-------------------------------------------------
random_draws <- rnorm(1e5, 1.02, 0.9)
table(random_draws > 0) / 1e5


## ----qqpoints1------------------------------------------------------
ppoints(50)
qnorm(ppoints(50), 1.02, 0.9)


## ----qqpoints2------------------------------------------------------
discretized <- data.frame(x = qnorm(ppoints(50), 1.02, 0.9)) %>% 
  mutate(winner = ifelse(x <= 0, "#b1daf4", "#f8f1a9"))

head(discretized) 
tail(discretized)


## ----dotplot1-------------------------------------------------------
ggplot(discretized, aes(x)) +
  geom_dotplot()


## ----dotplot2-------------------------------------------------------
ggplot(discretized, aes(x)) +
  geom_dotplot(aes(fill = winner))


## ----dotplot3-------------------------------------------------------
ggplot(discretized, aes(x)) +
  geom_dotplot(aes(fill = winner), binwidth = 0.29)


## ----dotplot4-------------------------------------------------------
ggplot(discretized, aes(x)) +
  geom_dotplot(aes(fill = winner), binwidth = 0.29) +
  geom_vline(xintercept = 0, color = "gray40", linetype = 2, size = 3)


## ----dotplot5, fig.height = 6---------------------------------------
ggplot(discretized, aes(x)) +
  geom_dotplot(aes(fill = winner), binwidth = 0.26) +
  geom_vline(xintercept = 0, color = "gray40", linetype = 2, size = 3) +
  scale_fill_identity(guide = "none") +
  scale_y_continuous(name = "", 
                     breaks = NULL)


## ----descritized2-echo, eval = FALSE--------------------------------
## discretized2 <- data.frame(x = qnorm(ppoints(20), 1.02, 0.9)) %>%
##   mutate(winner = ifelse(x <= 0, "#b1daf4", "#f8f1a9"))
## 
## ggplot(discretized2, aes(x)) +
##   geom_dotplot(aes(fill = winner), binwidth = 0.4) +
##   geom_vline(xintercept = 0.1, color = "gray40", linetype = 2, size = 1.4) +
##   scale_fill_identity(guide = "none") +
##   scale_x_continuous(name = "",
##                      limits = c(-1, 3),
##                      labels = scales::percent_format(scale = 1)) +
##   theme_dviz_open(20, font_family = "Roboto Light") +
##   scale_y_continuous(breaks = NULL,
##                      name = "") +
##   labs(caption = "Each ball represents 5% probability")


## ----descritized2-eval, echo = FALSE--------------------------------
discretized2 <- data.frame(x = qnorm(ppoints(20), 1.02, 0.9)) %>% 
  mutate(winner = ifelse(x <= 0, "#b1daf4", "#f8f1a9"))

ggplot(discretized2, aes(x)) +
  geom_dotplot(aes(fill = winner), binwidth = 0.4) +
  geom_vline(xintercept = 0.1, color = "gray40", linetype = 2, size = 1.4) +
  scale_fill_identity(guide = "none") +
  scale_x_continuous(name = "", 
                     limits = c(-1, 3),
                     labels = scales::percent_format(scale = 1)) +
  theme_dviz_open(20, font_family = "Roboto Light") +
  scale_y_continuous(breaks = NULL,
                     name = "") +
  labs(caption = "Each ball represents 5% probability")


## ----sim1-----------------------------------------------------------
set.seed(123)
samp10a <- rnorm(n = 10, mean = 100, sd = 10)
samp10a


## ----mean_sim1------------------------------------------------------
mean(samp10a)


## ----sim2-----------------------------------------------------------
samp10b <- rnorm(n = 10, mean = 100, sd = 10)
samp10b

mean(samp10b)


## ----sim3-----------------------------------------------------------
# from purrr (base methods work basically just as well in this case)
samples <- rerun(1000, rnorm(10, mean = 100, sd = 10))
samples


## ----sim3_means-----------------------------------------------------
head(
     map_dbl(samples, mean)
     )


## ----sim3_sd--------------------------------------------------------
sd(map_dbl(samples, mean))


## ----sim4-----------------------------------------------------------
samples2 <- rerun(1000, rnorm(100, mean = 100, sd = 10)) 
sd(map_dbl(samples2, mean))


## ----sampling_dist--------------------------------------------------
sample_means <- tibble(iter = rep(1:1000, 2),
                       sample = rep(c(10, 100), each = 1000),
                       mean = c(map_dbl(samples, mean),
                                map_dbl(samples2, mean))
                       )
sample_means


## ----sampling_dist_vis----------------------------------------------
ggplot(sample_means, aes(mean)) +
  geom_density(aes(fill = factor(sample)), alpha = 0.3)


## ----model----------------------------------------------------------
m <- lm(cty ~ displ + class, mpg)
summary(m)


## ----broom----------------------------------------------------------
library(broom)
tidied_m <- tidy(m, conf.int = TRUE)

tidied_m


## ----broom_viz1-----------------------------------------------------
ggplot(tidied_m, aes(term, estimate)) +
  geom_hline(yintercept = 0,
             color = "cornflowerblue",
             linetype = 2) +
  geom_errorbar(aes(ymin = conf.low, ymax = conf.high)) +
  geom_point() +
  coord_flip()


## ----multiple-error-echo, eval = FALSE------------------------------
## library(colorspace)
## ggplot(tidied_m, aes(term, estimate)) +
##   geom_hline(yintercept = 0,
##              color = "cornflowerblue",
##              linetype = 2) +
##   geom_errorbar(aes(ymin = estimate + qnorm(.025)*std.error,
##                     ymax = estimate + qnorm(.975)*std.error),
##                 color = lighten("#4375D3", .6),
##                 width = 0.2,
##                 size = 0.8) + # 95% CI
##   geom_errorbar(aes(ymin = estimate + qnorm(.05)*std.error,
##                     ymax = estimate + qnorm(.95)*std.error),
##                 color = lighten("#4375D3", .3),
##                 width = 0.2,
##                 size = 1.2) + # 90% CI
##   geom_errorbar(aes(ymin = estimate + qnorm(.1)*std.error,
##                     ymax = estimate + qnorm(.9)*std.error),
##                 color = "#4375D3",
##                 width = 0.2,
##                 size = 1.6) + # 80% CI
##   geom_point() +
##   coord_flip()


## ----multiple-error-eval, echo = FALSE, fig.height = 9--------------
library(colorspace)
ggplot(tidied_m, aes(term, estimate)) +
  geom_hline(yintercept = 0,
             color = "cornflowerblue",
             linetype = 2) +
  geom_errorbar(aes(ymin = estimate + qnorm(.025)*std.error, 
                    ymax = estimate + qnorm(.975)*std.error),
                color = lighten("#4375D3", .6),
                width = 0.2,
                size = 0.8) + # 95% CI
  geom_errorbar(aes(ymin = estimate + qnorm(.05)*std.error, 
                    ymax = estimate + qnorm(.95)*std.error),
                color = lighten("#4375D3", .3),
                width = 0.2,
                size = 1.2) + # 90% CI
  geom_errorbar(aes(ymin = estimate + qnorm(.1)*std.error, 
                    ymax = estimate + qnorm(.9)*std.error),
                color = "#4375D3",
                width = 0.2,
                size = 1.6) + # 80% CI
  geom_point() +
  coord_flip()


## ----add_legend-echo, fig.show = "hide"-----------------------------
p <- ggplot(tidied_m, aes(term, estimate)) +
  geom_hline(yintercept = 0,
             color = "cornflowerblue",
             linetype = 2) +
  geom_errorbar(aes(ymin = estimate + qnorm(.025)*std.error, 
                    ymax = estimate + qnorm(.975)*std.error,
                    color = "95%"),
                width = 0.2,
                size = 0.8) + 
  geom_errorbar(aes(ymin = estimate + qnorm(.05)*std.error, 
                    ymax = estimate + qnorm(.95)*std.error,
                    color = "90%"),
                width = 0.2,
                size = 1.2) + # 90% CI
  geom_errorbar(aes(ymin = estimate + qnorm(.1)*std.error, 
                    ymax = estimate + qnorm(.9)*std.error,
                    color = "80%"),
                width = 0.2,
                size = 1.6) # 80% CI


## ----show-p---------------------------------------------------------
p


## ----add-legend-p, eval = FALSE-------------------------------------
## p +
##   scale_color_manual("Confidence Interval",
##                      values = c("#4375D3",
##                                 lighten("#4375D3", .3),
##                                 lighten("#4375D3", .6))) +
##   geom_point() +
##   coord_flip()
## 


## ----add_legend-eval, echo = FALSE, fig.height = 9------------------
ggplot(tidied_m, aes(term, estimate)) +
  geom_hline(yintercept = 0,
             color = "cornflowerblue",
             linetype = 2) +
  geom_errorbar(aes(ymin = estimate + qnorm(.025)*std.error, 
                    ymax = estimate + qnorm(.975)*std.error,
                    color = "95%"),
                width = 0.2,
                size = 0.8) + 
  geom_errorbar(aes(ymin = estimate + qnorm(.05)*std.error, 
                    ymax = estimate + qnorm(.95)*std.error,
                    color = "90%"),
                width = 0.2,
                size = 1.2) + # 90% CI
  geom_errorbar(aes(ymin = estimate + qnorm(.1)*std.error, 
                    ymax = estimate + qnorm(.9)*std.error,
                    color = "80%"),
                width = 0.2,
                size = 1.6) + # 80% CI
  scale_color_manual("Confidence Interval",
                     values = c("#4375D3",
                                lighten("#4375D3", .3),
                                lighten("#4375D3", .6))) +
  geom_point() +
  coord_flip()


## ----density-stripes, fig.height = 5.5------------------------------
#devtools::install_github("wilkelab/ungeviz")
library(ungeviz)
ggplot(tidied_m, aes(estimate, term)) +
  stat_confidence_density(aes(moe = std.error),
                          fill = "#4375D3",
                          height = 0.6) +
  xlim(-10, 35) +
  geom_point()


## ----densities, fig.height = 4--------------------------------------
library(ggridges)
ggplot(tidied_m, aes(estimate, term)) +
  stat_confidence_density(aes(moe = std.error, 
                              height = stat(density)),
                          geom = "ridgeline",
                          confidence = 0.95,
                          min_height = 0.001,
                          alpha = 0.7,
                          fill = "#4375D3") +
  xlim(-10, 35) 


## ----loess1---------------------------------------------------------
ggplot(mtcars, aes(disp, mpg)) +
  geom_point() +
  geom_smooth()


## ----bootstrap1, echo = FALSE---------------------------------------
samps <- rerun(100,
      sample(seq_len(nrow(mtcars)), nrow(mtcars), replace = TRUE))
d_samps <- map_df(samps, ~mtcars[., ], .id = "sample")

ggplot(mtcars, aes(disp, mpg)) +
  geom_point() +
  geom_smooth(aes(group = sample), 
              data = d_samps, 
              se = FALSE,
              color = "#4375D3",
              fullrange = TRUE,
              size = 0.1)


## ----bootstrap2a----------------------------------------------------
row_samps <- rerun(100,
      sample(seq_len(nrow(mtcars)), 
             nrow(mtcars), 
             replace = TRUE))
row_samps


## ----bootstrap2b----------------------------------------------------
d_samps <- map_df(row_samps, ~mtcars[., ], .id = "sample")
head(d_samps)
tail(d_samps)


## ----bootstrap2c-echo, eval = FALSE---------------------------------
## ggplot(mtcars, aes(disp, mpg)) +
##   geom_point() +
##   stat_smooth(aes(group = sample),
##               data = d_samps,
##               geom = "line",
##               color = "#4375D3",
##               fullrange = TRUE,
##               size = 0.1)


## ----bootstrap2c-eval, echo = FALSE, fig.height = 9-----------------
ggplot(mtcars, aes(disp, mpg)) +
  geom_point() +
  stat_smooth(aes(group = sample),
              data = d_samps,
              geom = "line",
              color = "#4375D3",
              fullrange = TRUE,
              size = 0.1)


## ----bootstrap2d-echo, eval = FALSE---------------------------------
## ggplot(mtcars, aes(disp, mpg)) +
##   geom_point() +
##   geom_smooth(color = "magenta") +
##   stat_smooth(aes(group = sample),
##               data = d_samps,
##               geom = "line",
##               color = "#4375D3",
##               fullrange = TRUE,
##               size = 0.1)


## ----bootstrap2d-eval, echo = FALSE, fig.height = 9-----------------
ggplot(mtcars, aes(disp, mpg)) +
  geom_point() +
  geom_smooth(color = "magenta") +
  stat_smooth(aes(group = sample),
              data = d_samps,
              geom = "line",
              color = "#4375D3",
              fullrange = TRUE,
              size = 0.1)


## ----hop1, echo = FALSE, eval = FALSE-------------------------------
## library(gganimate)
## ggplot(mtcars, aes(disp, mpg)) +
##   geom_point() +
##   stat_smooth(data = d_samps,
##               geom = "line",
##               size = 2,
##               color = "#4375D3",
##               fullrange = TRUE) +
##   transition_states(sample,
##                     transition_length = 0.5,
##                     state_length = 0.5) +
##    ease_aes('linear') +
##   theme_minimal()
## anim_save(here::here("slides", "w7p1_files", "loess_hop.gif"),
##           fps = 1,
##           width = 13)


## ----gganimate, eval = FALSE----------------------------------------
## library(gganimate)
## ggplot(mtcars, aes(disp, mpg)) +
##   geom_point() +
##   stat_smooth(data = d_samps,
##               geom = "line",
##               size = 2,
##               color = "#4375D3",
##               fullrange = TRUE) +
##   transition_states(sample,
##                     transition_length = 0.5,
##                     state_length = 0.5) +
##    ease_aes('linear') # Smoother transitions

