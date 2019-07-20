library(lubridate)
library(nycflights13)

today()
now()

ymd("2019 June 20")
ymd("2019-June-20")
ymd(20190720)



flights %>%
  select(year, month, day, hour, minute) %>%
  mutate(
    departure = make_datetime(year, month, day, hour, minute)
  ) %>%
  filter(departure < ymd(20130110)) %>%
  ggplot(aes(departure)) + 
  geom_freqpoly(binwidth = 6000)

year(today())
day(today())
wday(today(), label = TRUE)
yday(today())
mday(today())

## add/remove time or set time
datetime <- now()
datetime
year(datetime) <- 2020
datetime
datetime %>%
  update(year = 2018, month = 2, mday = 5)

## time difference
h_age <- today() - ymd("2019-01-01")
h_age

