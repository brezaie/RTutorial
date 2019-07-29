library(dplyr)
library(ggplot2)
install.packages('ggrepel')
library(ggrepel)



# Title -------------------------------------------------------------------

## Use labs() to add title
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color = class)) + 
  geom_smooth(se = FALSE) + 
  labs(
    x = "Engine displacement (L)",
    y = "Highway fuel economy (mpg)",
    colour = "Car type",
    title = "Fuel efficiency generally decreases with engine size",
    subtitle = "Two seaters (sports cars) are an exception because of their light weight",
    caption = "Data from fueleconomy.gov"
  )

## Equations can be used in the labels by quote()
df <- tibble(
  x = runif(10),
  y = runif(10)
)
ggplot(df, aes(x, y)) +
  geom_point() +
  labs(
    x = quote(sum(x[i] ^ 2, i == 1, n)),
    y = quote(alpha + beta + frac(delta, theta))
  )


# Annotation (text on the plot) -------------------------------------------

## Use geom_text() to insert text inside the plot

best_in_class <- mpg %>%
  group_by(class) %>% 
  filter(row_number(desc(hwy)) == 1)

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour = class)) + 
  geom_text(aes(label = model), data = best_in_class)

## We can also use geom_label() to do the above 
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour = class)) + 
  geom_label(aes(label = model), 
             data = best_in_class,
             nudge_y = 2,
             alpha = 0.6)

## IMPORTANT: To avoid label overlap, use geom_label_repel()
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour = class)) + 
  geom_point(size = 3, shape = 1, data = best_in_class) +
  geom_label_repel(aes(label = model), data = best_in_class)

## Remove legend when using the geom_label_repel:
class_avg <- mpg %>%
  group_by(class) %>%
  summarize(
    displ = median(displ),
    hwy = median(hwy)
  )
ggplot(mpg, aes(displ, hwy, color = class)) +
  ggrepel::geom_label_repel(aes(label = class),
                            data = class_avg,
                            size = 3,
                            label.size = 0,
                            segment.color = NA
  ) +
  geom_point() +
  theme(legend.position = "none")

## Add title inside the plot by summarize()
custom_label <- mpg %>%
  summarise(
    displ = max(displ),
    hwy = max(hwy),
    label = "Increasing engine size is \nrelated to decreasing fuel economy"
  )
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color = class)) + 
  geom_text(
    aes(label = label),
    data = custom_label,
    vjust = "top",
    hjust = "right"
  )


# Scales ------------------------------------------------------------------

## use scales_X_X format
## break() controls the ticks:

ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  scale_y_continuous(breaks = seq(15, 40, by = 5))

## Remove x-axis and y-axis labels:
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() + 
  scale_y_continuous(labels = NULL) + 
  scale_x_continuous(labels = NULL)

## Show the exact occurrence on axis:
presidential
presidential %>%
  mutate(id = row_number()) %>%
  ggplot(aes(start, id)) + 
  geom_point() + 
  geom_segment(aes(xend = end, yend = id)) + 
  geom_point(aes(end, id)) + 
  scale_x_date(
    NULL,
    breaks = presidential$start,
    date_labels = "'%y"
  )
  

