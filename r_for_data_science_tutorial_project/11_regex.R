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




## Grouping: \\1 refers to the group which is in paranthesis 
library(stringr)
str_view(fruit, "(..)\\1", match = TRUE)
str_view(fruit, "(.)(.)\\2\\1", match = TRUE)
str_view(fruit, "(.).\\1.\\1", match = TRUE)

## To check if a vector matches the regex:
x <- c("apple", "banana", "pear")
str_detect(x, "e")
# How many common words start with t?
sum(str_detect(words, "^t"))
# What proportion of common words end with a vowel?
mean(str_detect(words, "[aeiou]$"))

## IMPORTANT: Find the words ending in 'x'
## str_subset: get the matches of a regrex
words[str_detect(words, 'x$')]
## OR
str_subset(words, 'x$')

## Find all the senteces containing a color
## str_extract: extract the actual text of a match
color <- c("red", "orange", "yellow", "green", "blue", "purple")
color_match <- str_c(color, collapse = "|")
color_match
## extract the sentences that contain a color:
has_color <- str_subset(sentences, color_match)
## extract the colors:
matches <- str_extract(has_color, color_match)

## IMPORTANT:
## str_count: get the number of matches with regex:
## selecting all the sentences that have more than one match:
more <- sentences[str_count(sentences, color_match) > 1]

## ignore case
bananas <- c("banana", "Banana", "BANANA")
str_view(bananas, regex("banana", ignore_case = TRUE))
