###########
##
##  This is a very specific script to extract info from my mom's collection of Word docs.
##  Luckily, my mom is super organized, so extrcacting the data is not too terrible
##
###########


### open the correct libraries.  Antiword opens "doc" files
library(antiword)
library(tidyverse)


### Make a function that reads in a single file.
## THEN, I can read in all the files at once!  Like a Pro!



read_mom_word_doc <- function(filename) {
  
  
  ## read in the file
  pancakes <- antiword(filename)
  
  ## create a list by breaking on return keys and trimming white space at begining and end
  recipe_list <- str_split(pancakes, "\r\n")[[1]] %>% 
    str_trim()
  
  ## cut out any line that's blank.
  recipe_list <- recipe_list[lapply(recipe_list,nchar)>0] 
  
  recipe_name <- recipe_list[1]
  
  if (recipe_list[2]=="Ingredients"){
    recipe_subtitle <- ""
  } else {
    recipe_subtitle <- recipe_list[2]
  }
  
  ## How long is my list?
  n <- length(recipe_list)
  
  
  ###  This returns the number of WHERE teh headings are
  ingredient_index <- which(!is.na(str_locate(recipe_list,"Ingredients")[,1]))
  method_index <- which(!is.na(str_locate(recipe_list,"Method")[,1]))
  variation_index <- which(!is.na(str_locate(recipe_list,"Variations:")[,1]))
  nutrition_index <- which(!is.na(str_locate(recipe_list,"Nutritional Information:")[,1]))
  source_index <- which(!is.na(str_locate(recipe_list,"Source:")[,1]))
  notes_index <- which(!is.na(str_locate(recipe_list,"Notes:")[,1]))
  
  
  ## TO DO
  ## if variation_index == NA, make it equal to n
  

  ## create a list of ingredients
  ingredient_list <- c()
  for (i in (ingredient_index+1):(method_index-1)){
    
    ingredient_list <- append(ingredient_list, recipe_list[i])
  }
  
  
  ## create a list for the method
  method <- c()
  for (i in (method_index+1):(variation_index-1)){
    
    method <- append(method, recipe_list[i])
  }
  
  
  ### do other stuff
  
  ### Save as Rdat for now, but if I really want to use Python, I should switch this to JSON
  
  new_recipe <- list(recipe_name = recipe_name, subtitle =recipe_subtitle, ingredients=ingredient_list, method =method)
  
  return(new_recipe)
  
}

## test: 

pancake_recipe <- read_mom_word_doc("../Recipes/Pancakes.doc")


