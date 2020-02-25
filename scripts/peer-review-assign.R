peeps <- c("Mike", "Stephanie", "Akhila", "Thuy", "Sophie", "Brock", "Jim", 
           "Joanna", "Asha", "Claire")

shuffle <- function(v) {
  x <- sample(v)
  y <- sample(v)
  z <- sample(v)
  list(you = v, assign1 = x, assign2 = y, assign3 = z)
}

repeat {
  s <- shuffle(seq_along(peeps))
  if(all(s$you != s$assign1 & 
         s$you != s$assign2 &
         s$you != s$assign3 &
         s$assign1 != s$assign2 &
         s$assign1 != s$assign3 &
         s$assign2 != s$assign3)) {
    break
  }
}

final_assign <- data.frame(You = peeps[s$you],
                           Assign1 = peeps[s$assign1],
                           Assign2 = peeps[s$assign2],
                           Assign3 = peeps[s$assign3])

readr::write_csv(final_assign, 
          here::here("final-peer-review.csv"))
