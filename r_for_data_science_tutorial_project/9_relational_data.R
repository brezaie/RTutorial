library(nycflights13)
library(dplyr)

airlines
airports
planes
weather

planes %>%
  count(tailnum) %>%
  filter(n > 1)

weather %>% 
  count(year, month, day, hour, origin) 

## Add primary key (surrogate key) to 'flights'
flights <- flights %>%
  mutate(id = row_number())

## left_join
joined_flights_airlines <- flights %>%
  left_join(airlines, by = "carrier")
View(joined_flights_airlines)

## End of page 186
