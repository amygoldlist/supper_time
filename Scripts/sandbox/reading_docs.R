###########
##
##  This is a very specific script to extract info from my mom's collection of Word docs.
##  Luckily, my mom is super organized, so extrcacting the data is not too terrible



### open the correct library
library(antiword)
library(tidyverse)

#readtext("pancakes.doc")


pancakes <- antiword("Pancakes.doc")

#pancakes

split_cakes <- str_split(pancakes, "\r\n")[[1]]

##split_cakes[lapply(split_cakes,length)>0] 

##split_cakes

##str_locate(split_cakes[[1]],"Ingredients")

#?str_locate

###  This returns the number of WHERE Ingredients are
ingredient_index <- which(!is.na(str_locate(split_cakes,"Ingredients")[,1]))

###Next comes method
method_index <- which(!is.na(str_locate(split_cakes,"Method")[,1]))

i <- ingredient_index
#Ingredient_list <- while ()