## parse_logical() parses logicals
## parse_integer() parses integeres
## parse_double() strict numeric parser
## parse_number() flexible numeric parser
## parse_character()
## parse_factor() creates factors
## parse_datetime(), parse_date(), and parse_time() 
##       parse various date and time specification

parse_integer(c("1", "231", ".", "456"), na = ".")

## Get the problems of parsing
x <- parse_integer(c("1", "asb", "34"))
problems(x)

## Default floating point is '.'. If floating point is ',', use 'locale':
parse_double("1,23", locale = locale(decimal_mark = ","))

## To get the numbers from text
parse_number("$100")
parse_number("This is the top 10 list")

## Get the ASCII code of strings
charToRaw("ABab")

## guess the encoding of a string
x1 <- "سلام بر تو"
guess_encoding(charToRaw(x1))

## Convert datetime format
parse_date("01/02/15", "%m/%d/%y") # output: "2015-01-02"
parse_date("01/02/15", "%y/%m/%d") # output: "2001-02-15"

## Set the type of the columns
## Every 'parse_xyz' function has a corrosponding 'col_xyz' function
challenge <- read_csv(
  readr_example("challenge.csv"),
  col_types = cols(
    x = col_double(),
    y = col_date()
  )
)


