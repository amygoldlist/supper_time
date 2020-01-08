
#####################################################
##
## This creates some functions that make a tasty random meal.
## And dessert for my kids!!
## Also this isn;t really finished.. it's a demo
##
#####################################################


library(tidyverse)
library(openxlsx)

## get the Excel file into R
food <- read.xlsx("../Data/Food_database.xlsx")



### Make a function that picks a random food row, with specifications:
get_food <- function(not_main = FALSE, not_veg="NA", not_side = "NA", not_des = TRUE ){
  ## I'm tired, so logic is opposite day
  food_sub <- food %>% 
    filter(!(Main == not_main),
           !(Veggie == not_veg),
           !(Side == not_side),
           !(Dessert== not_des)
    )
  
  i <- sample(1:length(food_sub[,1]), 1)
  #print(food_sub$Name[i])
  
  return(food_sub[i,])
}



## This builds a random supper with a main, side and veg.
## Note: some foods (like beef stew) are a complete meal.
## This is reflected in the funtion,  go Amy go!

random_supper <- function(){
  
  ## get a main course
  food_1 <- get_food(FALSE,"NA", "NA")
  
  #print(food_1$Name[1])
  
  if(food_1$Side & food_1$Veggie){
    print(paste("Dinner is ", food_1$Name[1]))
  }
  if(!food_1$Side & food_1$Veggie){
    print("We need a vegggie but not side")
    food_2 <- get_food(not_main =TRUE, not_veg=TRUE, not_side = FALSE)
    print(paste0("Dinner is ", food_1$Name[1], " and ", food_2$Name[1]))
  }
  
  if(food_1$Side & !food_1$Veggie){
    print("We need a side but not veggie")
    food_2 <- get_food(not_main =TRUE, not_veg=FALSE, not_side = TRUE)
    print(paste0("Dinner is ", food_1$Name[1], " and ", food_2$Name[1]))  
  }
  if(!food_1$Side & !food_1$Veggie){
    print("We need a veggie and a side")
    food_2 <- get_food(not_main=TRUE, not_veg = FALSE, not_side ="NA")
    if(food_1$Side){
      print(paste0("Dinner is ", food_1$Name[1], " and ", food_2$Name[1]))
    } else {
      food_3 <- get_food(not_main=TRUE, not_veg = TRUE, not_side =FALSE)
      print(paste0("Dinner is ", food_1$Name[1], ", ", food_2$Name[1], ", and", food_3$Name[1]))

    }
  }
  
}
  
## test your supper
random_supper()

## Pick a dessert
yummy_dessert <- function(){
  ## This exists because I have two kids looking over my shoulder.
  yum <- get_food(not_main = TRUE, not_veg = TRUE, not_side=TRUE, not_des = FALSE)
  print(paste0("Yummy!  Dessert for tonight will be", yum$Name[1]))
}

## Pick a yummy dessert.
yummy_dessert()



