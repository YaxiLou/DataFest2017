cars <- read_csv("Workshop II/Data/cars.csv")
problems(cars)
unique(problems(cars)$col)

cars <- read_csv("Workshop II/Data/cars.csv",
                 col_types = cols(guzzler = "c"))
save(cars, file = "Workshop II/Data/cars.rda")

names(cars)

library(ggplot2)
ggplot(cars) + geom_histogram(aes(x = highway08))
ggplot(cars) + geom_histogram(aes(x = UHighway))

library(tidyr)

gather(cars, mpg_type, mpg, c(highway08, UHighway)) %>% 
  ggplot() + geom_histogram(aes(x = mpg)) + facet_wrap(~mpg_type, ncol = 1)


cars %>% 
  mutate(diff_hw = highway08 - UHighway) %>% 
ggplot() + geom_histogram(aes(x = diff_hw))

cars %>% 
  group_by(year) %>% 
  summarize(mean_mpg = mean(highway08),
            sd_mpg = sd(highway08))

cars %>% 
  filter(year < 2008) %>% 
  select(id, highway08, UHighway) %>% 
  gather(mpg_type, mpg, 2:3) %>% 
  ggplot() +
  geom_histogram(aes(x = mpg)) +
  facet_wrap(~mpg_type, ncol = 1)

cars %>% 
  filter(year < 2008) %>% 
  mutate(diff_mpg = UHighway - highway08) %>% 
  ggplot() +
    geom_histogram(aes(diff_mpg))

cars %>% 
  filter(make %in% c("Cadillac", "Toyota")) %>% 
  ggplot() +
    geom_density(aes(x = highway08)) +
    facet_wrap(~make, ncol = 1)
