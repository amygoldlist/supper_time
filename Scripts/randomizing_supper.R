
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

filename <- paste0("../meal_plans/meal_plan-", Sys.Date(), ".txt")



### Make a function that picks a random food row, with specifications:
get_food <- function(not_main = FALSE, not_veg="NA", not_side = "NA", not_des = TRUE,df = food ){
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

random_supper <- function(df =food){
  
  ### these need to be little baby dataframes.....
  food_1 <- food %>% filter(Name=="")
  food_2 <- food %>% filter(Name=="")
  food_3 <- food %>% filter(Name=="")
  
  
  ## get a main course
  food_1 <- get_food(FALSE,"NA", "NA", df = df)
  
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
    #print("We need a side but not veggie")
    food_2 <- get_food(not_main =TRUE, not_veg=FALSE, not_side = TRUE)
    print(paste0("Dinner is ", food_1$Name[1], " and ", food_2$Name[1]))  
  }
  if(!food_1$Side & !food_1$Veggie){
    #print("We need a veggie and a side")
    food_2 <- get_food(not_main=TRUE, not_veg = FALSE, not_side ="NA")
    if(food_1$Side){
      print(paste0("Dinner is ", food_1$Name[1], " and ", food_2$Name[1]))
    } else {
      food_3 <- get_food(not_main=TRUE, not_veg = TRUE, not_side =FALSE)
      print(paste0("Dinner is ", food_1$Name[1], ", ", food_2$Name[1], ", and ", food_3$Name[1]))

    }
  }
  
  new_df <- rbind(food_1, food_2, food_3)
  newer_df <- anti_join(food, new_df)
  

  return(newer_df)
}
  
## test your supper
amy <- random_supper()

## Pick a dessert
yummy_dessert <- function(){
  ## This exists because I have two kids looking over my shoulder.
  yum <- get_food(not_main = TRUE, not_veg = TRUE, not_side=TRUE, not_des = FALSE)
  print(paste0("Yummy!  Dessert for tonight will be ", yum$Name[1]))
}

## Pick a yummy dessert.
yummy_dessert()


get_meal_plan <- function(n=4, repeat_meals= FALSE, dessert = 2){
 ### this should generate n meals for the week
  ## It also should handle repeats, TBD
  
   new_df <- food
   for (i in 1:n){
    print(paste0("Meal ", i, ":"))
     if(repeat_meals){
       new_df <- random_supper(df=food)
       print("tacos every day!")
     }
     else
       {
         ##### THIS IS BUSTED????
       new_df <- random_supper(df=new_df)
       print("no repeats!!")
     }
   } 
   ## Also pick some desserts:
   
   print(paste0("Your ", dessert, " desserts are:"))
   for (i in 1:dessert){
     yummy_dessert()
   }
}

###Errrors:  REPEATS



###test:
sink(filename)
get_meal_plan()
sink()




