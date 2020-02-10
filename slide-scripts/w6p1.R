## ----setup, include = FALSE-----------------------------------------
knitr::opts_chunk$set(fig.width = 13, 
                      message = FALSE, 
                      warning = FALSE,
                      echo = TRUE)

library(tidyverse)
library(socviz)
library(countdown)

theme_set(theme_minimal(25))

source(here::here("wilke-purl", "wilke-coordinate_systems_axes.R"))
source(here::here("wilke-purl", "wilke-figure_titles_captions.R"))
#source(here::here("resources", "wilke-redundant_coding.R"))
#source(here::here("resources", "wilke-proportions.R"))

update_geom_defaults('path', list(size = 3))
update_geom_defaults('point', list(size = 4))
update_geom_defaults('text_repel', list(size = 6))
update_geom_defaults('text', list(size = 6))


## ----cartesian1, echo = FALSE---------------------------------------
cartesian


## ----temp_plot, echo = FALSE----------------------------------------
temp_plot


## ----aspect-ratio, echo = FALSE, fig.height = 8---------------------
plot_grid(
  plot_grid(temp_plot, temp_plot, rel_widths = c(1, 2)),
  temp_plot, rel_heights = c(1.5, 1), label_y = c(1, 1.15), 
  ncol = 1)


## ----same-scales, echo = FALSE--------------------------------------
tempsplot_F 


## ----path-size1, echo = FALSE, cache = FALSE------------------------
update_geom_defaults('path', list(size = 1.2))


## ----scale_transoform1, fig.width = 7, fig.height = 5.5-------------
library(gapminder)
ggplot(gapminder, aes(year, gdpPercap)) +
  geom_line(aes(group = country),
            color = "gray70")


## ----scale_transform2, fig.width = 7, fig.height = 5.5--------------
ggplot(gapminder, aes(year, gdpPercap)) +
  geom_line(aes(group = country),
            color = "gray70") +
  scale_y_log10(
    labels = scales::dollar #<<
  ) 


## ----scale_transform3, echo = FALSE, fig.width = 15-----------------
ggplot(gapminder, aes(year, gdpPercap)) + 
  geom_line(color="gray70", aes(group = country)) +
  geom_smooth(size = 1.1, method = "loess", se = FALSE) +
  facet_wrap(~ continent, ncol = 5) +
  labs(x = "Year",
       y = "GDP per capita",
       title = "GDP per capita on Five Continents") +
  scale_x_continuous(breaks = seq(1950L, 2000L, 25)) +
  theme(panel.spacing.x = unit(2, "lines"))


## ----scale_transform4, echo = FALSE, fig.width = 15-----------------
ggplot(gapminder, aes(year, gdpPercap)) + 
  geom_line(color="gray70", aes(group = country)) +
  geom_smooth(size = 1.1, method = "loess", se = FALSE) +
  scale_y_log10(labels=scales::dollar) +
  facet_wrap(~ continent, ncol = 5) +
  labs(x = "Year",
       y = "GDP per capita",
       title = "GDP per capita on Five Continents") +
  scale_x_continuous(breaks = seq(1950L, 2000L, 25)) +
  theme(panel.spacing.x = unit(2, "lines"))


## ----path-size2, echo = FALSE, cache = FALSE------------------------
update_geom_defaults('path', list(size = 2))


## ----labeling-non-linear1, fig.show = 'hold', fig.height = 3, eval = FALSE----
## d <- tibble(x = c(1, 3.16, 10, 31.6, 100),
##             log_x = log10(x))
## 
## ggplot(d, aes(x, 1)) +
##   geom_point(color = "#0072B2")
## 
## ggplot(d, aes(x, 1)) +
##   geom_point(color = "#0072B2") +
##   scale_x_log10()
## 
## ggplot(d, aes(log_x, 1)) +
##   geom_point(color = "#0072B2")


## ----labeling-non-linear2, fig.show = 'hold', fig.height = 3, echo = FALSE----
d <- tibble(x = c(1, 3.16, 10, 31.6, 100),
            log_x = log10(x))

ggplot(d, aes(x, 1)) +
  geom_point(color = "#0072B2")

ggplot(d, aes(x, 1)) +
  geom_point(color = "#0072B2") +
  scale_x_log10()

ggplot(d, aes(log_x, 1)) +
  geom_point(color = "#0072B2") 


## .code-bg-red .remark-code, .code-bg-red .remark-code * {

##  background-color:#ffe0e0!important;

## }


## ----bad-log--------------------------------------------------------
ggplot(d, aes(log_x, 1)) +
  geom_point(color = "#0072B2") +
  scale_x_log10()


## ----log-data, fig.height = 3---------------------------------------
library(ggtext)
ggplot(d, aes(log_x, 1)) +
  geom_point(color = "#0072B2") +
  labs(x = "log<sub>10</sub>(x)") +  #<<
  theme(axis.title.x = element_markdown()) #<<


## ----log-scale, fig.height = 3--------------------------------------
ggplot(d, aes(x, 1)) +
  geom_point(color = "#0072B2") +
  scale_x_log10() #<<


## ----no-x, echo = FALSE, fig.height = 6-----------------------------
price_plot_base + xlab(NULL) + ylab("stock price, indexed")


## ----no-xy, echo = FALSE--------------------------------------------
price_plot_base + xlab(NULL) + ylab(NULL)


## ----overdone-labels, echo = FALSE----------------------------------
price_plot_base + xlab("time (years AD)") + ylab("stock price, indexed\n(100/share price on Jun 1, 2012)")


## ----install-dviz.supp, eval = FALSE--------------------------------
## remotes::install_github("clauswilke/dviz.supp")
## head(tech_stocks)


## ----tech-stocks, echo = FALSE--------------------------------------
head(tech_stocks)


## ----tech1----------------------------------------------------------
ggplot(tech_stocks, aes(date, price_indexed, color = ticker)) +
  geom_line()


## ----tech2----------------------------------------------------------
ggplot(tech_stocks, aes(date, price_indexed, color = ticker)) +
  geom_line() +
  scale_color_OkabeIto() #<<


## ----tech3-echo, eval = FALSE---------------------------------------
## ggplot(tech_stocks, aes(date, price_indexed, color = ticker)) +
##   geom_line() +
##   scale_color_OkabeIto(name = "Company", #<<
##                        breaks = c("GOOG", "AAPL", "FB", "MSFT"), #<<
##                        labels = c("Alphabet", "Apple", "Facebook", "Microsoft")) #<<


## ----tech3-eval, echo = FALSE, fig.height = 8-----------------------
ggplot(tech_stocks, aes(date, price_indexed, color = ticker)) +
  geom_line() +
  scale_color_OkabeIto(name = "Company", #<<
                       breaks = c("GOOG", "AAPL", "FB", "MSFT"), #<<
                       labels = c("Alphabet", "Apple", "Facebook", "Microsoft")) #<<


## ----tech4-echo, eval = FALSE---------------------------------------
## ggplot(tech_stocks, aes(date, price_indexed, color = ticker)) +
##   geom_line() +
##   scale_color_OkabeIto(name = "Company", #<<
##                        breaks = c("FB", "GOOG", "MSFT", "AAPL"), #<<
##                        labels = c("Facebook", "Alphabet", "Microsoft", "Apple")) #<<


## ----tech4-eval, echo = FALSE, fig.height = 8-----------------------
ggplot(tech_stocks, aes(date, price_indexed, color = ticker)) +
  geom_line() +
  scale_color_OkabeIto(name = "Company", #<<
                       breaks = c("FB", "GOOG", "MSFT", "AAPL"), #<<
                       labels = c("Facebook", "Alphabet", "Microsoft", "Apple")) #<<


## ----tech5-echo, eval = FALSE---------------------------------------
## ggplot(tech_stocks, aes(date, price_indexed, color = ticker)) +
##   geom_line() +
##   scale_color_OkabeIto(name = "Company",
##                        breaks = c("FB", "GOOG", "MSFT", "AAPL"),
##                        labels = c("Facebook", "Alphabet", "Microsoft", "Apple")) +
##   scale_x_date(name = "year",
##                limits = c(ymd("2012-06-01"), ymd("2018-12-31")),
##                expand = c(0,0)) +
##   geom_text(data = filter(tech_stocks, date == "2017-06-02"),
##             aes(y = price_indexed, label = company),
##             nudge_x = 280) #<<


## ----tech5-eval, echo = FALSE, fig.height = 9-----------------------
ggplot(tech_stocks, aes(date, price_indexed, color = ticker)) +
  geom_line() +
  scale_color_OkabeIto(name = "Company", 
                       breaks = c("FB", "GOOG", "MSFT", "AAPL"),
                       labels = c("Facebook", "Alphabet", "Microsoft", "Apple")) +
  scale_x_date(name = "year",
               limits = c(ymd("2012-06-01"), ymd("2018-12-31")),
               expand = c(0,0)) +
  geom_text(data = filter(tech_stocks, date == "2017-06-02"),
            aes(y = price_indexed, label = company),
            nudge_x = 280,
            size = 10) #<<


## ----tech6-echo, eval = FALSE---------------------------------------
## ggplot(tech_stocks, aes(date, price_indexed, color = ticker)) +
##   geom_line() +
##   scale_color_OkabeIto(name = "Company",
##                        breaks = c("FB", "GOOG", "MSFT", "AAPL"),
##                        labels = c("Facebook", "Alphabet", "Microsoft", "Apple")) +
##   scale_x_date(name = "year",
##                limits = c(ymd("2012-06-01"), ymd("2018-12-31")),
##                expand = c(0,0)) +
##   geom_text(data = filter(tech_stocks, date == "2017-06-02"),
##             aes(y = price_indexed, label = company),
##             nudge_x = 280,
##             hjust = 0) #<<


## ----tech6-eval, echo = FALSE, fig.height = 9-----------------------
ggplot(tech_stocks, aes(date, price_indexed, color = ticker)) +
  geom_line() +
  scale_color_OkabeIto(name = "Company", 
                       breaks = c("FB", "GOOG", "MSFT", "AAPL"),
                       labels = c("Facebook", "Alphabet", "Microsoft", "Apple")) +
  scale_x_date(name = "year",
               limits = c(ymd("2012-06-01"), ymd("2018-12-31")),
               expand = c(0,0)) +
  geom_text(data = filter(tech_stocks, date == "2017-06-02"),
            aes(y = price_indexed, label = company),
            nudge_x = 280,
            size = 10,
            hjust = 0) #<<


## ----tech7-echo, eval = FALSE---------------------------------------
## ggplot(tech_stocks, aes(date, price_indexed, color = ticker)) +
##   geom_line() +
##   scale_color_OkabeIto(name = "Company",
##                        breaks = c("FB", "GOOG", "MSFT", "AAPL"),
##                        labels = c("Facebook", "Alphabet", "Microsoft", "Apple")) +
##   scale_x_date(name = "year",
##                limits = c(ymd("2012-06-01"), ymd("2018-10-31")),
##                expand = c(0,0)) +
##   geom_text(data = filter(tech_stocks, date == "2017-06-02"),
##             aes(y = price_indexed, label = company),
##             color = "gray40", #<<
##             nudge_x = 20, #<<
##             hjust = 0) +
##   guides(color = "none") #<<


## ----tech7-eval, echo = FALSE, fig.height = 9-----------------------
ggplot(tech_stocks, aes(date, price_indexed, color = ticker)) +
  geom_line() +
  scale_color_OkabeIto(name = "Company", 
                       breaks = c("FB", "GOOG", "MSFT", "AAPL"),
                       labels = c("Facebook", "Alphabet", "Microsoft", "Apple")) +
  scale_x_date(name = "year",
               limits = c(ymd("2012-06-01"), ymd("2018-10-31")),
               expand = c(0,0)) +
  geom_text(data = filter(tech_stocks, date == "2017-06-02"),
            aes(y = price_indexed, label = company),
            color = "gray40",
            nudge_x = 20,
            hjust = 0,
            size = 10) +
  guides(color = "none")


## ----tech8-echo, eval = FALSE---------------------------------------
## ggplot(tech_stocks, aes(date, price_indexed, color = ticker)) +
##   geom_line() +
##   scale_color_OkabeIto(name = "Company",
##                        breaks = c("FB", "GOOG", "MSFT", "AAPL"),
##                        labels = c("Facebook", "Alphabet", "Microsoft", "Apple")) +
##   scale_x_date(name = "", #<<
##                limits = c(ymd("2012-06-01"), ymd("2018-10-31")),
##                expand = c(0,0)) +
##   scale_y_continuous(name = "Stock Price, Indexed", #<<
##                      labels = scales::dollar) + #<<
##   geom_text(data = filter(tech_stocks, date == "2017-06-02"),
##             aes(y = price_indexed, label = company),
##             color = "gray40",
##             nudge_x = 20,
##             hjust = 0,
##             size = 10) +
##   guides(color = "none") +
##   labs(title = "Tech growth over time",
##        caption = "Data from Wilke (2019): Fundamentals of Data Visualization") #<<


## ----tech8-eval, echo = FALSE, fig.height = 9-----------------------
ggplot(tech_stocks, aes(date, price_indexed, color = ticker)) +
  geom_line() +
  scale_color_OkabeIto(name = "Company", 
                       breaks = c("FB", "GOOG", "MSFT", "AAPL"),
                       labels = c("Facebook", "Alphabet", "Microsoft", "Apple")) +
  scale_x_date(name = "", #<<
               limits = c(ymd("2012-06-01"), ymd("2018-10-31")),
               expand = c(0,0)) +
  scale_y_continuous(name = "Stock Price, Indexed", #<<
                     labels = scales::dollar) + #<<
  geom_text(data = filter(tech_stocks, date == "2017-06-02"),
            aes(y = price_indexed, label = company),
            color = "gray40",
            nudge_x = 20,
            hjust = 0,
            size = 10) +
  guides(color = "none") +
  labs(title = "Tech growth over time",
       caption = "Data from Wilke (2019): Fundamentals of Data Visualization") #<<


## ----avs------------------------------------------------------------
avs <- tech_stocks %>% 
  group_by(company) %>% 
  summarize(stock_av = mean(price_indexed)) %>% 
  ungroup() %>% 
  mutate(share = stock_av / sum(stock_av))
avs


## ----avs-plot1------------------------------------------------------
ggplot(avs, aes(fct_reorder(company, share), share)) +
  geom_col(fill = "#0072B2")


## ----avs-plot2------------------------------------------------------
ggplot(avs, aes(fct_reorder(company, share), share)) +
  geom_col(fill = "#0072B2",
           alpha = 0.9) +
  coord_flip()


## ----avs-plot2b, fig.height = 6-------------------------------------
ggplot(avs, aes(fct_reorder(company, share), share)) +
  geom_col(fill = "#0072B2",
           alpha = 0.9) +
  coord_flip() +
  theme(panel.grid.major.y = element_blank(), #<<
        panel.grid.minor.x = element_blank(), #<<
        panel.grid.major.x = element_line(color = "gray80")) #<<


## -------------------------------------------------------------------
bp_theme <- function(...) {
  theme_minimal(...) +
    theme(panel.grid.major.y = element_blank(), 
          panel.grid.minor.x = element_blank(), 
          panel.grid.major.x = element_line(color = "gray80"),
          plot.title.position = "plot")
}



## ----avs-plot3, fig.height = 6--------------------------------------
ggplot(avs, aes(fct_reorder(company, share), share)) +
  geom_col(fill = "#0072B2",
           alpha = 0.9) +
  geom_text(aes(company, share, label = round(share, 2)), #<<
            nudge_y = 0.02, #<<
            size = 8) + #<<
  coord_flip() +
  bp_theme(base_size = 25)


## ----avs-plot4-echo, eval = FALSE-----------------------------------
## ggplot(avs, aes(fct_reorder(company, share), share)) +
##   geom_col(fill = "#0072B2",
##            alpha = 0.9) +
##   geom_text(aes(company, share, label = paste0(round(share*100), "%")), #<<
##             nudge_y = 0.02,
##             size = 8) +
##   coord_flip() +
##   scale_y_continuous("Market Share", labels = scales::percent) + #<<
##   labs(x = NULL,
##        title = "Tech company market control",
##        caption = "Data from Clause Wilke Book: Fundamentals of Data Visualizations") +
##   bp_theme(base_size = 25)


## ----avs-plot4-eval, echo = FALSE, fig.height = 9-------------------
ggplot(avs, aes(fct_reorder(company, share), share)) +
  geom_col(fill = "#0072B2",
           alpha = 0.9) +
  geom_text(aes(company, share, label = paste0(round(share*100), "%")), #<<
            nudge_y = 0.02,
            size = 8) + 
  coord_flip() +
  scale_y_continuous("Market Share", labels = scales::percent) + #<<
  labs(x = NULL,
       title = "Tech company market control",
       caption = "Data from Clause Wilke Book: Fundamentals of Data Visualizations") +
  bp_theme(base_size = 25)


## ----avs-plot5-echo, eval = FALSE, fig.height = 9-------------------
## ggplot(avs, aes(fct_reorder(company, share), share)) +
##   geom_col(fill = "#0072B2",
##            alpha = 0.9) +
##   geom_text(aes(company, share, label = paste0(round(share*100), "%")), #<<
##             nudge_y = 0.02,
##             size = 8) +
##   coord_flip() +
##   scale_y_continuous("Market Share",
##                      labels = scales::percent,
##                      expand = c(0, 0, 0.05, 0)) +
##   labs(x = NULL,
##        title = "Tech company market control",
##        caption = "Data from Clause Wilke Book: Fundamentals of Data Visualizations") +
##   bp_theme(base_size = 25)


## ----avs-plot5-eval, echo = FALSE, fig.height = 9-------------------
ggplot(avs, aes(fct_reorder(company, share), share)) +
  geom_col(fill = "#0072B2",
           alpha = 0.9) +
  geom_text(aes(company, share, label = paste0(round(share*100), "%")), 
            nudge_y = 0.02,
            size = 8) + 
  coord_flip() +
  scale_y_continuous("Market Share", 
                     labels = scales::percent,
                     expand = c(0, 0, 0.05, 0)) + #<<
  labs(x = NULL,
       title = "Tech company market control",
       caption = "Data from Clause Wilke Book: Fundamentals of Data Visualizations") +
  bp_theme(base_size = 25)


## ----avs-plot6-echo, eval = FALSE, fig.height = 9-------------------
## ggplot(avs, aes(fct_reorder(company, share), share)) +
##   geom_col(fill = "#0072B2",
##            alpha = 0.9) +
##   geom_text(aes(company, share, label = paste0(round(share*100), "%")),
##             nudge_y = -0.02, #<<
##             size = 8,
##             color = "white") + #<<
##   coord_flip() +
##   scale_y_continuous("Market Share",
##                      labels = scales::percent,
##                      expand = c(0, 0, 0.05, 0)) +
##   labs(x = NULL,
##        title = "Tech company market control",
##        caption = "Data from Clause Wilke Book: Fundamentals of Data Visualizations") +
##   bp_theme(base_size = 25)


## ----avs-plot6-eval, echo = FALSE, fig.height = 9-------------------
ggplot(avs, aes(fct_reorder(company, share), share)) +
  geom_col(fill = "#0072B2",
           alpha = 0.9) +
  geom_text(aes(company, share, label = paste0(round(share*100), "%")), 
            nudge_y = -0.02, #<<
            size = 8,
            color = "white") + #<<
  coord_flip() +
  scale_y_continuous("Market Share", 
                     labels = scales::percent,
                     expand = c(0, 0, 0.05, 0)) + 
  labs(x = NULL,
       title = "Tech company market control",
       caption = "Data from Clause Wilke Book: Fundamentals of Data Visualizations") +
  bp_theme(base_size = 25)


## ----densities1, fig.height = 6-------------------------------------
ggplot(iris, aes(Sepal.Length, fill = Species)) +
  geom_density(alpha = 0.3) 


## ----densities2-----------------------------------------------------
ggplot(iris, aes(Sepal.Length, fill = Species)) +
  geom_density(alpha = 0.3) +
  scale_fill_OkabeIto()


## ----densities3-echo, eval = FALSE----------------------------------
## label_locs <- tibble(Sepal.Length = c(5.45, 6, 7),
##                      density = c(1, 0.8, 0.6),
##                      Species = c("setosa", "versicolor", "virginica"))
## 
## ggplot(iris, aes(Sepal.Length, fill = Species)) +
##   geom_density(alpha = 0.3) +
##   scale_fill_OkabeIto() +
##   geom_text(aes(label = Species, y = density, color = Species),
##             data = label_locs)


## ----densities3-eval, echo = FALSE----------------------------------
label_locs <- tibble(Sepal.Length = c(5.45, 6, 7),
                     density = c(1, 0.8, 0.6),
                     Species = c("setosa", "versicolor", "virginica"))

ggplot(iris, aes(Sepal.Length, fill = Species)) +
  geom_density(alpha = 0.3) +
  scale_fill_OkabeIto() +
  geom_text(aes(label = Species, y = density, color = Species),
            data = label_locs,
            size = 10)


## ----densities4-echo, eval = FALSE----------------------------------
## ggplot(iris, aes(Sepal.Length, fill = Species)) +
##   geom_density(alpha = 0.3) +
##   scale_fill_OkabeIto() +
##   scale_color_OkabeIto() + #<<
##   geom_text(aes(label = Species, y = density, color = Species),
##             data = label_locs) +
##   guides(color = "none",
##          fill = "none")


## ----densities4-eval, echo = FALSE, fig.height = 9------------------
label_locs <- tibble(Sepal.Length = c(5.45, 6, 7),
                     density = c(1, 0.8, 0.6),
                     Species = c("setosa", "versicolor", "virginica"))

ggplot(iris, aes(Sepal.Length, fill = Species)) +
  geom_density(alpha = 0.3) +
  scale_fill_OkabeIto() +
  scale_color_OkabeIto() +
  geom_text(aes(label = Species, y = density, color = Species),
            data = label_locs,
            size = 10)


## ----densities5-echo, eval = FALSE----------------------------------
## label_locs <- tibble(Sepal.Length = c(5.4, 6, 6.9),
##                      density = c(1, 0.75, 0.6),
##                      Species = c("setosa", "versicolor", "virginica"))
## 
## ggplot(iris, aes(Sepal.Length, fill = Species)) +
##   geom_density(alpha = 0.3) +
##   scale_fill_OkabeIto() +
##   scale_color_OkabeIto() +
##   geom_text(aes(label = Species, y = density),
##             color = "gray40", #<<
##             data = label_locs) +
##   guides(fill = "none") #<<


## ----densities5-eval, echo = FALSE, fig.height = 9------------------
label_locs <- tibble(Sepal.Length = c(5.4, 6, 6.9),
                     density = c(1, 0.8, 0.6),
                     Species = c("setosa", "versicolor", "virginica"))

ggplot(iris, aes(Sepal.Length, fill = Species)) +
  geom_density(alpha = 0.3) +
  scale_fill_OkabeIto() +
  scale_color_OkabeIto() +
  geom_text(aes(label = Species, y = density),
            color = "gray40",
            data = label_locs,
            size = 10) +
  guides(fill = "none")


## ----annotate-echo, eval = FALSE------------------------------------
## ggplot(iris, aes(Sepal.Length, fill = Species)) +
##   geom_density(alpha = 0.3) +
##   scale_fill_OkabeIto() +
##   scale_color_OkabeIto() +
##   annotate("text", label = "setosa", x = 5.45, y = 1, color = "gray40") + #<<
##   annotate("text", label = "versicolor", x = 6, y = 0.8, color = "gray40") + #<<
##   annotate("text", label = "virginica", x = 7, y = 0.6, color = "gray40") + #<<
##   guides(fill = "none")


## ----annotate-eval, echo = FALSE, fig.height = 9--------------------
ggplot(iris, aes(Sepal.Length, fill = Species)) +
  geom_density(alpha = 0.3) +
  scale_fill_OkabeIto() +
  scale_color_OkabeIto() +
  annotate("text", label = "setosa", x = 5.4, y = 1, color = "gray40", size = 10) +
  annotate("text", label = "versicolor", x = 6, y = 0.8, color = "gray40", size = 10) +
  annotate("text", label = "virginica", x = 6.9, y = 0.6, color = "gray40", size = 10) +
  guides(fill = "none")


## ----mtcars-text, fig.height = 6------------------------------------
cars <- rownames_to_column(mtcars)

ggplot(cars, aes(hp, mpg)) +
  geom_text(aes(label = rowname))


## ----repel1, fig.height = 6.5---------------------------------------
library(ggrepel) #<<
ggplot(cars, aes(hp, mpg)) +
  geom_text_repel(aes(label = rowname)) #<<


## ----repel2,fig.height = 6.5----------------------------------------
ggplot(cars, aes(hp, mpg)) +
  geom_point(color = "gray70") + #<<
  geom_text_repel(aes(label = rowname),
                  min.segment.length = 0) #<<


## ----install-socviz, eval = FALSE-----------------------------------
## remotes::install_github("kjhealy/socviz")
## library(socviz)


## ----relig-data-----------------------------------------------------
by_country <- organdata %>% 
  group_by(consent_law, country) %>%
  summarize(donors_mean= mean(donors, na.rm = TRUE),
            donors_sd = sd(donors, na.rm = TRUE),
            gdp_mean = mean(gdp, na.rm = TRUE),
            health_mean = mean(health, na.rm = TRUE),
            roads_mean = mean(roads, na.rm = TRUE),
            cerebvas_mean = mean(cerebvas, na.rm = TRUE))


## ----by_country-----------------------------------------------------
by_country


## ----scatter-country------------------------------------------------
ggplot(by_country, aes(gdp_mean, health_mean)) +
  geom_point()


## ----outliers1-echo, eval = FALSE-----------------------------------
## ggplot(by_country, aes(gdp_mean, health_mean)) +
##   geom_point() +
##   geom_text_repel(data = filter(by_country, #<<
##                                 gdp_mean > 25000 | #<<
##                                 gdp_mean < 20000),#<<
##                   aes(label = country)) #<<


## ----outliers1-eval, echo = FALSE, fig.height = 9-------------------
ggplot(by_country, aes(gdp_mean, health_mean)) +
  geom_point() +
  geom_text_repel(data = filter(by_country, #<<
                                gdp_mean > 25000 | #<<
                                gdp_mean < 20000),#<<
                  aes(label = country)) #<<


## ----outliers2-echo, eval = FALSE-----------------------------------
## library(gghighlight) #<<
## ggplot(by_country, aes(gdp_mean, health_mean)) +
##   geom_point() +
##   gghighlight(gdp_mean > 25000 | gdp_mean < 20000) + #<<
##   geom_text_repel(aes(label = country)) #<<


## ----outliers2-eval, echo = FALSE, fig.height = 9-------------------
library(gghighlight) #<<
ggplot(by_country, aes(gdp_mean, health_mean)) +
  geom_point() +
  gghighlight(gdp_mean > 25000 | gdp_mean < 20000) + #<<
  geom_text_repel(aes(label = country)) #<<


## ----outliers3-echo, eval = FALSE-----------------------------------
## ggplot(by_country, aes(gdp_mean, health_mean)) +
##   geom_point() +
##   gghighlight(gdp_mean > 20000 & gdp_mean < 25000 ) +
##   geom_text_repel(data = filter(by_country,
##                                 gdp_mean > 25000 |
##                                 gdp_mean < 20000),
##                   aes(label = country),
##                   color = "#BEBEBEB3")


## ----outliers3-eval, echo = FALSE, fig.height = 9-------------------
ggplot(by_country, aes(gdp_mean, health_mean)) +
  geom_point() +
  gghighlight(gdp_mean > 20000 & gdp_mean < 25000 ) +
  geom_text_repel(data = filter(by_country, 
                                gdp_mean > 25000 |
                                gdp_mean < 20000),
                  aes(label = country),
                  color = "#BEBEBEB3") 


## ----label-by-group, fig.height = 5---------------------------------
ggplot(by_country, aes(gdp_mean, health_mean)) +
  geom_point() +
  geom_text_repel(data = filter(by_country, consent_law == "Presumed"),
                  aes(label = country))


## ----label-by-group-echo, eval = FALSE------------------------------
## ggplot(by_country, aes(gdp_mean, health_mean)) +
##   geom_point(color = "#DC5265") + #<<
##   gghighlight(consent_law == "Presumed") + #<<
##   geom_text_repel(aes(label = country),
##                   min.segment.length = 0,
##                   box.padding = 0.75) + #<<
##   labs(title = "GDP and Health",
##          subtitle = "Countries with a presumed organ donation consent are highlighted",
##          caption = "Data from the General Social Science Survey, Distributed through the socviz R package",
##          x = "Mean GDP",
##          y = "Mean Health")


## ----label-by-group-eval, echo = FALSE, fig.height = 9--------------
ggplot(by_country, aes(gdp_mean, health_mean)) +
  geom_point(color = "#DC5265") +
  gghighlight(consent_law == "Presumed") +
  geom_text_repel(aes(label = country),
                  min.segment.length = 0,
                  box.padding = 0.75) +
  labs(title = "GDP and Health",
         subtitle = "Countries with a presumed organ donation consent are highlighted",
         caption = "Data from the General Social Science Survey, Distributed through the socviz R package",
         x = "Mean GDP",
         y = "Mean Health")


## ----diff-themes, echo = FALSE, fig.height = 9----------------------
library(ggthemes)
unemploy_base <- ggplot(economics, aes(x = date, y = unemploy)) +
  scale_y_continuous(name = "unemployed (x1000)",
                     limits = c(0, 17000),
                     breaks = c(0, 5000, 10000, 15000),
                     labels = c("0", "5000", "10,000", "15,000"),
                     expand = c(0.04, 0)) +
  scale_x_date(name = "year",
               expand = c(0.01, 0))

unemploy_p1 <- unemploy_base + theme_dviz_grid(12, font_family = "Roboto Light") +
  geom_line(color = "#0072B2") +
  theme(axis.ticks.length = grid::unit(0, "pt"),
        axis.ticks = element_blank(),
        plot.margin = margin(6, 6, 6, 2))
unemploy_p2 <- unemploy_base + geom_line() + theme_gray()
unemploy_p3 <- unemploy_base + geom_line(aes(color = "unemploy"), show.legend = FALSE, size = .75) +
  theme_economist() + scale_color_economist() +
  theme(panel.grid.major = element_line(size = .75))
unemploy_p4 <- unemploy_base + geom_line(aes(color = "unemploy"), show.legend = FALSE) +
  scale_color_fivethirtyeight() +
  labs(title = "United States unemployment",
       subtitle = "Unemployed persons (in thousands) from 1967\nto 2015") +
  theme_fivethirtyeight() +
  theme(plot.title = element_text(size = 14),
        plot.title.position = "plot")

plot_grid(unemploy_p1, NULL, unemploy_p2, 
          NULL, NULL, NULL,
          unemploy_p3, NULL, unemploy_p4,
          labels = c("a", "", "b", "", "", "", "c", "", "d"),
          hjust = -.5,
          vjust = 1.5,
          rel_widths = c(1, .02, 1),
          rel_heights = c(1, .02, 1))


## ----lab3-data------------------------------------------------------
library(fivethirtyeight)
g <- google_trends %>% 
  pivot_longer(starts_with("hurricane"), 
               names_to = "hurricane", 
               values_to = "interest",
               names_pattern = "_(.+)_")

landfall <- tibble(date = lubridate::mdy(c("August 25, 2017", 
                                           "September 10, 2017", 
                                           "September 20, 2017")),
                   hurricane = c("Harvey Landfall", 
                                 "Irma Landfall", 
                                 "Maria Landfall"))


## ----baseplot-echo, fig.show = "hide"-------------------------------
p <- ggplot(g, aes(date, interest)) +
  geom_ribbon(aes(fill = hurricane, ymin = 0, ymax = interest),
              alpha = 0.6) + 
  geom_vline(aes(xintercept = date), landfall,
             color = "gray80", 
             lty = "dashed") +
  geom_text(aes(x = date, y = 80, label = hurricane), landfall,
            color = "gray80",
            nudge_x = 0.5, 
            hjust = 0) +
  labs(x = "", 
       y = "Google Trends",
       title = "Hurricane Google trends over time",
       caption = "Source: https://github.com/fivethirtyeight/data/tree/master/puerto-rico-media") + 
  scale_fill_brewer("Hurricane", palette = "Set2")


## ----baseplot-eval, echo = FALSE, fig.height = 9--------------------
p


## ----theme_mods-echo, eval = FALSE----------------------------------
## p + theme(panel.grid.major = element_line(colour = "gray30"),
##           panel.grid.minor = element_line(colour = "gray30"),
##           axis.text = element_text(colour = "gray80"),
##           axis.text.x = element_text(colour = "gray80"),
##           axis.text.y = element_text(colour = "gray80"),
##           axis.title = element_text(colour = "gray80"),
##           legend.text = element_text(colour = "gray80"),
##           legend.title = element_text(colour = "gray80"),
##           panel.background = element_rect(fill = "gray10"),
##           plot.background = element_rect(fill = "gray10"),
##           legend.background = element_rect(fill = NA, color = NA),
##           legend.position = c(0.20, -0.1),
##           legend.direction = "horizontal",
##           plot.margin = margin(10, 10, b = 20, 10),
##           plot.caption = element_text(colour = "gray80", vjust = 1),
##           plot.title = element_text(colour = "gray80"))


## ----theme_mods-eval, echo = FALSE, fig.height = 9------------------
p + theme(panel.grid.major = element_line(colour = "gray30"), 
          panel.grid.minor = element_line(colour = "gray30"), 
          axis.text = element_text(colour = "gray80"), 
          axis.text.x = element_text(colour = "gray80"), 
          axis.text.y = element_text(colour = "gray80"),
          axis.title = element_text(colour = "gray80"),
          legend.text = element_text(colour = "gray80"), 
          legend.title = element_text(colour = "gray80"), 
          panel.background = element_rect(fill = "gray10"), 
          plot.background = element_rect(fill = "gray10"), 
          legend.background = element_rect(fill = NA, color = NA), 
          legend.position = c(0.2, -0.1), 
          legend.direction = "horizontal",
          plot.margin = margin(10, 10, b = 20, 10),
          plot.caption = element_text(colour = "gray80", vjust = 1), 
          plot.title = element_text(colour = "gray80"))

