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


