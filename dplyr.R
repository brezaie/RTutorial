# install.packages('nycflights13')
# install.packages('dplyr')
library(nycflights13)
library(dplyr)

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
select(flights, time_hour, everything())

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


