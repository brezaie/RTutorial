install.packages('stringr')
library(stringr)

## IMPORTANT: To show the " or ' marks, use 'writeLines' function
st1 <- "This is the first string \" that we have"
writeLines(st1)

## str_lenth: get the length of a string
str_length(c("a", "hello", "goodbye"))

## concat or combine strings
str_c("hello,", "world", sep = " ")
x <- c("abd", NA, "'")
str_c("{", str_replace_na(x), "}")

## conditions in concat
name <- "Behzad"
time_of_day <- "morning"
birthday <- FALSE
str_c("Good ", time_of_day, " ", name,
      if(birthday) " and HaPPY BIRTHDAY B-)", ".")

## convert a list of string to a single string
str_c(c("a", "b", "c"), collapse = " ")

## get the substring
x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 2)
str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1))

## sort strings
x <- c("apple", "eggplant", "banana")
str_sort(x, locale = "fa")

## replace a string with another string
x <- c("apple", "pear", "banana")
str_replace(x, "[aeiou]", "-")
str_replace_all(x, "[aeiou]", "-")
x <- c("1 house", "2 cars", "3 people")
str_replace_all(x, c("1" = "one", "2" = "two", "3" = "three"))

## split strings:
"a|b|c|d" %>%
  str_split("\\|") %>%
  .[[1]]
## simplify: returns a matrix
sentences %>%
  head(5) %>%
  str_split(" ", simplify = TRUE)




