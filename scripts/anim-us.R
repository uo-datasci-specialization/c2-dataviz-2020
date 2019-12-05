library(gganimate)
library(here)
library(rio)
library(tidyverse)

tuition <- import(here("data", "us_avg_tuition.xlsx"),
                  setclass = "tbl_df")

state_data <- map_data("state") %>% 
  rename(State = region)

tuition <- tuition %>% 
  mutate(State = tolower(State))

states <- left_join(state_data, tuition)

states <- states %>% 
  gather(year, tuition, `2004-05`:`2015-16`)

usa <- map_data("usa")

p <- ggplot(states) +
  geom_polygon(aes(long, lat, group = group), 
               usa,
               color = "gray") +
  geom_polygon(aes(long, lat, group = group, fill = tuition)) +
  scale_fill_viridis_c("Average tution", option = "magma") +
  transition_states(year,
                    transition_length = 2,
                    state_length = 0.5) +
  labs(title = "Average Tuition Cost",
       subtitle = "{closest_state}") +
  coord_fixed(1.3) +
  theme(strip.background = element_rect(fill="gray0"),
        strip.text = element_text(colour = 'gray'),
        panel.grid.major = element_line(size = 0), 
        panel.grid.minor = element_line(size = 0), 
        axis.text.x = element_text(colour = "gray0"), 
        axis.text.y = element_text(colour = "gray0"), 
        legend.text = element_text(size = 7, colour = "white"),
        legend.title = element_text(size = 10, colour = "white"),
        panel.background = element_rect(fill = "gray0"), 
        plot.background = element_rect(fill = "gray0", 
                                       colour = "gray0"), 
        legend.background = element_rect(fill = "gray0"), 
        legend.position = c(0.06, -0.05), 
        legend.direction = "horizontal",
        plot.margin = margin(0.5, 0, 0, 0, "cm"),
        plot.title = element_text(colour = "white"),
        plot.subtitle = element_text(colour = "white"))
anim_save(here("slides", "img", "states-heatmap-anim.gif"))

