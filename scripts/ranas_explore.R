
# ranas_explore

# loading data, quick looks

library(tidyverse)

ranas <- read_csv("data/ranas_10_26_22.csv")

new <- ranas %>%
  filter(Recap == "N")

# simple ind caught for each site - just look at number new ind caught
new %>%
  group_by(Sitio) %>%
  summarize(count = n_distinct(Numero)) %>%
  ggplot(aes(Sitio, count)) +
  geom_col()

# how has number of ind changed over time?
new %>%
  group_by(Fecha) %>%
  summarize(count = n_distinct(Numero)) %>%
  ggplot(aes(Fecha, count)) +
  geom_col()

new_test <- new %>%
  group_by(Fecha) %>%
  mutate(new_ind = as.numeric(max(Numero)))

# want a fig with overall number of ind increasing over time

### working ###
new_test %>%
  ggplot(aes(x = factor(Fecha, level = c(
    '01/09/22', '02/09/22', '03/09/22', '05/09/22', '06/09/22',
    '07/09/22', '08/09/22', '09/09/22', '10/09/22', '12/09/22',
    '13/09/22', '14/09/22', '15/09/22', '17/09/22', '19/09/22',
    '03/10/22', '05/10/22', '07/10/22', '08/10/22', '10/10/22', 
    '12/10/22')), 
    y = new_ind)) +
  geom_point() +
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  labs(x = 'Sampling Nights', y = 'Cumulative Unique Individuals')

### testing ###




# how many species?
new %>%
  summarize(count = n_distinct(`FVE ID`))
# 28

# how many new species by each sampling effort?
## I like this so far but it gives unique species per day, cumulative just adds
new %>%
  group_by(Fecha) %>%
  summarize(count = n_distinct(`FVE ID`)) %>%
  ungroup() %>%
  mutate(cumulative_sum = cumsum(count))

# this doesn't do it
new_test2 <- new_test %>%
  group_by(Fecha) %>%
  mutate(species = n_distinct(`FVE ID`)) %>%
 # ungroup() %>%
  mutate(cumulative_species = cumsum(species))







## think we need to lubridate first, get dates aligned! ##


