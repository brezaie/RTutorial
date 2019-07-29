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
  
## Legend attributes:
## Change the size of the circles in the legend
## Change the number of rows and cols
## Change the position of the legend
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color = class)) + 
  geom_smooth(se = FALSE) + 
  theme(legend.position = "bottom") + 
  guides(
    color = guide_legend(nrow = 1, override.aes = list(size = 5))
  )

## Scale to log:
ggplot(diamonds, aes(carat, price)) + 
  geom_bin2d() + 
  scale_x_log10() + 
  scale_y_log10()

## Scale colors manually
## RColorBrewer is shown on Page 457 or the folllowing:
## https://r4ds.had.co.nz/graphics-for-communication.html#replacing-a-scale
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color = drv)) +
  scale_color_brewer(palette = "Set1")
  
## Set color manually:
presidential %>%
  mutate(id = row_number()) %>%
  ggplot(aes(start, id, color = party)) + 
  geom_point() + 
  geom_segment(aes(xend = end, yend = id)) + 
  geom_point(aes(end, id)) + 
  scale_x_date(
    NULL,
    breaks = presidential$start,
    date_labels = "'%y"
  ) + 
  scale_color_manual(values = c(Republican = "red", Democratic = "blue"))




# Zooming -----------------------------------------------------------------

## Set limits on the axises:
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color = class)) + 
  geom_smooth(se = FALSE) + 
  coord_cartesian(xlim = c(5, 7), ylim = c(10, 30))

## IMPORTANT: When comparing 2 plots, unify the axis ranges:
suv <- mpg %>% filter(class == "suv")
compact <- mpg %>% filter(class == "compact")

x_scale <- scale_x_continuous(limits = range(mpg$displ))
y_scale <- scale_y_continuous(limits = range(mpg$hwy))
col_scale <- scale_color_discrete(limits = unique(mpg$drv))

ggplot(suv, aes(displ, hwy, color = drv)) + 
  geom_point() + 
  x_scale + 
  y_scale + 
  col_scale

ggplot(compact, aes(displ, hwy, color = drv)) + 
  geom_point() + 
  x_scale + 
  y_scale + 
  col_scale


# Themes ------------------------------------------------------------------

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color = class)) + 
  geom_smooth(se = FALSE) + 
  theme_classic()



# Saving plots ------------------------------------------------------------

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color = class)) + 
  geom_smooth(se = FALSE)

ggsave("new_plot.pdf")


