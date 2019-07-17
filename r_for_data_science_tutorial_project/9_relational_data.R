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
library(ggplot2)
install.packages('maps')
library(maps)
airports %>% 
  semi_join(flights, by = c("faa" = "dest")) %>%
  ggplot(aes(lon, lat)) + 
  borders("state") +
  geom_point() + 
  coord_quickmap()
  
## Get the flights to the top 10 destinations
top_dest <- flights %>%
  count(dest, sort = TRUE) %>%
  head(10)
flights %>% 
  filter(dest %in% top_dest$dest)

## To get only the rows in x (which is joined with y), use 'semi_join
## The above query can run in this way:
flights %>%
  semi_join(top_dest)

## Other useful table functions:
## anti_join(x, y): keeps the rows that have no match with y
## intersect(x, y): returns only observations both in x and y
## union(x, y): Return unique observations in x and y
## setdiff(x, y): Return observations in x, but not in y
## Examples:
library(tibble)
df1 <- tribble(
  ~x, ~y,
  1,   1,
  2,   1
)
df2 <- tribble(
  ~x, ~y,
  1,   1,
  1,   2
)
intersect(df1, df2)
union(df1, df2)
setdiff(df1, df2)
setdiff(df2, df1)



