## ----echo = FALSE-------------------------------------------------------------------------------
knitr::include_url("https://uo-datasci-specialization.github.io/c2-dataviz-2020/")


## ----echo = FALSE-------------------------------------------------------------------------------
knitr::include_url("http://happygitwithr.com")



## ----pres-wildorder, echo = FALSE, results = "asis"---------------------------------------------
peeps <- c("Mike", "Stephanie", "Katherine", "Akhila", "Thuy", "Sophie",
           "Brock", "Bryce", "Jim", "Joanna", "Asha", "Claire")

dates <- lubridate::mdy(c("1/22/20", "1/27/20", "1/29/20",
                          "2/3/20", "2/5/20", "2/10/20", "2/12/20", "2/17/20", 
                          "2/19/20", "2/24/20", "2/26/20", "3/2/20"))

#length(peeps)/ length(dates)

set.seed(23)
knitr::kable(
  data.frame(Date = dates, 
             Presenter = sample(peeps)),
  "html"
)

