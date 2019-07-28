# install.packages('gapminder')
library(gapminder)
library(purrr)
library(tidyr)
library(ggplot2)
library(dplyr)
library(modelr)
library(tibble)
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

## Page 406 - Model Quality - Get other model measures 
##       other than residuals
library(broom)

glance <- by_country %>%
  mutate(glance = map(model, broom::glance)) %>%
  unnest(glance, .drop = TRUE)
glance

# glance %>% unnest(resids, .drop = TRUE)
# glance %>% unnest(glance, .drop = TRUE)

glance %>% arrange(r.squared)

glance %>%
  ggplot(aes(continent, r.squared)) + 
  geom_jitter(width = 0.5)

bad_fit <- glance %>% filter(r.squared < 0.25)

# gapminder %>%
#   semi_join(bad_fit, by = "country")

gapminder %>%
  semi_join(bad_fit, by = "country") %>%
  ggplot(aes(year, lifeExp, color = country)) + 
  geom_line()


# How to create column lists? ----------------------------------------------


# 1. With nesting ---------------------------------------------------------

gapminder %>% 
  group_by(country, continent) %>%
  nest()
## OR
gapminder %>%
  nest(year: gdpPercap)


# 2. From vectorized functions ------------------------------------------------

df <- tribble(
  ~x,
  "a,b,c",
  "d,e,f,g"
)

df %>%
  mutate(x2 = stringr::str_split(x, ","))

df %>%
  mutate(x2 = stringr::str_split(x, ",")) %>%
  unnest()


# 3. From a named list -------------------------------------------

x <- list(
  x = 1:5,
  b = 3:4,
  c = 5:6
)

df <- enframe(x)
df
