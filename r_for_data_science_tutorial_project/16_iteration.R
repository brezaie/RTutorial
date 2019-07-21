
# For loop ----------------------------------------------------------------

df <- tibble(
  a = rnorm(10),
  b = rnorm(10), 
  c = rnorm(10),
  d = rnorm(10)
)

## Get the median of each column:
output <- vector("double", ncol(df))

for(i in seq_along(df)){
  output[[i]] <- median(df[[i]])
}
output


# Pass a function to another function -------------------------------------

col_summary <- function(df, fun) {
  out <- vector("double", length(df))
  for (i in seq_along(df)) {
    out[[i]] <- fun(df[[i]])
  }
  out
}

col_summary(df, median)
col_summary(df, mean)

## Page 325
