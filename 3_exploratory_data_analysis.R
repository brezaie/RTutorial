## Two importan questions for data analysis:
## 1. What type of variation occurs within my variables?
## 2. What type of covariation occurs between my variables?

## Get the ranges of a contineous variable by 'cut_width'
diamonds %>% count(cut_width(carat, 0.5))

## Limitation on y axis
# ggplot(diamonds) + 
#   geom_histogram(mapping = aes(x = y), binwidth = 0.5) + 
#   coord_cartesian(ylim = c(0, 50))

ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) + 
  ylim(0, 50)
