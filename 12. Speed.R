# 12 Speed

# As a data scientist, you need speed. You can work with bigger data and do more ambitious
# tasks when your code runs fast. This chapter will show you a specific way to write 
# fast code in R. You will then use the method to simulate 10 million plays of your slot machine.

# 12.1 Vectorized Code

# You can write a piece of code in many different ways, but the fastest R code will usually take
# advantage of three things: logical tests, subsetting, and element-wise execution. These are 
# the things that R does best. Code that uses these things usually has a certain quality: it is
# vectorized; the code can take a vector of values as input and manipulate each value in the 
# vector at the same time.

# To see what vectorized code looks like, compare these two examples of an absolute value 
# function. Each takes a vector of numbers and transforms it into a vector of absolute values
# (e.g., positive numbers). The first example is not vectorized; abs_loop uses a for loop to
# manipulate each element of the vector one at a time:

abs_loop <- function(vec){
  for (i in 1:length(vec)) {
    if (vec[i] < 0) {
      vec[i] <- -vec[i]
    }
  }
  vec
}

# The second example, abs_set, is a vectorized version of abs_loop. It uses logical subsetting
# to manipulate every negative number in the vector at the same time:

abs_sets <- function(vec){
  negs <- vec < 0
  vec[negs] <- vec[negs] * -1
  vec
}

# You can use the system.time function to see just how fast abs_set is. system.time takes an R 
# expression, runs it, and then displays how much time elapsed while the expression ran.

long <- rep(c(-1, 1), 5000000)

system.time(abs_loop(long))
# user  system elapsed 
# 0.706   0.022   0.730 

system.time(abs_sets(long))
# user  system elapsed 
# 0.217   0.038   0.261

# Don’t confuse system.time with Sys.time, which returns the current time.

system.time(abs(long))
#   user  system elapsed 
# 0.015   0.000   0.014 

# 12.2 How to Write Vectorized Code

# Vectorized code is easy to write in R because most R functions are already vectorized. 
# Code based on these functions can easily be made vectorized and therefore fast. To 
# create vectorized code:

# 1. Use vectorized functions to complete the sequential steps in your program.
# 2. Use logical subsetting to handle parallel cases. Try to manipulate every element in
# a case at once.

# Exercise 12.2 (Vectorize a Function) The following function converts a vector of slot 
# symbols to a vector of new slot symbols. Can you vectorize it? How much faster does the
# vectorized version work?

change_symbols <- function(vec){
  for (i in 1:length(vec)){
    if (vec[i] == "DD") {
      vec[i] <- "joker"
    } else if (vec[i] == "C") {
      vec[i] <- "ace"
    } else if (vec[i] == "7") {
      vec[i] <- "king"
    }else if (vec[i] == "B") {
      vec[i] <- "queen"
    } else if (vec[i] == "BB") {
      vec[i] <- "jack"
    } else if (vec[i] == "BBB") {
      vec[i] <- "ten"
    } else {
      vec[i] <- "nine"
    } 
  }
  vec
}

vec <- c("DD", "C", "7", "B", "BB", "BBB", "0")

change_symbols(vec)


many <- rep(vec, 1000000)

system.time(change_symbols(many))

# user  system elapsed 
# 8.600   0.040   8.672 

# To vectorize change_symbols, create a logical test that can identify each case:

change_vec <- function (vec) {
  vec[vec == "DD"] <- "joker"
  vec[vec == "C"] <- "ace"
  vec[vec == "7"] <- "king"
  vec[vec == "B"] <- "queen"
  vec[vec == "BB"] <- "jack"
  vec[vec == "BBB"] <- "ten"
  vec[vec == "0"] <- "nine"
  
  vec
}

system.time(change_vec(many))

# user  system elapsed 
# 0.480   0.045   0.526 


# Or, even better, use a lookup table. Lookup tables are a vectorized method because they 
# rely on R’s vectorized selection operations:

change_vec2 <- function(vec){
  tb <- c("DD" = "joker", "C" = "ace", "7" = "king", "B" = "queen", 
          "BB" = "jack", "BBB" = "ten", "0" = "nine")
  unname(tb[vec])
}

system.time(change_vec(many))
# user  system elapsed 
# 0.349   0.018   0.366

# Here, a lookup table is 23 times faster than the original function.

# 12.3 How to Write Fast for Loops in R

# You can dramatically increase the speed of your for loops by doing two things to optimize
# each loop. First, do as much as you can outside of the for loop. Every line of code that 
# you place inside of the for loop will be run many, many times. If a line of code only needs
# to be run once, place it outside of the loop to avoid repetition.

# Second, make sure that any storage objects that you use with the loop are large enough to 
# contain all of the results of the loop. For example, both loops below will need to store 
# one million values. The first loop stores its values in an object named output that begins 
# with a length of one million:

system.time({
  output <- rep(NA, 1000000) 
  for (i in 1:1000000) {
    output[i] <- i + 1
  }
})
##   user  system elapsed 
##  0.053   0.004   0.060 

system.time({
  output <- NA 
  for (i in 1:1000000) {
    output[i] <- i + 1
  }
})
##  user   system  elapsed 
## 0.275   0.058   0.337

# In the first case, the size of output never changes; R can define one output object in memory
# and use it for each run of the for loop.

# 12.4 Vectorized Code in Practice


  
  








