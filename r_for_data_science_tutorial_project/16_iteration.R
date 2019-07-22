
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


# Mapping instead of loop -------------------------------------------------


## example 1
df
map_dbl(df, mean)
map_dbl(df, median)

## example 2
z <- list(x = 1:3, y = 4:6)
z %>%
  map(mean)

## example 3
models <- mtcars %>%
  split(.$cyl) %>%
  map(function(df) lm(mpg ~ wt, data = df))
## OR ('.' referes tp the current list element)
models <- mtcars %>%
  split(.$cyl) %>%
  map(~lm(mpg ~ wt, data = .))
models %>% map(summary)

## Get the number of unique values in each column of the 'iris'
iris %>% map(function(x) length(unique(x)))
## OR
iris %>% lapply(function(x) length(unique(x)))


# Use 'walk/pwalk/walk2' for void (no return) functions -------------------------------

## IMPORTANT: Save the plots to files
plots <- mtcars %>%
  split(.$cyl) %>%
  map(~ggplot(., aes(mpg, wt)) + geom_point())
paths <- str_c(names(plots), ".pdf")
pwalk(list(paths, plots), ggsave, path = tempdir())



# Predicates --------------------------------------------------------------

## Find the first element and its index
x <- sample(10)
x
x %>% detect(~ . < 5)
x %>% detect_index(~ . < 5)



x <- c(1, 3, 6, 9)
x
as.data.frame(x)
sapply(as.data.frame(x), sum)
