# install.packages('nycflights13')
# install.packages('dplyr')
# install.packages('Lahman')
library(nycflights13)
library(dplyr)
library(Lahman)

## Important functions:
## filter(): pick some specific data
## arrange(): reorder the rows
## mutate(): create new variable
## summarize(): collapse many values to a single summary
## group_by(): making a group out of the elements
## %in%: if x is a member of y (x %in% y)
## division: %/%
## remainder: %%

## filter operation
# filter(flights, month == 1, day == 2)

## %in% operation
# nov_dec <- filter(flights, month %in% c(11, 12))

## NA recognition
# da <- data.frame(x = c(1, NA, 3))
# filter(da, is.na(x) | x > 1)

## arrange operation
# arrange(flights, desc(month))

## arrange the NA values beto be appeared first
# arrange(da, desc(is.na(x)), desc(x))

## select operation
# select(flights, year, month, day)

## select from column to another column
# select(flights, year:day)

## do not select some columns
# select(flights, -(year:day))

## select helpers:
## starts_with("abc") the column name starts with abc
## ends_with("abc")
## contains("abc")
## matches("(.)\\1) Regex is used here
## num_range("x", 1:3) matches the columns x1, x2, x3

## rename a column
# rename(flights, tail_num = tailnum)

## selectselect some columns to be appeared first and the rest after that
## with the 'everything' command
# select(flights, time_hour, everything())

## mutate()
# flights_sml <- select(flights, year:day,
#                       ends_with("delay"),
#                       distance,
#                       air_time)
# mutate(flights_sml, 
#        gain = arr_delay - dep_delay,
#        speed= distance / air_time * 60)

## get the next/previous element of each element
# x <- c(1, 5, 9)
# lead(x) # 5, 9, NA
# lag(x) # NA, 1, 5

## cumulative functions:
## cumsum(), cumprod(), cummin(), cummax()
# x <- c(1, 2, 3, 4, 5)
# cumsum(x) # 1 3 6 10 15

## get the rank of the elements by min_rank() or min_rank(desc())
# x <- c(1, 4, 2, 8, 7)
# min_rank(x) # 1 3 2 5 4

## summarise: collapse a data frame to a single row
# summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

## combination of group_by and summarise
# by_date <- group_by(flights, year, month, day)
# summarise(by_date, delay = mean(dep_delay, na.rm = TRUE))

## the relationship between mean distance and mean delay 
# by_dest <- group_by(flights, dest)
# delay <- summarise(by_dest, 
#           count = n(),
#           dist = mean(distance, na.rm = TRUE),
#           delay = mean(dep_delay, na.rm = TRUE))
# delay <- filter(delay, count > 10, dest != "HNL")
# ggplot2::ggplot(data = delay,
#                 mapping = aes(x = dist, y = delay)) +
#   geom_point(aes(size = count), alpha = 1/3) +
#   geom_smooth(se = FALSE)

## The other way to make filtering by %>% (pipe) 
# delay <- flights %>%
#   group_by(dest) %>%
#   summarise(count = n(),
#             dist = mean(dist, na.rm = TRUE),
#             delay = mean(dep_delay, na.rm = TRUE)) %>%
#   filter(count > 10, dest != "HNL")

## get the number of delayed flights by company 
# not_cancelled <- flights %>% filter(!is.na(dep_delay), !is.na(arr_delay)) 
# 
# delays <- not_cancelled %>% 
#   group_by(tailnum) %>% 
#   summarise(delay = mean(arr_delay))
# ggplot(data = delays, mapping = aes(x = delay)) + 
#   geom_freqpoly(binwidth = 10)

## get the avg delay and its number and filter the data on the plot
# delays <- not_cancelled %>%
#   group_by(tailnum) %>%
#   summarise(delay = mean(arr_delay, na.rm = TRUE),
#             n = n()
#   )
# ggplot(data = delays, mapping = aes(x = n, y = delay)) +
#   geom_point(alpha = 1/10)
# 
# delays %>% 
#   filter(n > 25) %>%
#   ggplot(mapping = aes(x = n, y = delay)) + 
#   geom_point(alpha = 1/10)

## get relations between the number of batting (ab) to the batting average (ba)
# batting <- as_tibble(Batting)
# batters <- batting %>%
#   group_by(playerID) %>%
#   summarise(
#     ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
#     ab = sum(AB, na.rm = TRUE)
#   )
# batters %>%
#   filter(ab > 100) %>%
#   ggplot(mapping = aes(x = ab, y = ba)) + 
#   geom_point(alpha = 1/10) + 
#   geom_smooth(se = FALSE)

## get the positive delay. Filtering inside the mean function for positive delays
# not_cancelled %>% 
#   group_by(year, month, day) %>%
#   summarise(
#     delay_avg1 = mean(arr_delay),
#     delay_avg2 = mean(arr_delay[arr_delay > 0])
#   )

## get the first and last departure of the day
# not_cancelled %>% 
#   group_by(year, month, day) %>%
#   summarise(
#     first = first(dep_time),
#     last = last(dep_time)
#     )

## to count the values -> n()
## to count the number of non-missing values -> sum(!is.na(x))
## to count the distinct elements -> n_distinct(x)
# to count the number od elements -> count()
# not_cancelled %>% 
#   group_by(dest) %>%
#   summarise(carriers = n_distinct(carrier)) %>%
#   arrange(desc(carriers))
# not_cancelled %>% count(dest)

## IMPORTANT: the logics inside the 'sum' and 'mean' function are intrepreted as 1 (TRUE) or 0 (FALSE)
## how may flights have left before 5am?
# not_cancelled %>% group_by(year, month, day) %>% summarise(n_early = sum(dep_time < 500))
## What proportion of flights are delayed by more than 1 hour?
# not_cancelled %>% group_by(year, month, day) %>% summarise(proportion = mean(arr_delay > 60))

## get the most delayed flights on daily basis
# not_cancelled %>% group_by(year, month, day) %>% filter(rank(desc(arr_delay)) <= 3) %>% select(year, month, day, arr_delay, everything())


