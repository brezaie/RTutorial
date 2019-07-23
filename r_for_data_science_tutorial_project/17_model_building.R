library(modelr)
library(ggplot2)
library(nycflights13)
library(lubridate)
options(na.action = na.warn)


# Why are low-quality diamond more expensive? -----------------------------

diamonds %>%
  ggplot(aes(cut, price)) + 
  geom_boxplot()
diamonds %>%
  ggplot(aes(color, price)) + 
  geom_boxplot()
diamonds %>%
  ggplot(aes(clarity, price)) + 
  geom_boxplot()
## carat = weight of the diamond
diamonds %>%
  ggplot(aes(carat, price)) + 
  geom_hex()

diamonds2 <- diamonds %>%
  filter(carat <= 2.5) %>%
  mutate(lprice = log2(price), lcarat = log2(carat))
ggplot(diamonds2, aes(lcarat, lprice)) + 
  geom_hex(bins = 50)

diamonds2_mod <- lm(lprice ~ lcarat, data = diamonds2)
diamonds2_grid <- diamonds2 %>%
  data_grid(carat = seq_range(carat, 20)) %>%
  mutate(lcarat = log2(carat)) %>%
  add_predictions(diamonds2_mod, "lprice") %>% ## Change the 'pred' to 'lprice'
  mutate(price = 2 ^ lprice)
ggplot(diamonds2, aes(carat, price)) + 
  geom_hex(bins = 50) + 
  geom_line(data = diamonds2_grid, color = "red", size = 1)



# What effects the number of daily flights? -------------------------------

daily <- flights %>%
  mutate(date = make_date(year, month, day)) %>%
  group_by(date) %>%
  summarise(n = n())
daily %>% ggplot(aes(date, n)) + 
  geom_line()

## day of week
daily <- daily %>%
  mutate(wday = wday(date, label = TRUE))
daily %>% ggplot(aes(wday, n)) + 
  geom_boxplot()

flights_mod <- lm(n ~ wday, data = daily)
flights_grid <- daily %>%
  data_grid(wday) %>% 
  add_predictions(flights_mod, "n")

ggplot(daily, aes(wday, n)) + 
  geom_boxplot() + 
  geom_point(data = flights_grid, color = "red", size = 5)

daily <- daily %>%
  add_residuals(flights_mod)
daily %>% ggplot(aes(date, resid, color = wday)) + 
  geom_ref_line(h = 0) + 
  geom_line()

daily %>% ggplot(aes(date, resid)) + 
  geom_ref_line(h = 0) + 
  geom_line(color = "grey30") + 
  geom_smooth(se = FALSE, span = 0.2)

## IMPORTANT: 'scale_x_date' - Detect the seasonal Saturday effect:
daily %>%
  filter(wday == "Sat") %>%
  ggplot(aes(date, n)) + 
  geom_point() + 
  geom_line() + 
  scale_x_date(
    NULL,
    date_breaks = "1 month",
    date_labels = "%b"
  )

## Create seasons:
get_season <- function(date){
  cut(date, 
      breaks = ymd("20130101", "20130605", "20130825", "20140101"), 
      labels = c("spring", "summer", "fall")
  )
}

daily <- daily %>%
  mutate(season = get_season(date))

daily %>%
  filter(wday == "Sat") %>%
  ggplot(aes(date, n, color = season)) +
  geom_point(alpha = 1/3) + 
  geom_line() + 
  scale_x_date(
    NULL,
    date_breaks = "1 month",
    date_labels = "%b"
  )

daily %>%
  ggplot(aes(wday, n, color = season)) + 
  geom_boxplot()

## It seems the season affects the model to have a better fitness, thus:
flights_without_season_mod <- lm(n ~ wday, data = daily)
flights_with_season_mod <- lm(n ~ wday * season, data = daily)
daily %>% 
  gather_residuals(without_season = flights_without_season_mod, 
                   with_season = flights_with_season_mod) %>%
  ggplot(aes(date, resid, color = model)) + 
  geom_line(alpha = 0.75)

flights_grid <- daily %>%
  data_grid(wday, season) %>%
  add_predictions(flights_with_season_mod, "n")

ggplot(daily, aes(wday, n)) + 
  geom_boxplot() + 
  geom_point(data = flights_grid, color = "red") + 
  facet_wrap(~ season)

## Create another model with the same data
flights_cover_outlier_mod <- MASS::rlm(n ~ wday * season, data = daily)
daily %>% 
  add_residuals(flights_cover_outlier_mod, "resid") %>%
  ggplot(aes(date, resid)) + 
  geom_hline(yintercept = 0, size = 2, color = "white") + 
  geom_line()


