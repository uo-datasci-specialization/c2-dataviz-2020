## ---- setup, include = FALSE--------------------------------------------------------------------
library(nycflights13)
library(tidyverse)
knitr::opts_chunk$set(fig.width = 13, 
                      message = FALSE, 
                      warning = FALSE,
                      echo = TRUE)

update_geom_defaults('path', list(size = 3))
update_geom_defaults('point', list(size = 5))


## ----g34-datsets--------------------------------------------------------------------------------
g3 <- tibble(sid = 1:3, 
             grade = rep(3, 3), 
             score = as.integer(rnorm(3, 200,10)))

g4 <- tibble(sid = 9:11, 
             grade = rep(4, 3), 
             score = as.integer(rnorm(3, 200,10)))


## ----g3-print-----------------------------------------------------------------------------------
g3


## ----g4-print-----------------------------------------------------------------------------------
g4


## ----bind_rows1---------------------------------------------------------------------------------
bind_rows(g3, g4)


## ----bind_rows2---------------------------------------------------------------------------------
bind_rows(g3[ ,-2], g4[ ,-2], .id = "dataset")


## ----bind_rows_id_mutate------------------------------------------------------------------------
bind_rows(g3[ ,-2], g4[ ,-2], .id = "dataset") %>%
  mutate(grade = ifelse(dataset == 1, 3, 4))


## ----bind_rows3---------------------------------------------------------------------------------
bind_rows(g3 = g3[ ,-2], g4 = g4[ ,-2], .id = "grade")


## ----bind_rows4---------------------------------------------------------------------------------
bind_rows(g3, g4[ ,-2], .id = "dataset")


## ----write_files--------------------------------------------------------------------------------
dir.create("tmp")

mtcars %>%
  split(.$cyl) %>%
  walk2(c("tmp/cyl4.csv", "tmp/cyl6.csv", "tmp/cyl8.csv"),
        write_csv)

list.files("tmp")


## ----read_files---------------------------------------------------------------------------------
new_mtcars <- map_df(fs::dir_ls("tmp"), rio::import, setclass = "tbl_df",
                     .id = "file")
new_mtcars %>%
  select(file, mpg, cyl) %>%
  slice(1:3)
unlink("tmp", recursive = TRUE)


## ----load_ecls-k--------------------------------------------------------------------------------
library(rio)
library(here)
ecls <- import(here("data", "ecls-k_samp.sav"), setclass = "tbl_df") %>% 
    characterize()
ecls


## ----double_check_ecls--------------------------------------------------------------------------
ecls %>% 
    count(child_id) 


## -----------------------------------------------------------------------------------------------
ecls %>% 
    count(child_id) %>%
    filter(n > 1)


## ----primary_key_income_ineq--------------------------------------------------------------------
income_ineq <- import(here("data", "incomeInequality_tidy.csv"), 
                      setclass = "tbl_df")
income_ineq 


## ----double_check_income_ineq-------------------------------------------------------------------
income_ineq %>% 
    count(Year, percentile) %>% 
    filter(n > 1)


## ----eval = FALSE-------------------------------------------------------------------------------
## install.packages("nycflights13")
## library(nycflights13)


## ----flights------------------------------------------------------------------------------------
flights


## ----no_key-------------------------------------------------------------------------------------
flights %>% 
  count(year, month, day, flight, tailnum) %>% 
  filter(n > 1)


## ----add_key------------------------------------------------------------------------------------
flights <- flights %>% 
  rowid_to_column()

flights %>% 
  select(1:3, ncol(flights))


## ----eth-code-tbl-------------------------------------------------------------------------------
set.seed(1)
disab_codes <- c("00", "10", "20", "40", "43", "50", "60", 
                 "70", "74", "80", "82", "90", "96", "98")
dis_tbl <- tibble(sid = 1:200, 
                   dis_code = sample(disab_codes, 200, replace = TRUE), 
                   score = as.integer(rnorm(200, 200, 10)))
head(dis_tbl)


## ----dis-recode-case_when, eval = FALSE---------------------------------------------------------
## dis_tbl %>%
##   mutate(disability =
##            case_when(dis_code == "10" ~ "Mental Retardation",
##                      dis_code == "20" ~ 'Hearing Impairment',
##                      ...,
##                      TRUE ~ "Not Applicable")


## ----cod-tbl------------------------------------------------------------------------------------
dis_code_tbl <- tibble(dis_code = c("00", "10", "20", "40", "43", "50", "60", 
                                    "70", "74", "80", "82", "90", "96", "98"),
                       disability = c('Not Applicable', 'Mental Retardation', 
                                      'Hearing Impairment', 'Visual Impairment',
                                      'Deaf-Blindness', 'Communication Disorder',
                                      'Emotional Disturbance', 'Orthopedic Impairment',
                                      'Traumatic Brain Injury', 
                                      'Other Health Impairments', 
                                      'Autism Spectrum Disorder', 
                                      'Specific Learning Disability', 
                                      'Developmental Delay 0-2yr', 
                                      'Developmental Delay 3-4yr'))


## ----print-dis_code_tbl-------------------------------------------------------------------------
dis_code_tbl


## ----join-disab, message = TRUE-----------------------------------------------------------------
left_join(dis_tbl, dis_code_tbl)


## ----join_data----------------------------------------------------------------------------------
gender <- tibble(key = 1:3, male = rbinom(3, 1, .5))
sped <- tibble(key = c(1, 2, 4), sped = rbinom(3, 1, .5))


## ----gender-------------------------------------------------------------------------------------
gender


## ----sped---------------------------------------------------------------------------------------
sped


## ----left_join----------------------------------------------------------------------------------
left_join(gender, sped)


## ----right_join---------------------------------------------------------------------------------
right_join(gender, sped)


## ----inner_join---------------------------------------------------------------------------------
inner_join(gender, sped)


## ----outer_join---------------------------------------------------------------------------------
full_join(gender, sped)


## ----stu_lev------------------------------------------------------------------------------------
stu <- tibble(
        sid = rep(1:3, each = 3),
        season = rep(c("f", "w", "s"), 3),
        score = c(10, 12, 15, 
                         8,  9, 11, 
                        12, 15, 17)
        )
stu


## ----stu_agg------------------------------------------------------------------------------------
means <- stu %>% 
    group_by(sid) %>% 
    summarize(mean_score = mean(score))
means


## ----one_to_many_merge--------------------------------------------------------------------------
left_join(stu, means)


## ----demos--------------------------------------------------------------------------------------
dems <- tibble(sid = rep(1:3, each = 3),
               sped = c(rep("no", 6), rep("yes", 3)))
dems


## ----dup_merge----------------------------------------------------------------------------------
left_join(stu, dems)


## ----fix_dup_merge1-----------------------------------------------------------------------------
dems <- dems %>% 
    distinct(sid, .keep_all = TRUE)
dems


## ----fix_dup_merge2-----------------------------------------------------------------------------
left_join(stu, dems)


## ----pipe_merge---------------------------------------------------------------------------------
ecls <- ecls %>% 
    group_by(school_id) %>% 
    summarize(sch_pre_math = mean(T1MSCALE)) %>% 
    left_join(ecls)


## ----print_ecls---------------------------------------------------------------------------------
ecls


## ----flights2-----------------------------------------------------------------------------------
flights2 <- flights %>% 
  select(year:day, hour, origin, dest, tailnum, carrier)
flights2[1:2, ]


## ----weather------------------------------------------------------------------------------------
weather[1:2, ]


## ----join_flights_weather-----------------------------------------------------------------------
left_join(flights2, weather)


## ----planes-------------------------------------------------------------------------------------
head(planes)


## ----join_flights2_planes-----------------------------------------------------------------------
left_join(flights2, planes, by = "tailnum")


## ----stu_table----------------------------------------------------------------------------------
stu


## ----dems_table---------------------------------------------------------------------------------
names(dems)[1] <- "stu_id"
dems


## ----join_name_mismatch-------------------------------------------------------------------------
left_join(stu, dems, by = c("sid" = "stu_id"))


## ----semi_join_extreme_high---------------------------------------------------------------------
av_pre_mth <- ecls %>% 
    group_by(teacher_id, k_type) %>% 
    summarize(av_pre_mth = mean(T1MSCALE)) 
av_pre_mth


## ----filter_high--------------------------------------------------------------------------------
extr_high <- av_pre_mth %>% 
    ungroup() %>% 
    filter(av_pre_mth > (mean(av_pre_mth) + 3*sd(av_pre_mth)))
extr_high


## ----extr_high_ecls1----------------------------------------------------------------------------
extr_high_ecls <- semi_join(ecls, extr_high)
extr_high_ecls


## ----anti_join_extreme_high---------------------------------------------------------------------
extr_low_ecls <- anti_join(ecls, extr_high)
extr_low_ecls


## ----jane_austen--------------------------------------------------------------------------------
# install.packages(c("tidytext", "janeaustenr"))
library(tidytext)
library(janeaustenr)

austen_books()


## ----get-words----------------------------------------------------------------------------------
austen_books() %>%
  unnest_tokens(word, text)


## ----count-words--------------------------------------------------------------------------------
austen_books() %>%
  unnest_tokens(word, text) %>% 
  count(word, sort = TRUE)


## ----stop-words---------------------------------------------------------------------------------
stop_words


## ----remove-stop-words--------------------------------------------------------------------------
austen_books() %>%
  unnest_tokens(word, text) %>% 
  anti_join(stop_words) %>% 
  count(word, sort = TRUE)

