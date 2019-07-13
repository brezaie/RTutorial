## Two importan questions for data analysis:
## 1. What type of variation occurs within my variables?
## 2. What type of covariation occurs between my variables?

## Get the ranges of a contineous variable by 'cut_width'
diamonds %>% count(cut_width(carat, 0.5))

## Limitation on y axis
# ggplot(diamonds) + 
#   geom_histogram(mapping = aes(x = y), binwidth = 0.5) + 
#   coord_cartesian(ylim = c(0, 50))

## ggplot removes the missing values when drawing the plot
# diamonds2 <- diamonds %>%
#   mutate(y = ifelse(y < 3 | y > 20, NA, y))
# ggplot(diamonds2, mapping = aes(x = x, y = y)) + 
#   geom_point(na.rm = TRUE)

## At which hours cancelled and non-cancelled flights have occurred
# flights %>%
#   mutate(
#     cancelled = is.na(dep_time),
#     sched_hour = sched_dep_time%/% 100,
#     sched_min = sched_dep_time %% 100,
#     sched_dep_time = sched_hour + sched_min / 60
#   ) %>%
#   ggplot(mapping = aes(x = sched_dep_time, color = cancelled)) +
#   geom_freqpoly(binwidth = 1 / 4)

## IMPORTANT! 'density' on y-axis displays the count standardized so that the area
## under each frequence polygon is one
# ggplot(diamonds, mapping = aes(x = price, y = ..density..)) + 
#   geom_freqpoly(mapping = aes(color = cut))

## geom_boxplot example
# ggplot(data = diamonds, mapping = aes(x = cut, y = price)) + 
#   geom_boxplot()

## 'reorder' the classes (categorical variable) according 
## to another value. In here, we reorder the 'class' variable
## according to the 'median' of the 'hwy'
# mpg %>%
#   ggplot(
#     mapping = aes(
#       x = reorder(class, hwy, FUN = median),
#       y = hwy
#     )
#   ) +
#   geom_boxplot() + 
#   coord_flip()

## IMPORTANT! Get the correlaion (covariation) between two 
## categorical variables
## For large plots, use 'd3heatmap' or 'heatmaply' packages
## Solution 1:
# ggplot(data = diamonds) +
#   geom_count(mapping = aes(x = cut, y = color))
## Solution 2:
# diamonds %>% count(color, cut)
## Solution 3: 
# diamonds %>%
#   count(color, cut) %>%
#   ggplot(mapping = aes(x = color, y = cut)) + 
#   geom_tile(mapping = aes(fill = n))

## For large data points, use 'geom_hex' or 'geom_bin2d', 
## instead of 'geom_point'
# diamonds %>%
#   ggplot(mapping = aes(x = carat, y = price)) + 
#   geom_hex()








