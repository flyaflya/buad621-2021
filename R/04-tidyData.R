### demonstrate pivot_longer (formerly gather())
### and pivot_wider() (formerly spread())
library(tidyverse)

df = tibble(orderID = c(1,2,3,4,5),
            freshSales = c(10,12,13,9,11),
            cannedSales = c(5,8,3,7,4),
            pharmSales = c(6,7,8,9,10),
            paperSales = c(9,4,7,2,2))

## tidy data - each row an observation
## each column a measurement from that observation
## unit of observation depends on context
## df is good if unit of observation is an order

## data is often non-tidy for readability
df  ## non-tidy data ... easy to read
## non-tidy is a pain to plot
df %>% 
  ggplot(aes(x = orderID)) +
  geom_col(aes(y = freshSales), fill = "red") +
  geom_col(aes(y = cannedSales)) +
  geom_col(aes(y = pharmSales)) +
  geom_col(aes(y = paperSales))

## my rule of thumb - is that no two columns
## should have the same unit of measure
## currently 5 columns have $ as uom
## to make tidy, use 5 column names as "names"
## and the measurement of each as a "value"
df %>%
  pivot_longer(freshSales:paperSales)

## take control of new column names
tidyDF = df %>%
  pivot_longer(freshSales:paperSales,
               names_to = "prodCategory",
               values_to = "dollarSales")
## even though less readable, tidyverse likes this
## format.  

## Example:
tidyDF %>%
  ggplot() +
  geom_col(aes(x = orderID,
               y = dollarSales,
               fill = prodCategory))

## get back to orginal
tidyDF ## see tidy

## make non-tidy
tidyDF %>%
  pivot_wider(id_cols = orderID,
              names_from = prodCategory,
              values_from = dollarSales)


