Plot Saving
================
Behzad
July 29, 2019

This tutorial shows the way to output a plot properly by the following attributes:

**fig.width = 6**

**fig.align='center'**

**out.width="70%"**

**fig.show='hold'**: When mingling code and text, like I do in this book, I recommend setting fig.show = "hold" so that plots are shown after the code.

``` r
library(dplyr)
library(ggplot2)
mpg %>% ggplot(aes(displ, hwy)) + 
  geom_point(aes(color = class)) + 
  geom_smooth(se = FALSE)
```

<img src="22_plot_saving_files/figure-markdown_github/plot_savin-1.png" width="70%" style="display: block; margin: auto;" />
