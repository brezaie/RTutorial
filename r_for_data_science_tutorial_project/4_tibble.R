# install.packages('tibble')
# library(tibble)

## Convert data.frame to tibble
# as_tibble(iris)

## Create a tibble
# tibble(
#   x = 1:5,
#   y = 1,
#   z = x ^ 2 + y
# )

## Create small tibble with 'tribble'
# tribble(
#   ~x, ~y, ~z,
#   "a", 1, 3.5,
#   "b", 8, -1.5
# )

## print the top n rows of a dataset
## 'width = Inf' prints all the columns with their data
# library(nycflights13)
# flights %>% print(n = 10, width = Inf)

## Convert a tibble to data frame
# as.data.frame(iris)

