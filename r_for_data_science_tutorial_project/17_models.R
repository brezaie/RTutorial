install.packages('modelr')
library(modelr)

sim1
ggplot(sim1, aes(x, y)) + 
  geom_point()


# Create a model ----------------------------------------------------------

models <- tibble(
  a1 = runif(250, -20, 40),
  a2 = runif(250, -5, 5)
)

ggplot(sim1, aes(x, y)) + 
  geom_abline(
    aes(intercept = a1, 
        slope = a2),
    data = models, alpha = 1/4
  ) + 
  geom_point()

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

models <- models %>%
  mutate(dist = purrr::map2_dbl(a1, a2, sim1_dist))

## IMPORTANT: Plot the best models:
ggplot(sim1, aes(x, y)) + 
  geom_point(size = 2, color = "grey30") + 
  geom_abline(
    aes(intercept = a1, slope = a2, color = dist),
    data = filter(models, rank(dist) <= 10)
  )
rank(models$dist)

## IMPORTANT: Get the relation between a1 and a2 in the best models:
ggplot(models, aes(a1, a2)) + 
  geom_point(
    data = filter(models, rank(dist) <= 10),
    size = 4,
    color = "red"
  ) + 
  geom_point(aes(color = -dist))

## IMPORTANT: Create a grid of a1 and a2's
grid <- expand.grid(
  a1 = seq(-5, 20, length = 25),
  a2 = seq(1, 3, length = 25)
) %>%
  mutate(dist = map2_dbl(a1, a2, sim1_dist))

grid %>% ggplot(aes(a1, a2)) + 
  geom_point(
    data = filter(grid, rank(dist) <= 10),
    size = 4, 
    color = "red"
  ) + 
  geom_point(aes(color = -dist))

## IMPORTANT: Plot the best models on the data
ggplot(sim1, aes(x, y)) + 
  geom_point(size = 2, color = "grey30") + 
  geom_abline(
    aes(intercept = a1, slope = a2, color = -dist),
    data = filter(grid, rank(dist) <= 10)
  )

## IMPORTANT: Find the best model by Newton-Raphson method 
##     starting from c(0, 0)
best <- optim(c(0, 0), measure_distance, data = sim1)
best$par

ggplot(sim1, aes(x, y)) + 
  geom_point(size = 2, color = "grey30") + 
  geom_abline(
    aes(intercept = best$par[1], slope = best$par[2])
  )


# Create linear model with lm ---------------------------------------------

sim1_mod <- lm(y ~ x, data = sim1)
coef(sim1_mod)



# Create a grid for visualization of the data ------------------------------

## The 'data_grid' creates data points near the given values
grid <- sim1 %>% data_grid(x)
grid

## Add predictions:
grid <- grid %>%
  add_predictions(sim1_mod)
grid

## Visualize the real values and the model predicted points
ggplot(sim1, aes(x)) + 
  geom_point(aes(y = y)) + 
  geom_abline(
    aes(y = pred),
    data = grid, 
    colour = "red",
    size = 1
  )


ggplot(sim1, aes(x)) +
  geom_point(aes(y = y)) +
  geom_line(
    aes(y = pred),
    data = grid,
    colour = "red",
    size = 1
  )

## Page 355
