#welcome all 
##scalar objects in R
a<-12
a
## creating matrix in R
ab<-matrix(1:9, nrow = 3)
ab
ac<-matrix(1:6, ncol = 2)
ac
#using cbind to join two matrix together
ad<-cbind(ab,ac)
ad

##saving as a dataframe
aq<-as.data.frame(ad)
aq

names(aq)<-c("x1","x2","x3","x4","x5")
View(aq)


size<-c(1,2,2,3,4,5,6,7)
weight<-c(1,2,3,5,6,7,8,4)
mouse.data<-data.frame(size,weight)
tibble(size,weight)
mouse.data

## using tidyr
library(tidyr)
mouse<-as_tibble(mouse.data)
mouse

##dealing with missing values
# Fill in missing values with previous or next value
sasmu_data <- read_csv("sasmu_data.csv")
sasmu_data


# `fill()` defaults to replacing missing data from top to bottom
sasmu_data %>% fill(year)

#another example but using characters
sasmu_data2 <- read_csv("sasmu_data2.csv")
sasmu_data2

# another `fill()` defaults to replacing missing data from top to bottom
sasmu_data2 %>% fill(`pet type`)
sasmu_data2 %>% fill(`pet type`, .direction="up")

#full_seq() used to Create the full sequence of values in a vector
#if you want to fill in missing values that should have been observed but weren't.
full_seq(c(1, 2, 4, 5, 10), 1)
full_seq(c(1,2,4,6),1)

##gather()
##gather() used to gather columns into key-value pairs.
stocks <- tibble(time = as.Date('2022-01-01') + 0:30, 
                 X = rnorm(31, 0, 1),
                 Y = rnorm(31, 0, 2), Z = rnorm(31, 0, 4))
stocks
gathered<-gather(stocks, "stock", "price", -time)
view(gathered)
stocks %>% gather("stock", "price", -time)

#using a real example of data on iris
data("iris")
iris
view(iris)
gather(iris, key = "flower_att", value = "measurement",
       Sepal.Length, Sepal.Width, Petal.Length, Petal.Width)


iris %>% gather(key = "flower_att", value = "measurement", -Species)

## using chop() in tidyr
mouse %>% chop(c(size))

#unchop()
mouse.data%>% unchop(size)

library(tidyverse)
library(dplyr)
df <- tibble(
  group = c(1:2, 1, 2),
  item_id = c(1:2, 2, 3),
  item_name = c("a", "a", "b", "b"),
  value1 = c(1, NA, 3, 4),
  value2 = 4:7)
df

#using Complete()
##Give all possible combination of group,item_id,item_name
complete(df, group, item_id, item_name)

# Cross all possible `group` values with the unique pairs of
# `(item_id, item_name)` that already exist in the data
complete(df, group, nesting(item_id, item_name))


#drop_na() drops rows where any column specified by contains a missing value.
drop_na(df)
df %>% drop_na()

#dropping rows based on the specification of columns
df <- tibble(x = c(1, 2, NA), y = c("a", NA, "b"))
df
df %>% drop_na()
#dropping values based on x attribute
df %>% drop_na(x)

#dropping values based on y attribute
df %>% drop_na(y)

##expand() generates all combination of variables found in a dataset.
#crossing() is a wrapper around expand_grid() that de-duplicates and sorts its inputs; 
#nesting() is a helper that only finds combinations already present in the data.

fruits <- tibble(type = c("apple", "orange", "apple", "orange", "orange", "orange"),
                 year = c(2010, 2010, 2012, 2010, 2011, 2012),
                 size = factor(c("XS", "S", "M", "S", "S", "M"),
                               levels = c("XS", "S", "M", "L")),weights = rnorm(6, as.numeric(size) + 2))
fruits

# All possible combinations fruits, not necessarily present in the dataset
fruits %>% expand(type)
fruits %>% expand(type,size)
fruits %>% expand(type, size, year)

# Only combinations that already appear in the data
fruits %>% expand(nesting(type))
fruits %>% expand(nesting(type, size))
fruits %>% expand(nesting(type, size, year))

# Use with `full_seq()` to fill in values of continuous variables
fruits %>% expand(type, size, full_seq(year, 1))
fruits %>% expand(type, size, 2010:2013)

#using expand_grid()  Returns a tibble, not a data frame.
expand_grid(x = 1:4, y = 1:3)
expand_grid(l1 = letters, l2 = LETTERS)
# Can also expand data frames
