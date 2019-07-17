install.packages('stringr')
library(stringr)

## Most simple example
x <- c("apple", "banana", "eggplant")
str_view(x, "ba")

## . represents any single characted except the 'new line'
str_view(x, '.*a.')

## ^: To match the start of the string
str_view(x, '^a')

## $: To match the end of the string
str_view(x, 'a$')

## \d: Matches any digits
## \s: Matches any whitespaces (space, tab, newline)

## Repititions:
## ?: 1 or 1 repititions
## +: 1 or more repititions
## *: 0 or more repititions
## {n}: exactly n times
## {n,}: n or more
## {,m}: at most m times
## {n,m}: between n and m times
x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_view(x, 'C[LX]+')
str_view(x, "C{2}")
str_view(x, "C{2,}")
str_view(x, "C{2,3}")

## Regex matches the longest string. To show the shortest string, use '?' at the end of the regex:
str_view(x, "C{2,}?")
str_view(x, 'C[LX]+?')




## Page 206
