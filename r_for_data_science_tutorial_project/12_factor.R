install.packages('forcats')
library(forcats)

## Create a factor:
x1 <- c("Dec", "Apr", "Jan", "Mar")
month_levels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
                  )
y1 <- factor(x1, levels = month_levels)
sort(y1)

## Create factor's order as they enter:
f1 <- factor(x1, levels = unique(x1))
sort(f1)

## Dataset:
gss_cat
gss_cat %>% 
  count(race)
gss_cat %>%
  group_by(rincome) %>%
  summarise(Count = n()) %>%
  ggplot(mapping = aes(x = reorder(rincome, Count), y = Count)) +
  geom_bar(stat = "identity") +
  coord_flip()

## IMPORTANT: Reorder the factors by values:
## explore the average number of hours spent watching TV per day across religions
## Unordered plot:
relig <- gss_cat %>%
  group_by(relig) %>%
  summarize(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )
ggplot(relig, aes(tvhours, relig)) + geom_point()
## Ordered plot uses 'fct_reorder' function
ggplot(relig, aes(tvhours, fct_reorder(relig, tvhours))) +
  geom_point()

## Opposite of 'fct_reorder' is 'fxt_relevel'
## It orders the plot according to the level ordering.
## We should mention the start of the order:
income <- gss_cat %>%
  group_by(rincome) %>%
  summarise(
    age = mean(age, na.rm = TRUE)
  )
ggplot(income, 
       aes(age, fct_relevel(rincome, 'Not applicable'))
      ) + 
  geom_point()

## fct_reorder2(): reorders the factor by the y values 
##       associated with the largest x values. It is useful for coloring
by_age <- gss_cat %>%
  filter(!is.na(age)) %>%
  count(age, marital) %>%
  group_by(age) %>%
  mutate(prop = n / sum(n))
ggplot(by_age, aes(age, prop, colour = fct_reorder2(marital, age, prop))) +
  geom_line() +
  labs(colour = "marital")

## fct_infreq(): reorder the factors 
gss_cat %>%
  mutate(marital = marital %>% fct_infreq() %>% fct_rev()) %>%
  ggplot(aes(marital)) +
  geom_bar()

## rename the factors by 'fct_recode'
gss_cat %>%
  mutate(partyid = fct_recode(partyid, 
                              "Republican, strong" = "Strong republican",
                              "Republican, weak" = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak" = "Not str democrat",
                              "Democrat, strong" = "Strong democrat"
                    )) %>%
  count(partyid)

## Rename a group of factors into a single factor:
gss_cat %>%
  mutate(partyid, fct_collapse(partyid,
                      other = c("No answer", "Don't know", "Other party"),
                      rep = c("Strong republican", "Not str republican"),
                      ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                      dem = c("Not str democrat", "Strong democrat")
        )) %>%
  count(partyid)

gss_cat %>%
  count(relig)
