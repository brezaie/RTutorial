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

calculate_temp <- fucntion(temp) {
    "freezing"
}

