install.packages('modelr')
library(modelr)

sim1
ggplot(sim1, aes(x, y)) + 
  geom_point()


# Create a model ----------------------------------------------------------

model1 <- function(a, data) {
  a[1] + data$x * a[2]
}
model1(c(7, 1.5), sim1)
measure_distance <- function(mod, data){
  diff <- data$y - model1(mod, data)
  sqrt(mean(diff ^ 2))
}
measure_distance(c(7, 1.5), sim1)

## Claculate distance for all models
sim1_dist <- function(a1, a2) {
  measure_distance(c(a1, a2), sim1)
}

models <- mtcars %>%
  split(.$cyl) %>%
  map(function(df) lm(mpg ~ wt, data = df))

models <- models %>%
  mutate(dist = purrr::map2_dbl(a1, a2, sim1_dist))

