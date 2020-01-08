###method 1:  set up as a dictionary

import random

##set up some items

fish_stew = {"name" : "fish stew",
    "ingredients":["fish", "white wine", "shrimp", "canned tomatoes", "garlic"],
            "active_time": 20,
            "passive_time": 0}

sausage = {"name" : "sausage with rice and green veg",
    "ingredients":["sausage", "rice", "green veggie"],
            "active_time": 10,
            "passive_time": 40}

pasta_meat = {"name" : "Spaghetti with meat sauce",
    "ingredients":["ground beef", "canned tomatoes", "garlic", "onion", "tomato sauce", "tomato paste", "pasta"],
            "active_time": 20,
            "passive_time": 10}

## create a list of meals

meal_list = {"fish stew":fish_stew,
             "sausage": sausage,
            "pasta_meat":pasta_meat}

## pick a random meal
supper = random.choice(list(meal_list.keys()))
print("Supper is", meal_list[supper]["name"])

print("Grocery List:", meal_list[supper]["ingredients"])

print("It will take", meal_list[supper]["active_time"]+ meal_list[supper]["passive_time"], "minutes", "but only",
      meal_list[supper]["active_time"], "is active."  )
