install.packages('readr')
library(readr)

## read_csv() reads comma-delimited files
## read_csv2() reads semicolon-separated files
## read_tsv() reads tab-delimited files
## read_delim() reads in files with any delimiter
## read_fwf() reads fixed-width files
## read_table() reads a common variation of fixed-width files where columns are separated by white space
## read_log() reads Apache style log files

## read from a file
diamonds <- read_csv("diamonds.csv")

## insert data as csv
handmade_csv <- read_csv("a,b,c
                          1,2,3
                          hi,bye,hello")

## Insert metadata and skip them for data import
meta_csv <- read_csv("The first line of metadata
                     The second line of metadata
                     x,y,z
                     1,2,3",
                     skip = 2)

## Insert comment and skip it for data import
comment_csv <- read_csv("# This is a comment
                        x,y,z
                        1,2,3",
                        comment = "#")

## If data has no column name
no_column_name_csv <- read_csv("1,2,3\n4,5,6", col_names = FALSE)

## set column names if does not exist
set_column_names_csv <- read_csv("1,2,3\n4,5,6", 
                                 col_names = c("x", "y", "z"))

## Show not avaibale values
na_csv <- read_csv("a,b,c\n1,2,.", na = ".")

