library(readr)

challenge <- read_csv(
  readr_example("challenge.csv"),
  col_types = cols(
    x = col_double(),
    y = col_date()
  )
)

write_csv(challenge, "challeng.csv")

## To write data only for R language
write_rds(challenge, "challenge.rds")
read_rds("challenge.rds")
