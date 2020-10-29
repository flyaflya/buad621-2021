library(tidyverse)

###let's see if Coors field is a "run-friendly" baseball park
browseURL("http://en.wikipedia.org/wiki/Coors_Field")


###the following line loads data from the 2010 - 2014 baseball seasons.  The following data gets loaded:
# Date      :     The date the baseball game was played
# Home      :     A three letter code indicating the "home" team
# Visitor   :     A three letter code indicating the "visiting" team
# HomeScore :     # of runs scored by the home team
# VisitorScore :  # of runs scored by the visiting team
###note: If HomeScore > VisitorScore, then the Home team wins the game.
###      If HomeScore < VisitorScore, then the Visitor team wins the game.
load("data/baseball.RData")   ###ensure this file is in your working directory

####Manipulate Data to Match Purpose
baseballData2 = baseballData %>% 
  mutate(totalRuns = HomeScore + VisitorScore) %>% 
  group_by(Home) %>% 
  summarise(avgRuns = mean(totalRuns)) %>% 
  arrange(desc(avgRuns))

### Let's choose our axes to be the two most important content features
### we do this via aesthetic mapping (see cheatsheet)
ggplot(data = baseballData2, 
       aes(x = Home, y = avgRuns))

## mapping points to aesthetic using plot default
## of x = Home and y = avgRund
ggplot(data = baseballData2, 
       aes(x = Home, y = avgRuns)) +
  geom_point()

ggplot(data = baseballData2) + ## mapping just for pts
  geom_point(aes(x = Home, y = avgRuns))  

###Change structure to highlight the differences
ggplot(data = baseballData2, 
       aes(x = Home, y = avgRuns)) +
  geom_col()

###Explore reversing the axes
###the x data is now vertical and the y data horizontal
ggplot(data = baseballData2, 
       aes(y = Home, x = avgRuns)) +
  geom_col()

###Highlight Coors Field - need data first!!
###This is a common recipe.  If you want to map a visual
###element to data, you often have to create the data
baseballData3 = baseballData2 %>% 
  mutate(CoorsField = ifelse(Home == "COL",
                             "Coors Field",
                             "Other Stadium"))

### then map data to a plot aesthetic
ggplot(data = baseballData3,
       aes(x = avgRuns,
           y = Home,
           fill = CoorsField)) +
  geom_col()

### Notice Home is a factor
### R uses factors to handle categorical variables, 
### variables that have a fixed and 
### known set of possible values. 
### I try to avoid these in favor of character strings/vectors
### when plotting though, it is nice to control the order 
### of levels - use forcats package (part of tidyverse)

## two most important functions
## forcats::fct_reorder()
##           Reordering a factor by another variable
ggplot(data = baseballData3, 
       aes(x = avgRuns,
           y = fct_reorder(Home,avgRuns), ##use fct_reorder()
           fill = CoorsField)) + 
  geom_col()



###to take control of how data is mapped to the visual aesthetic
###USE SCALES ... you will need to use google as your friend
## for specific inquiries (e.g. see http://www.cookbook-r.com/Graphs/)
ggplot(data = baseballData3, 
       aes(x = avgRuns,
           y = fct_reorder(Home,avgRuns), ##use fct_reorder()
           fill = CoorsField)) + 
  geom_col() +
  scale_fill_manual(values = c("purple","gray")) 

### save the last plot as an object
myPlot = last_plot()  ##ggplot function to get last plot made

myPlot + 
  labs(title = "How Run Friendly is Colorado's Coors Field?",
       x = "Ballpark",
       y = "Avergage Number of Runs Per Game") 

myPlot2 = last_plot()

#### CLASS EXERCISE:  a skeptical investigator claims that
#### Colorado's team is the reason for the high runs in that
#### park.  To investigate this, look at the average runs
#### scored by the visiting team only (i.e. exclude the home team).  Create a plot to share on ZOOM.


