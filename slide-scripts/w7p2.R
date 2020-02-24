## ----setup, include = FALSE-----------------------
knitr::opts_chunk$set(dev = "CairoPNG",
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


## ----install-gt, eval = FALSE---------------------
## remotes::install_github("rstudio/gt")


## ----flying---------------------------------------
library(fivethirtyeight)
flying


## ----flying2--------------------------------------
smry <- flying %>% 
  count(gender, age, recline_frequency) %>% 
  drop_na(age,recline_frequency) %>% 
  pivot_wider(names_from = "age", 
              values_from = "n") 

smry


## ----gt1-echo, eval = FALSE-----------------------
## library(gt)
## smry %>%
##   gt()


## ----gt1-eval, echo = FALSE-----------------------
library(gt)
smry %>% 
  gt()


## ----gt2-echo, eval = FALSE-----------------------
## smry %>%
##   group_by(gender) %>% #<<
##   gt()


## ----gt2-eval, echo = FALSE-----------------------
smry %>% 
  group_by(gender) %>% 
  gt()


## ----gt3-echo, eval = FALSE-----------------------
## smry %>%
##   group_by(gender) %>%
##   gt() %>%
##   tab_spanner(label = "Age Range", #<<
##               columns = vars(`18-29`, `30-44`, `45-60`, `> 60`)) #<<


## ----gt3-eval, echo = FALSE-----------------------
smry %>% 
  group_by(gender) %>% 
  gt() %>% 
  tab_spanner(label = "Age Range",
              columns = vars(`18-29`, `30-44`, `45-60`, `> 60`))


## ----gt4-echo, eval = FALSE-----------------------
## smry %>%
##   group_by(gender) %>%
##   gt() %>%
##   tab_spanner(label = "Age Range",
##               columns = vars(`18-29`, `30-44`, `45-60`, `> 60`)) %>%
##   cols_label(recline_frequency = "Recline") #<<


## ----gt4-eval, echo = FALSE-----------------------
smry %>% 
  group_by(gender) %>% 
  gt() %>% 
  tab_spanner(label = "Age Range",
              columns = vars(`18-29`, `30-44`, `45-60`, `> 60`)) %>% 
  cols_label(recline_frequency = "Recline")


## ----gt4-aligned-echo, eval = FALSE---------------
## smry %>%
##   group_by(gender) %>%
##   gt() %>%
##   tab_spanner(label = "Age Range",
##               columns = vars(`18-29`, `30-44`, `45-60`, `> 60`)) %>%
##   cols_label(recline_frequency = "Recline") %>%
##   cols_align(align = "left", columns = vars(recline_frequency)) #<<


## ----gt4-aligned-eval, echo = FALSE---------------
smry %>% 
  group_by(gender) %>% 
  gt() %>% 
  tab_spanner(label = "Age Range",
              columns = vars(`18-29`, `30-44`, `45-60`, `> 60`)) %>% 
  cols_label(recline_frequency = "Recline") %>% 
  cols_align(align = "left", columns = vars(recline_frequency))


## ----gt4-title-echo, eval = FALSE-----------------
## smry %>%
##   group_by(gender) %>%
##   gt() %>%
##   tab_spanner(label = "Age Range",
##               columns = vars(`18-29`, `30-44`, `45-60`, `> 60`)) %>%
##   cols_label(recline_frequency = "Recline") %>%
##   cols_align(align = "left", columns = vars(recline_frequency)) %>%
##   tab_header(title = "Airline Passengers", #<<
##              subtitle = "Leg space is limited, what do you do?") #<<


## ----gt4-title-eval, echo = FALSE-----------------
smry %>% 
  group_by(gender) %>% 
  gt() %>% 
  tab_spanner(label = "Age Range",
              columns = vars(`18-29`, `30-44`, `45-60`, `> 60`)) %>% 
  cols_label(recline_frequency = "Recline") %>% 
  cols_align(align = "left", columns = vars(recline_frequency)) %>% 
  tab_header(title = "Airline Passengers",
             subtitle = "Leg space is limited, what do you do?")


## ----gt5-echo, eval = FALSE-----------------------
## smry %>%
##   mutate_at(vars(`18-29`, `30-44`, `45-60`, `> 60`), ~./100) %>% #<<
##   group_by(gender) %>%
##   gt() %>%
##   tab_spanner(label = "Age Range",
##               columns = vars(`18-29`, `30-44`, `45-60`, `> 60`)) %>%
##   fmt_percent(vars(`18-29`, `30-44`, `45-60`, `> 60`), #<<
##               decimals = 0) %>% #<<
##   cols_label(recline_frequency = "Recline") %>%
##   cols_align(align = "left", columns = vars(recline_frequency)) %>%
##   tab_header(title = "Airline Passengers",
##              subtitle = "Leg space is limited, what do you do?")


## ----gt5-eval, echo = FALSE-----------------------
smry %>% 
  mutate_at(vars(`18-29`, `30-44`, `45-60`, `> 60`), ~./100) %>% 
  group_by(gender) %>% 
  gt() %>% 
  tab_spanner(label = "Age Range",
              columns = vars(`18-29`, `30-44`, `45-60`, `> 60`)) %>% 
  fmt_percent(vars(`18-29`, `30-44`, `45-60`, `> 60`),
              decimals = 0) %>% 
  cols_label(recline_frequency = "Recline") %>% 
  cols_align(align = "left", columns = vars(recline_frequency)) %>% 
  tab_header(title = "Airline Passengers",
             subtitle = "Leg space is limited, what do you do?")


## ----gt6-echo, eval = FALSE-----------------------
## smry %>%
##   mutate_at(vars(`18-29`, `30-44`, `45-60`, `> 60`), ~./100) %>%
##   group_by(gender) %>%
##   gt() %>%
##   tab_spanner(label = "Age Range",
##               columns = vars(`18-29`, `30-44`, `45-60`, `> 60`)) %>%
##   fmt_percent(vars(`18-29`, `30-44`, `45-60`, `> 60`),
##               decimals = 0) %>%
##   cols_label(recline_frequency = "Recline") %>%
##   cols_align(align = "left", columns = vars(recline_frequency)) %>%
##   tab_header(title = "Airline Passengers",
##              subtitle = "Leg space is limited, what do you do?") %>%
##   tab_source_note(source_note = md("Data from [fivethirtyeight](https://fivethirtyeight.com/features/airplane-etiquette-recline-seat/)")) #<<


## ----gt6-eval, echo = FALSE-----------------------
smry %>% 
  mutate_at(vars(`18-29`, `30-44`, `45-60`, `> 60`), ~./100) %>% 
  group_by(gender) %>% 
  gt() %>% 
  tab_spanner(label = "Age Range",
              columns = vars(`18-29`, `30-44`, `45-60`, `> 60`)) %>% 
  fmt_percent(vars(`18-29`, `30-44`, `45-60`, `> 60`),
              decimals = 0) %>% 
  cols_label(recline_frequency = "Recline") %>% 
  cols_align(align = "left", columns = vars(recline_frequency)) %>% 
  tab_header(title = "Airline Passengers",
             subtitle = "Leg space is limited, what do you do?") %>% 
  tab_source_note(source_note = md("Data from [fivethirtyeight](https://fivethirtyeight.com/features/airplane-etiquette-recline-seat/)"))


## ----gt7-echo, eval = FALSE-----------------------
## smry %>%
##   mutate_at(vars(`18-29`, `30-44`, `45-60`, `> 60`), ~./100) %>%
##   group_by(gender) %>%
##   gt() %>%
##   tab_spanner(label = "Age Range",
##               columns = vars(`18-29`, `30-44`, `45-60`, `> 60`)) %>%
##   fmt_percent(vars(`18-29`, `30-44`, `45-60`, `> 60`),
##               decimals = 0) %>%
##   cols_label(recline_frequency = "Recline") %>%
##   data_color(vars(`18-29`, `30-44`, `45-60`, `> 60`), #<<
##              colors = scales::col_numeric(palette = c(c("#FFFFFF", "#FF0000")), domain = NULL)) %>% #<<
##   cols_align(align = "left", columns = vars(recline_frequency)) %>%
##   tab_header(title = "Airline Passengers",
##              subtitle = "Leg space is limited, what do you do?") %>%
##   tab_source_note(source_note = md("Data from [fivethirtyeight](https://fivethirtyeight.com/features/airplane-etiquette-recline-seat/)"))


## ----gt7-eval, echo = FALSE-----------------------
smry %>% 
  mutate_at(vars(`18-29`, `30-44`, `45-60`, `> 60`), ~./100) %>% 
  group_by(gender) %>% 
  gt() %>% 
  tab_spanner(label = "Age Range",
              columns = vars(`18-29`, `30-44`, `45-60`, `> 60`)) %>% 
  fmt_percent(vars(`18-29`, `30-44`, `45-60`, `> 60`),
              decimals = 0) %>% 
  cols_label(recline_frequency = "Recline") %>% 
  data_color(vars(`18-29`, `30-44`, `45-60`, `> 60`),
             colors = scales::col_numeric(palette = c(c("#FFFFFF", "#FF0000")), domain = NULL)) %>% 
  cols_align(align = "left", columns = vars(recline_frequency)) %>% 
  tab_header(title = "Airline Passengers",
             subtitle = "Leg space is limited, what do you do?") %>% 
  tab_source_note(source_note = md("Data from [fivethirtyeight](https://fivethirtyeight.com/features/airplane-etiquette-recline-seat/)"))


## ----kableExtra1, results = "asis"----------------
library(knitr)
library(kableExtra)
dt <- mtcars[1:5, 1:6]
kable(dt) %>%
  kable_styling("striped") %>%
  column_spec(5:7, bold = TRUE)


## ----kableExtra2, results = "asis"----------------
kable(dt) %>%
  kable_styling("striped") %>%
  column_spec(5:7, bold = TRUE) %>% 
  row_spec(c(2, 4), 
           bold = TRUE, 
           color = "#EFF3F7", 
           background = "#71B0DE")


## ----kableExtra3, results = "asis"----------------
kable(dt) %>%
  kable_styling("striped", full_width = F) %>%
  pack_rows("Group 1", 1, 3, 
            label_row_css = "background-color: #666; color: #fff;") %>% 
  pack_rows("Group 2", 4, 5, 
             label_row_css = "background-color: #666; color: #fff;")


## ----showtext1-echo, eval = FALSE-----------------
## devtools::install_github("yixuan/showtext")
## 
## library(showtext)
## 
## font_add_google('Monsieur La Doulaise', "mld")
## font_add_google('Special Elite', "se")
## 
## showtext_auto()
## quartz()
## 
## ggplot(mtcars, aes(disp, mpg)) +
##   geom_point() +
##   labs(title = "An amazing title",
##        subtitle = "with the world's most boring dataset") +
##   theme(plot.subtitle = element_text(size = 18, family = "se"), #<<
##         plot.title = element_text(size = 22, family = "mld"), #<<
##         axis.title = element_text(size = 18, family = "mld"), #<<
##         axis.text.x = element_text(size = 12, family = "se"), #<<
##         axis.text.y = element_text(size = 12, family = "se")) #<<


## ----extrafont-list-------------------------------
library(extrafont)
# font_import() Only need to run once
fonts() # list fonts


## ----extrafont-plot-eval, echo = FALSE------------
p <- ggplot(mtcars, aes(wt, mpg)) + 
  geom_point() +
  labs(title = "Fuel Efficiency of 32 Cars",
       x = "Weight (x1000 lb)",
       y = "Miles per Gallon") +
  theme(text = element_text(family = "Luminari", size = 30)) #<<

ggsave(here::here("slides", "w7p2_files", "figure-html", "luminari-font.png"), 
       p,
       height = 5.5)


## ----extrafont-plot, eval = FALSE, fig.height = 5----
## ggplot(mtcars, aes(wt, mpg)) +
##   geom_point() +
##   labs(title = "Fuel Efficiency of 32 Cars",
##        x = "Weight (x1000 lb)",
##        y = "Miles per Gallon") +
##   theme(text = element_text(family = "Luminari", size = 30)) #<<


## @import url('https://fonts.googleapis.com/css?family=Akronim&display=swap');

## 
## body {

##   font-family: 'Akronim', cursive;

## }


## ---- out.width = "475px", echo = FALSE-----------
knitr::include_graphics("https://www.exopermaculture.com/wp-content/uploads/2013/01/alice-falling-down-rabbit-hole1.jpeg")

