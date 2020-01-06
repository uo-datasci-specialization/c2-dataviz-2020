rmd_files <- list.files(here::here("slides"), 
	                    pattern = "\\.[Rr]md",
	                    full.names = TRUE)

purrr::walk(rmd_files, knitr::purl)

r_files <- list.files(here::here("scripts"), 
	                    pattern = "w\\dp\\d\\.R",
	                    full.names = TRUE)

r_file_names <- gsub(".+scripts/(.+)", "\\1", r_files)
new_locs <- here::here("slide-scripts", r_file_names)

file.rename(from = r_files, to = new_locs)