# 8 Environments

#  Environments will teach you how R looks up and saves data sets and other R objects
#in its environment system. You’ll then use this knowledge to fix the deal and 
# shuffle functions.

# To fix these functions, you will need to learn how R stores, looks up, and manipulates 
# objects like deck. R does all of these things with the help of an environment system.

# 8.1 Environments

# You can see R’s environment system with the parenvs function in the pryr package

library(pryr)
parenvs(all = TRUE)


# Remember that this example is just a metaphor. R’s environments exist in your 
# RAM memory, and not in your file system. 

as.environment("package:stats")

# Three environments in your tree also come with their own accessor functions.

globalenv()

baseenv()

emptyenv()

# Next, you can look up an environment’s parent with parent.env:

parent.env(globalenv())

# Notice that the empty environment is the only R environment without a parent:

parent.env(emptyenv())

# You can view the objects saved in an environment with ls or ls.str. ls will 
# return just the object names, but ls.str will display a little about each object’s structure:

ls(emptyenv())

ls(globalenv())

# You can use R’s $ syntax to access an object in a specific environment. For example, you can 
# access deck from the global environment:

head(globalenv()$deck,3)

# And you can use the assign function to save an object into a particular environment. 
# First give assign the name of the new object (as a character string). Then give assign the
# value of the new object, and finally the environment to save the object in:

assign("new", "Hello Global", envir = globalenv())

globalenv()$new


# Now that you can explore R’s environment tree, let’s examine how R uses it. R works 
# closely with the environment tree to look up objects, store objects, and evaluate functions.
# How R does each of these tasks will depend on the current active environment.

# 8.2.1 The Active Environment

# You can use environment to see the current active environment:

environment()

# 8.3 Scoping Rules

# 1. R looks for objects in the current active environment.

# 2. When you work at the command line, the active environment is the global environment.
# Hence, R looks up objects that you call at the command line in the global environment.

# Here is a third rule that explains how R finds objects that are not in the active environment

# 3. When R does not find an object in an environment, R looks in the environment’s parent
# environment, then the parent of the parent, and so on, until R finds the object or reaches
# the empty environment.

# 8.4 Assignment

# R must save these temporary objects in the active environment; but if R does that, it may 
# overwrite existing objects. Function authors cannot guess ahead of time which names may 
# already exist in your active environment. How does R avoid this risk? Every time R runs 
# a function, it creates a new active environment to evaluate the function in.

# 8.5 Evaluation

# We’ll use the following function to explore R’s runtime environments. We want to know what 
# the environments look like: what are their parent environments, and what objects do they 
# contain? show_env is designed to tell us:

foo <- "take me to your runtime"

show_env <- function(x = foo){
  list(ran.in = environment(), 
       parent = parent.env(environment()), 
       objects = ls.str(environment()))
}
show_env()


# How can you use this knowledge to fix the deal and shuffle functions?

deal <- function() {
  card <- deck[1, ]
  assign("deck", deck[-1, ], envir = globalenv())
  card
}

deal()

# Let’s turn our attention to the shuffle function:

# 8.6 Closures

# But the system requires deck and DECK to exist in the global environment. 
# Lots of things happen in this environment, and it is possible that deck may get
# modified or erased by accident.

# You could create a function that takes deck as an argument and saves a copy of deck as DECK.
# The function could also save its own copies of deal and shuffle:  

setup <- function(deck) {
  DECK <- deck
  
  DEAL <- function() {
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = globalenv())
    card
  }
  
  SHUFFLE <- function(){
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = globalenv())
  }
  list(deal = DEAL, shuffle = SHUFFLE)
}

cards <- setup(deck)

# Then you can save each of the elements of the list to a 
# dedicated object in the global environment:

deal <- cards$deal
shuffle <- cards$shuffle

# Now you can run deal and shuffle just as before. Each object 
# contains the same code as the original deal and shuffle:  

deal

# This arrangement is called a closure. setup’s runtime environment “encloses” the deal
# and shuffle functions. Both deal and shuffle can work closely with the objects 
# contained in the enclosing environment, but almost nothing else can. The enclosing 
# environment is not on the search path for any other R function or environment.

# You may have noticed that deal and shuffle still update the deck object in the global 
# environment. Don’t worry, we’re about to change that. We want deal and shuffle to
# work exclusively with the objects in the parent (enclosing) environment of their 
# runtime environments. Instead of having each function reference the global environment
# to update deck, you can have them reference their parent environment at runtime, 

setup <- function(deck) {
  DECK <- deck
  
  DEAL <- function() {
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = parent.env(environment()))
    card
  }
  
  SHUFFLE <- function(){
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = parent.env(environment()))
  }
  
  list(deal = DEAL, shuffle = SHUFFLE)
}

cards <- setup(deck)
deal <- cards$deal
shuffle <- cards$shuffle

# 8.7 Summary

# As you become familiar with R’s environment system, you can use it to produce elegant
# results, like we did here. However, the real value of understanding the environment
# system comes from knowing how R functions do their job. You can use this knowledge
# to figure out what is going wrong when a function does not perform as expected.

































