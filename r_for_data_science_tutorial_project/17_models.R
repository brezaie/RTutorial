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
  geom_line(
    aes(y = pred),
    data = grid, 
    colour = "red",
    size = 1
  )

## Page 355
## IMPORTANT: Get the residuals:
sim1 <- sim1 %>%
  add_residuals(sim1_mod)
sim1
ggplot(sim1, aes(x, resid)) + 
  geom_ref_line(h = 0) + 
  geom_point()


# One variable: Create non-linear model -------------------------------------------------

sim1_mod_curve <- loess(y ~x, data = sim1)
sim1_grid_curve <- sim1 %>%
  data_grid(x)

sim1_grid_curve <- sim1_grid_curve %>%
  add_predictions(sim1_mod_curve)
sim1_grid_curve

ggplot(sim1, aes(x)) + 
  geom_point(aes(y = y)) + 
  geom_smooth(
    aes(y = pred), 
    data = sim1_grid_curve,
    colour = "red"
  )

## gather_predictions: we can add different models 
gather_pred <- sim1_grid_curve %>%
  gather_predictions(sim1_mod_curve)
gather_pred
sim1_grid_curve



# One variable: Categorical variable model --------------------------------------------------------------

ggplot(sim2) + 
  geom_point(aes(x, y))
sim2_mod <- lm(y ~x, data = sim2)
sim2_grid <- sim2 %>%
  data_grid(x) %>%
  add_predictions(sim2_mod)
ggplot(sim2, aes(x)) + 
  geom_point(aes(y = y)) + 
  geom_point(
    data = sim2_grid,
    aes(y = pred),
    colour = "red",
    size = 4
  )


# Two variables: Contineous and categorical variables ------------------------------------

sim3
ggplot(sim3, aes(x1, y)) + 
  geom_point(aes(color = x2))

sim3_mod1 <- lm(y ~ x1 + x2, data = sim3)
sim3_mod2 <- lm(y ~ x1 * x2, data = sim3)
sim3_grid <- sim3 %>% 
  data_grid(x1, x2) %>%
  gather_predictions(sim3_mod1, sim3_mod2)
sim3_grid
ggplot(sim3, aes(x1, y, color = x2)) + 
  geom_point() + 
  geom_line(data = sim3_grid, aes(y = pred)) + 
  facet_wrap(~model)

sim3 <- sim3 %>%
  gather_residuals(sim3_mod1, sim3_mod2)
ggplot(sim3, aes(x1, resid, color = x2)) + 
  geom_point() + 
  facet_grid(model ~ x2)


# Two variables: both continuous ------------------------------------------

sim4
sim4_mod1 <- lm(y ~ x1 + x2, data = sim4)
sim4_mod2 <- lm(y ~ x1 * x2, data = sim4)
sim4_grid <- sim4 %>%
  data_grid(
    x1 = seq_range(x1, 5), ## get 5 x1 items between min and max of x1
    x2 = seq_range(x2, 5)
  ) %>%
  gather_predictions(sim4_mod1, sim4_mod2)
sim4_grid
ggplot(sim4_grid, aes(x1, x2)) + 
  geom_tile(aes(fill = pred)) + 
  facet_wrap(~model)

x <- 5


