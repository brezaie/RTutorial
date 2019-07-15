# install.packages('ggplot2')
# install.packages('dplyr')

library(ggplot2)
library(dplyr)

## Template:
# ggplot(data = <DATA>) +
#   <GEOM_FUNCTION>(
#     mapping = aes(<MAPPINGS>),
#     stat = <STAT>,
#     position = <POSITION>
#   ) +
#   <COORDINATE_FUNCTION> +
#   <FACET_FUNCTION>

# mpg

# ggplot(data = mpg) +
#   geom_point(mapping = aes(x = displ, y = hwy))

## Above chart does not show overlapping points
## To show the overlapping points, use 'jitter' as position
# ggplot(data = mpg) +
#   geom_point(mapping = aes(x = displ, y = hwy),
#              position = "jitter")

# ggplot(data = mpg) + 
#   geom_point(mapping = aes(x = displ, y = hwy, 
#                            shape = class))

## Set the aesthetic ('color' property in this example) manually
# ggplot(data = mpg) + 
#   geom_point(mapping = aes(x = displ, y = hwy),
#              color = "blue")

## Set the aesthetic ('shape' property in this example) manually
# ggplot(data = mpg) + 
#   geom_point(mapping = aes(x = displ, y = hwy),
#              shape = 24)


## Set conditions for coloring
# ggplot(data = mpg) +
#   geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))

## Draw multiple charts based on different classes
# ggplot(data = mpg) +
#   geom_point(mapping = aes(x = displ, y = hwy))+
#   facet_wrap(~ class, nrow = 3)

## Draw multiple charts based on 2 properties
## Sample 1
# ggplot(data = mpg) +
#   geom_point(mapping = aes(x = displ, y = hwy))+
#   facet_grid(drv ~ cyl)
## Sample 2
# ggplot(data = mpg) +
#   geom_point(mapping = aes(x = displ, y = hwy))+
#   facet_grid(drv ~ .)

## Get help for facet_wrap, run the following command
# ?facet_wrap


## geom_smooth with categorization by 'linetype'
# ggplot(data = mpg) + 
#   geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

## Do not show legend by 'show.legent = FALSE'
# ggplot(data = mpg) + 
#   geom_smooth(mapping = aes(x = displ, y = hwy, color = drv),
#               show.legend = FALSE)


## Two charts (plots) in a single plot
# ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
#   geom_point() +
#   geom_smooth()

## Filtering in chart (plot)
# ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
#   geom_point(mapping = aes(color = class)) +
#   geom_smooth(
#     data = filter(mpg, class == "subcompact"),
#     se = FALSE
#   )

## Diamonds dataset
# diamonds

## Bar chart
## The default stat is count. It counts the number of times 
## each x axis feature has occurred and shows the count in y axis
# ggplot(data = diamonds) +
#   geom_bar(mapping = aes(x = cut))

## stat = "identity" example
## Identity stat displays the real value of each y axis features
# a <- c("bar1", "bar2", "bar3")
# b <- c(10, 20, 30)
# da <- data.frame(a, b)
# ggplot(data = da) +
#   geom_bar(mapping = aes(x = a, y = b), stat = "identity")

## proportinal x axis features compared with each other
# ggplot(data = diamonds) + 
#   geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))


## To show the summary of each x axis feature on y axis
# ggplot(data = diamonds) + 
#   stat_summary(
#     mapping = aes(x = cut, y = price),
#     fun.ymin = min,
#     fun.ymax = max,
#     fun.y = median
#   )

## Make colorful groups
## Difference between color and fill
## Color: paints the border
## Fill: paints the whole bar
# ggplot(data = diamonds) + 
#   geom_bar(mapping = aes(x = cut, color = cut))
# ggplot(data = diamonds) + 
#   geom_bar(mapping = aes(x = cut, fill = cut))
## If the x axis and 'fill' properties are different features, the bars
## are stacked on each other
# ggplot(data = diamonds) +
#   geom_bar(mapping = aes(x = cut, fill = clarity))

## To avoid stack, we can use different 'position's like
## 'identity': stacks on each other 
## 'fill': like 'stack, 'identity', but bars are of the same height
## 'dodge': represents each bar separately 
# ggplot(data = diamonds,
#        mapping = aes(x = cut, fill = clarity)) +
#   geom_bar(position = "dodge")

## Change or inverse the x axis and y axis by 'coord_flip'
# ggplot(data = mpg, 
#        mapping = aes(x = class, y = displ))+
#   geom_boxplot()+
#   coord_flip()

## make polar chart like pie chart
# ggplot(data = diamonds, 
#        mapping = aes(x = cut, fill = cut)) + 
#   geom_bar(show.legend = FALSE,
#            width = 1)+
#   theme(aspect.ratio = 1)+
#   labs(x = NULL, y = NULL) + 
#   coord_polar()

## Set proportion or ratio of x to y axis by 'coord_fixed'
# ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
#   geom_point() +
#   geom_abline() + 
#   coord_fixed(ratio = 0.7)

## use geom_histogram to show continueous variables. 
## It devides the values into ranges and shows the number of
## items in each range
# ggplot(data = diamonds) + 
#   geom_histogram(mapping = aes(x = carat), binwidth = 0.5)
