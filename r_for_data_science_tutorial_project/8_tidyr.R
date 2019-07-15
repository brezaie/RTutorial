install.packages('tidyr')
library(tidyr)

table1 %>%
  mutate(rate = cases / population * 10000)

## Get the number of cases for each year
table1 %>%
  group_by(year) %>% 
  summarise(count = sum(cases))

## 'gather' function: creates a new column 'year' and fills it with 
## the values of the columns `1999` and `2000`
## Parameters:
## Which columns to gether into a single column?
## key: the name of the new column
## value: the values of the previous columns
table4a # shows the number of cases for each year
cases <- table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")
population <- table4b %>%
  gather(`1999`, `2000`, key = "year", value = "population")
left_join(cases, population)

## 'spread' function: creates two columns for 'cases' and 'population'
## Parameters:
## key: the column containing variable names
## value: the column forming multiple variables
table2
table2 %>%
  spread(key = type, value = count)

## 'separate' function: devides a column into separate columns
## The delimeter is any non-alphanumeric character
table3
table3 %>%
  separate(
    rate, 
    into = c("rate", "population")
  )
## The resulted 'rate' and 'population' are of the char type
## To convert them into number, use:
table3 %>%
  separate(
    rate, 
    into = c("rate", "population"), 
    convert = TRUE
  )

## 'separate' another example:
separate_year <- table3 %>%
  separate(year, into = c("century", "year"), sep = 2)

## 'unite' function: merges multi columns into one column
separate_year %>%
  unite(new_column, century, year, sep = "")
  
## 'complete' function: takes a set of columns, 
##       and finds all unique combinations. It shows the missing values
stocks <- tibble(
  year = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr = c( 1, 2, 3, 4, 2, 3, 4),
  return = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66)
)
stocks %>%
  complete(year, qtr)

## 'fill' function is used to replace the missing values (NAs)
## with the last non-missing value
treatment <- tribble(
  ~ person, ~ treatment, ~response,
  "Derrick Whitmore", 1, 7,
  NA, 2, 10,
  NA, 3, 9,
  "Katherine Burke", 1, 4
)
treatment %>%
  fill(person)

## Working with 'who' dataset
## Case study on page 163
who

who1 <- who %>%
  gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)

who1

who1 %>% count(key)

## replace 'newrell' column with 'new_rel' for convinience
library(stringr)
who2 <- who1 %>%
  mutate(key = str_replace(key, "newrel", "new_rel"))
who2

## Separate the colum key into:
## 'new': is it a new experiment or old?
## 'type' the type of the disease
## 'sexage': the sex and the age of the patient
who3 <- who2 %>%
  separate(key, into = c("new", "type", "sexage"), sep = "_")
who3

who3 %>% count(new)
## Since all the experiment are new, we drop it with other columns
who4 <- who3 %>% select(-new, -iso2, -iso3)
who4

## separete the 'sexage' column into sex and age
who5 <- who4 %>%
  separate(sexage, c("sex", "age"), sep = 1)
who5

## separate the age into 'from age' and 'to age'
who6 <- who5 %>%
  separate(age, c("fromage", "toage"), sep = -3)
who6


plot_data <- who5 %>% 
  group_by(country, year, sex) %>%
  summarise(count = sum(cases))

plot_data

ggplot(plot_data, mapping = aes(x = country, y = count, fill = sex)) + 
  geom_bar(stat = "stacked")
