typeof(letters)
typeof(c(1:10))

x <- list("a", "b", 1:10)
length(x)

1:10 %% 3 == 0

## To make an integer, place an 'L' letter
typeof(1)
typeof(1L)

## Implicit conversion from integers to logical vector
x <- sample(200, 100, replace = FALSE)
y <- x > 20
sum(y) 
mean(y)

## Check types:
library(purrr)
is_logical(10)
is_numeric('hello')
is_vector(1)

## To check if the length is 1:
is_scalar_character(c('a', 'b'))
is_scalar_numeric(10)

## R treates anything like a vector. Examples:
sample(10) + 100
## runif: creates a vector of 10 elements between 0 to 1, 
## if the min and max are not set
runif(10) > 0.5 
1:10 + 1:2
1:20  + rep(1:10, 2)

## Nameing vectors:
set_names(1:3, c("a", "b", "c"))


# Filtering ---------------------------------------------------------------

## Subsetting
## Instead of 'filter()', used for tibbles, use '[]' for vectors:
x <- c(10, 3, NA, 5, 8, 1, NA)

## Get the elements at the mentioned indices
x[c(1, 4)]

## Get all the elements except the mentioned ones
x[c(-1, -4)]

## Filter within the []
x[!is.na(x)]
x[x %% 2 == 0]

## Subset with column names:
x <- c(abc = 1, def = 4, xyz = 5)
x[c("xyz", "def")]

## '[[' represents a single value
## x[1, ] represents the first row and all columns
## x[, -1] represents all rows and all columns except the first


# Lists -------------------------------------------------------------------

## Check the ecnlosed image entitled '15_list_representation_1'
x <- list(1, 2, 3)
x

## To show the structure of a list:
x_named <- list(a = "a", b = 1L, c = 5.4, d = TRUE)
str(x_named)

## Check the ecnlosed image entitled '15_list_representation_2'
a <- list(a = 1:3, b = "a string", c = pi, d = list(-1, -5))
str(a[1:2])
