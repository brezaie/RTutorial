df <- tibble::tibble(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

df

x <- df$a
(x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))

## Convert the formula to rnage
## range: returns the min and max of a vector
rng <- range(x, na.rm = TRUE)
(x - rng[1]) / (rng[2] - rng[1])


## Convert the range formula to a function:
rescale01 <- function(x){
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}

## Ctrl+shift+R: make sections (regions in c#)


# Conditions --------------------------------------------------------------

has_name <- function(x) {
  nms <- names(x)
  if (is.null(nms)) {
    rep(FALSE, length(x))
  } else {
    !is.na(nms) & nms != ""
  }
}
has_name('apple')

calculate_temp <- function(temp){
  if(temp <= 0){
    "freezing"
  }
  else if(temp > 0 && temp <= 5){
    "cold"
  }
  else if (temp > 5 && temp <= 15){
    "cool"
  }
  else
  {
    "dunno"
  }
    
}
calculate_temp(5)


# Check eceptions ---------------------------------------------------------

weighted_mean <- function(x, w)
{
  if(length(x) != length(w))
    stop("`x` and `w` must be the same length", call. = FALSE)
  
  sum(w * x) / sum(x)
}
## OR

weighted_mean <- function(x, w)
{
  stopifnot(length(x) == length(w))
  
  sum(w * x) / sum(x)
}
weighted.mean(x = c(1:5), w = c(1:2))


# Return values -----------------------------------------------------------

complicated_function <- function(x, y, z){
  if(length(x) == 0 || length(y) == 0)
    return(0)
}
complicated_function(NULL, NULL, NULL)

## When the function draws a plot or prints something, it's better
## to return the first argument with 'invisible()'
## This way, the function can be used in pipelines
show_missings <- function(df) {
  n <- sum(is.na(df))
  cat("Missing values: ", n, "\n", sep = "")
  invisible(df)
}
show_missings(mtcars)
x <- show_missings(mtcars)
dim(x)
mtcars %>%
  show_missings() %>%
  mutate(mpg = ifelse(mpg < 20, NA, mpg)) %>%
  show_missings()


