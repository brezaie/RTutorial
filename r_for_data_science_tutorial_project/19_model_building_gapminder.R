install.packages('gapminder')
library(gapminder)
library(purrr)
library(tidyr)
gapminder


# How does life expectancy (lifeExp) change over time for each country --------

gapminder %>%
  ggplot(aes(year, lifeExp, group = country)) + 
  geom_line()

## nest: Creates a data frame from the groubed columns
by_country <- gapminder %>%
  group_by(country, continent) %>%
  nest()

country_model <- function(df) {
  lm(lifeExp ~ year, data = df)
}

by_country <- by_country %>%
  mutate(model = map(data, country_model))

by_country <- by_country %>%
  mutate(resids = map2(data, model, add_residuals))
by_country

resids <- unnest(by_country, resids)
resids
resids %>% 
  ggplot(aes(year, resid)) + 
  geom_line(aes(group = country), alpha = 1 / 3) + 
  geom_smooth(se = FALSE)

resids %>% 
  ggplot(aes(year, resid)) + 
  geom_line(aes(group = country), alpha = 1/3) + 
  geom_smooth(se = FALSE) + 
  facet_wrap(~ continent)

## Page 406 - Model Quality
library(broom)

glance <- by_country %>%
  mutate(glance = map(model, broom::glance)) %>%
  unnest(glance, .drop = TRUE)

glance %>% arrange(r.squared)
