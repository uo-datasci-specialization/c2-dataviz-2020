peeps <- c("Adams-Clark, Alexis A", "Bedford-Petersen, Cianna", "Chen, Teresa",         "Cullen, Brendan H", "Denning, Kathryn R", "Edelblum, Andrew", 
           "Frank, Lea", "Fridman, Andrew J", "Garcia Isaza, Alejandra", 
           "Grove, Kivalina", "Hagan, Katherine F", "Hammond, Mark A", 
           "Hmaddi, Ouafaa", "Jin, Jeongim", "Kay, Cameron", 
           "Kosie, Jessica E", "Lewis, Jennifer K", "Lin, Ting-fen", 
           "Lind, Monika N", "Miller, Ashley L", "Niella, Tamara", 
           "Ochoa, Karlena", "Pedroza, JP A", "Rochelle, Jon L", 
           "Schweer-Collins, Maria L", "Trevino, Shaina D", "Yang, Xi", 
           "Zhao, Yufei")

dates <- lubridate::mdy(c("1/21/19", "1/23/19", "1/28/19", "1/30/19",
                          "2/4/19", "2/6/19", "2/11/19", "2/13/19", "2/18/19", 
                          "2/20/19", "2/25/19", "2/27/19", "3/4/19", "3/6/19"))

length(peeps)/ length(dates)

set.seed(8675309)
selected <- vector("list", length(dates))
for(i in seq_along(dates)) {
	sampled <- sample(peeps, 2)
	selected[[i]] <- sampled
	peeps <- peeps[!peeps %in% sampled]
}

data.frame(date = dates, 
           presenter1 = purrr::map_chr(selected, 1),
           presenter2 = purrr::map_chr(selected, 2))