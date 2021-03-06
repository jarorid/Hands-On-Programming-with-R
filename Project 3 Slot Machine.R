# Project 3: Slot Machine

# Slot machines are the most popular game in modern casinos. If you’ve never seen one,
# a slot machine resembles an arcade game that has a lever on its side. For a small
# fee you can pull the lever, and the machine will generate a random combination of three
# symbols. If the correct combination appears, you can win a prize, maybe even the jackpot.

# This project will teach you how to write programs and run simulations in R. You will 
# also learn how to:

# Use a practical strategy to design programs
# Use if and else statements to tell R what to do when
# Create lookup tables to find values
# Use for, while, and repeat loops to automate repetitive operations
# Use S3 methods, R’s version of Object-Oriented Programming
# Measure the speed of R code
# Write fast, vectorized R code

# 9 Programs

# The first step is easy to simulate. You can randomly generate three symbols with the sample
# function—just like you randomly “rolled” two dice in Project 1: Weighted Dice.
# The following function generates three symbols from a group of common slot machine symbols:
# diamonds (DD), sevens (7), triple bars (BBB), double bars (BB), single bars (B), 
# cherries (C), and zeroes (0). The symbols are selected randomly, and each symbol 
# appears with a different probability:

get_symbols <- function(){
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  sample(wheel, size = 3, replace = TRUE, 
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}


get_symbols()

# For example, a player who rolls 7 7 DD would earn a prize for getting three sevens. 
# There is one exception to this rule, however: a diamond cannot be considered a cherry
# unless the player also gets one real cherry. This prevents a dud roll like, 0 DD 0 
# sfrom being scored as 0 C 0.

# Diamonds are also special in another way. Every diamond that appears in a combination 
# doubles the amount of the final prize. So 7 7 DD would actually be scored higher than 
# 7 7 7. Three sevens would earn you $80, but two sevens and a diamond would earn you 
# $160. One seven and two diamonds would be even better, resulting in a prize that has 
# been doubled twice, or $320. A jackpot occurs when a player rolls DD DD DD. Then a 
# player earns $100 doubled three times, which is $800.

# Each play of the slot machine costs $1. A player’s symbols determine how much they win. 
# Diamonds (DD) are wild, and each diamond doubles the final prize. * = any symbol.

# Combination	Prize($)
# DD DD DD	100
# 7 7 7	80
# BBB BBB BBB	40
# BB BB BB	25
# B B B	10
# C C C	10
# Any combination of bars	5
# C C *	5
# C * C	5
# * C C	5
# C * *	2
# * C *	2
# * * C	2


# The print command prints its output to the console window, which makes print a useful
# way to display messages from within the body of a function.

# 9.1 Strategy

# Scoring slot-machine results is a complex task that will require a complex algorithm.
# You can make this, and other coding tasks, easier by using a simple strategy:
  
# Break complex tasks into simple subtasks.
# Use concrete examples.
# Describe your solutions in English, then convert them to R.
# Let’s start by looking at how you can divide a program into subtasks that are simple
# to work with.

# R programs contain two types of subtasks: sequential steps and parallel cases.

# 9.1.1 Sequential Steps

play <- function() {
  
  # step 1: generate symbols
  symbols <- get_symbols()
  
  # step 2: display the symbols
  print(symbols)
  
  # step 3: score the symbols
  score(symbols)
}

# 9.1.2 Parallel Cases

# Another way to divide a task is to spot groups of similar cases within the task. Some tasks
# require different algorithms for different groups of input. If you can identify those groups,
# you can work out their algorithms one at a time.

# 9.2 if Statements

# An if statement tells R to do a certain task for a certain case. In English you would say 
# something like, “If this is true, do that.” In R, you would say:

# if (this) {
#   that
# }

# The condition of an if statement must evaluate to a single TRUE or FALSE. If the condition 
# creates a vector of TRUEs and FALSEs (which is easier to make than you may think), your if
# statement will print a warning message and use only the first element of the vector. 
# Remember that you can condense vectors of logical values to a single TRUE or FALSE with the
# functions any and all.

# 9.3 else Statements

# if statements tell R what to do when your condition is true, but you can also tell R what
# to do when the condition is false. else is a counterpart to if that extends an if statement
# to include a second case. In English, you would say, “If this is true, do plan A; else do
# plan B.” In R, you would say:
  
# if (this) {
#    Plan A
#  } else {
#    Plan B
#  }

# If your situation has more than two mutually exclusive cases, you can string multiple if and
# else statements together by adding a new if statement immediately after else. For example:

a <- 1
b <- 1

if (a > b) {
  print("A wins!")
} else if (a < b) {
  print("B wins!")
} else {
  print("Tie.")
}


# You can use if and else to link the subtasks in your slot-machine function. Open a fresh R 
# script, and copy this code into it. The code will be the skeleton of our final score function.



symbols <- get_symbols()

symbols

# && and || behave like & and | but can sometimes be more efficient. The double operators will
# not evaluate the second test in a pair of tests if the first test makes the result clear. 
# For example, if symbols[1] does not equal symbols[2] in the next expression, && will not 
# evaluate symbols[2] == symbols[3]; it can immediately return a FALSE for the whole expression
# (because FALSE & TRUE and FALSE & FALSE both evaluate to FALSE). This efficiency can speed 
# up your programs; however, double operators are not appropriate everywhere. && and || are not
# vectorized, which means they can only handle a single logical test on each side of the operator.

# 9.4 Lookup Tables

# Very often in R, the simplest way to do something will involve subsetting. How could you use
# subsetting here? Since you know the exact relationship between the symbols and their prizes,
# you can create a vector that captures this information. This vector can store symbols as names
# and prize values as elements:

payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25, 
             "B" = 10, "C" = 10, "0" = 0)

payouts["DD"]

# If you want to leave behind the symbol’s name when subsetting, you can run the unname function
# on the output:

unname(payouts["DD"])

# You won’t be able to replace every if tree with a lookup table, nor should you. However, you
# can usually use lookup tables to avoid assigning variables with if trees. As a general rule,
# use an if tree if each branch of the tree runs different code. Use a lookup table if each 
# branch of the tree only assigns a different value.

# 10 S3

# 10.1 The S3 System

# R’s S3 system is built around three components: attributes (especially the class attribute),
# generic functions, and methods.

# 10.2 Attributes

# In Attributes, you learned that many R objects come with attributes, pieces of extra 
# information that are given a name and appended to the object. Attributes do not affect the
# values of the object, but stick to the object as a type of metadata that R can use to handle 
# the object. For example, a data frame stores its row and column names as attributes. 
# Data frames also store their class, "data.frame", as an attribute.

# R comes with many helper functions that let you set and access the most common attributes 
# used in R. You’ve already met the names, dim, and class functions, which each work with an
# eponymously named attribute. However, R also has row.names, levels, and many other 
# attribute-based helper functions. You can use any of these functions to retrieve an 
# attribute’s value:

# You can add any general attribute to an object with attr; you can also use attr to look up
# the value of any attribute of an object. Let’s see how this works with one_play, the result
# of playing our slot machine one time:

play <- function() {
  symbols <- get_symbols()
  print(symbols)
  score(symbols)
}

one_play <- play()

attributes(one_play)

# attr takes two arguments: an R object and the name of an attribute (as a character string).
# To give the R object an attribute of the specified name, save a value to the output of attr.
# Let’s give one_play an attribute named symbols that contains a vector of character strings:

attr(one_play, "symbols") <- c("B", "0", "B")

attributes(one_play)

# Exercise 10.1 (Add an Attribute) Modify play to return a prize that contains the symbols 
# associated with it as an attribute named symbols. Remove the redundant call to print(symbols):

play <- function() {
  symbols <- get_symbols()
  prize <- score(symbols)
  attr(prize,"symbols") <- symbols
  prize
}
  
play()

two_play <- play()

two_play

attr(play,"simbols") <- get_symbols()

# You can also generate a prize and set its attributes in one step with the structure function. 
# structure creates an object with a set of attributes. 

play <- function() {
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols)
}

three_play <- play()
three_play

slot_display <- function(prize){
  
  # extract symbols
  symbols <- attr(prize, "symbols")
  
  # collapse symbols into single string
  symbols <- paste(symbols, collapse = " ")
  
  # combine symbol with prize as a character string
  # \n is special escape sequence for a new line (i.e. return or enter)
  string <- paste(symbols, prize, sep = "\n$")
  
  # display character string in console without quotes
  cat(string)
}

slot_display(one_play)

# The last line of slot_display calls cat on the new string. cat is like print; 
# it displays its input at the command line. However, cat does not surround its output 
# with quotation marks. cat also replaces every \n with a new line or line break. The 
# result is what we see.

# You can use slot_display to manually clean up the output of play:

slot_display(play())

# 10.3 Generic Functions

# R calls print each time it displays a result in your console window.

print(pi)


# 10.4 Methods

methods(print)

# 10.4.1 Method Dispatch

# When UseMethod needs to call a method, it searches for an R function with the correct 
# S3-style name. The function does not have to be special in any way; it just needs to 
# have the correct name.

# 10.5 Classes

methods(class = "factor")

# 10.6 S3 and Debugging

# S3 can be annoying if you are trying to understand R functions. It is difficult to tell
# what a function does if its code body contains a call to UseMethod. Now that you know
# that UseMethod calls a class-specific method, you can search for and examine the method
# directly. It will be a function whose name follows the <function.class> syntax, or possibly
# <function.default>. You can also use the methods function to see what methods are associated
# with a function or a class.

# R’s S3 system is more helpful for the tasks of computer science than the tasks of data science,
# but understanding S3 can help you troubleshoot your work in R as a data scientist.

# 11 Loops

# 11.1 Expected Values

# The expected value of a random event is a type of weighted average; it is the sum of each 
# possible outcome of the event, weighted by the probability that each outcome occurs

# Notice that we did the same three things to calculate both of these expected values. We have:

# Listed out all of the possible outcomes
# Determined the value of each outcome (here just the value of the die)
# Calculated the probability that each outcome occurred

# 11.2 expand.grid

# The expand.grid function in R provides a quick way to write out every combination of the
# elements in n vectors. For example, you can list every combination of two dice. To do so, 
# run expand.grid on two copies of die:

rolls <- expand.grid(die,die)
rolls

# You can determine the value of each roll once you’ve made your list of outcomes. This will
# be the sum of the two dice, which you can calculate using R’s element-wise execution:

rolls$value <- rolls$Var1 + rolls$Var2
head(rolls)

# The probability that n independent, random events all occur is equal to the product of the
# probabilities that each random event occurs.

prob <- c("1" = 1/8, "2" = 1/8, "3" = 1/8, "4" = 1/8, "5" = 1/8, "6" = 3/8)

# If you subset this table by rolls$Var1, you will get a vector of probabilities perfectly 
# keyed to the values of Var1:

# First, we can look up the probabilities of rolling the values in Var1:
rolls$Var1
prob[rolls$Var1]
rolls$prob1 <- prob[rolls$Var1]
# Second, we can look up the probabilities of rolling the values in Var2:
rolls$prob2 <- prob[rolls$Var2]
# Third, we can calculate the probability of rolling each combination by
# multiplying prob1 by prob2:
rolls$prob <- rolls$prob1 * rolls$prob2
head(rolls)

# It is easy to calculate the expected value now that we have each outcome, the value of each
# outcome, and the probability of each outcome. The expected value will be the summation of 
# the dice values multiplied by the dice probabilities:

sum(rolls$value*rolls$prob)

# If you are curious, the expected value of rolling a pair of fair dice is 7, which explains 
# why 7 plays such a large role in dice games like craps.

rolls_fair <- expand.grid(die,die)
rolls_fair
prob_fair <- c(1/6,1/6,1/6,1/6,1/6,1/6)
rolls_fair$value <- rolls_fair$Var1 + rolls_fair$Var2
rolls_fair$prob1 <- prob_fair[rolls_fair$Var1]
rolls_fair$prob2 <- prob_fair[rolls_fair$Var2]
rolls_fair$prob <- rolls_fair$prob1 * rolls_fair$prob2
head(rolls_fair)
# Expected value
sum(rolls_fair$value*rolls_fair$prob)
# Roll Probability roll equal seven
sum(rolls_fair$prob[rolls_fair$value == 7])

# Now that you’ve warmed up, let’s use our method to calculate the expected value of the slot
# machine prize.

machine <- expand.grid(symbols, symbols, symbols)
prob_machine <- c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52)
machine$prob1 <- prob_machine[machine$Var1]
machine$prob2 <- prob_machine[machine$Var2]
machine$prob3 <- prob_machine[machine$Var3]
machine$prob <- machine$prob1 * machine$prob2 * machine$prob3
#machine$prize <- score(machine[c(1:3)])
head(machine)

score(get_symbols())

head(machine[c(1:3)])

# Solution book version 

combos <- expand.grid(wheel, wheel, wheel, stringsAsFactors = FALSE)
prob <- c("DD" = 0.03, "7" = 0.03, "BBB" = 0.06, 
          "BB" = 0.1, "B" = 0.25, "C" = 0.01, "0" = 0.52)
combos$prob1 <- prob[combos$Var1]
combos$prob2 <- prob[combos$Var2]
combos$prob3 <- prob[combos$Var3]
combos$prob <- combos$prob1 * combos$prob2 * combos$prob3
head(combos)
# The sum of the probabilities is one, which suggests that our math is correct:
sum(combos$prob)
# Let’s use a for loop to calculate the prize for each row in combos. To begin, 
# create a new column in combos to store the results of the for loop:

combos$prize <- NA

for (i in 1:nrow(combos)){
  symbols <- c(combos[i,1],combos[i,2], combos[i,3])
  combos$prize[i] <- score(symbols)
}

head(combos)

# We’re now ready to calculate the expected value of the prize. The expected value is the
# sum of combos$prize weighted by combos$prob. This is also the payout rate of the slot machine:

sum(combos$prize * combos$prob)

# We’re now ready to calculate the expected value of the prize. The expected value is the
# sum of combos$prize weighted by combos$prob. This is also the payout rate of the slot machine:

score <- function (symbols) {
# Identify case
same <- symbols[1] == symbols[2] && symbols[1] == symbols[3]
bars <- symbols %in% c("B", "BBB", "BB")

# You only need to do one more thing before you can calculate the expected value: you must
# determine the prize for each combination in combos. You can calculate the prize with score.
# For example, we can calculate the prize for the first row of combos like this:

symbols <- c(combos[1, 1], combos[1, 2], combos[1, 3])
symbols

score(symbols)

# However there are 343 rows, which makes for tedious work if you plan to calculate the scores
# manually. It will be quicker to automate this task and have R do it for you, which you can
# do with a for loop.

# 11.3 for Loops

# A for loop repeats a chunk of code many times, once for each element in a set of input. for
# loops provide a way to tell R, “Do this for every value of that.” In R syntax, this looks like:
  
#  for (value in that) {
#    this
#  }

# Choose your symbols carefully

# R will run your loop in whichever environment you call it from. This is bad news if your loop
# uses object names that already exist in the environment. Your loop will overwrite the existing
# objects with the objects that it creates. This applies to the value symbol as well.

# 11.4 while Loops

# R has two companions to the for loop: the while loop and the repeat loop. A while loop reruns
# a chunk while a certain condition remains TRUE. To create a while loop, follow while by a 
# condition and a chunk of code, like this:

# while (condition) {
#   code
# }

plays_till_broke <- function(start_with) {
  cash <- start_with
  n <- 0
  while (cash > 0) {
    cash <- cash - 1 + play()
    n <- n + 1
  }
  n
}

plays_till_broke(100)

# 11.5 repeat Loops

# repeat loops are even more basic than while loops. They will repeat a chunk of code until
# you tell them to stop (by hitting Escape) or until they encounter the command break, 
# which will stop the loop.


plays_till_broke <- function(start_with) {
  cash <- start_with
  n <- 0
  repeat {
    cash <- cash - 1 + play()
    n <- n + 1
    if (cash <= 0) {
      break
    }
  }
  n
}

plays_till_broke(100)



# Get prize
score <- function(symbols) {
  
  diamonds <- sum(symbols == "DD")
  cherries <- sum(symbols == "C")
  
  # identify case
  # since diamonds are wild, only nondiamonds 
  # matter for three of a kind and all bars
  slots <- symbols[symbols != "DD"]
  same <- length(unique(slots)) == 1
  bars <- slots %in% c("B", "BB", "BBB")
  
  # assign prize
  if (diamonds == 3) {
    prize <- 100
  } else if (same) {
    payouts <- c("7" = 80, "BBB" = 40, "BB" = 25,
                 "B" = 10, "C" = 10, "0" = 0)
    prize <- unname(payouts[slots[1]])
  } else if (all(bars)) {
    prize <- 5
  } else if (cherries > 0) {
    # diamonds count as cherries
    # so long as there is one real cherry
    prize <- c(0, 2, 5)[cherries + diamonds + 1]
  } else {
    prize <- 0
  }
  
  # double for each diamond
  prize * 2^diamonds
}

# 12.4 Vectorized Code in Practice

# you could rewrite get_symbols to generate n slot combinations and return them as 
# an n x 3 matrix, like the one that follows. Each row of the matrix will contain 
# one slot combination to be scored:

get_many_symbols <- function(n) {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  vec <- sample(wheel, size = 3 * n, replace = TRUE,
                prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
  matrix(vec, ncol = 3)
}

get_many_symbols(5)

# You could also rewrite play to take a parameter, n, and return n prizes, in a data frame:

play_many <- function(n) {
  symb_mat <- get_many_symbols(n = n)
  data.frame(w1 = symb_mat[,1], w2 = symb_mat[,2],
             w3 = symb_mat[,3], prize = score_many(symb_mat))
}

# score_many is a vectorized version of score. You can use it to run the simulation at the
# start of this section in a little over 20 seconds. This is 17 times faster than using a 
# for loop:

# symbols should be a matrix with a column for each slot machine window
score_many <- function(symbols) {
  
  # Step 1: Assign base prize based on cherries and diamonds ---------
  ## Count the number of cherries and diamonds in each combination
  cherries <- rowSums(symbols == "C")
  diamonds <- rowSums(symbols == "DD") 
  
  ## Wild diamonds count as cherries
  prize <- c(0, 2, 5)[cherries + diamonds + 1]
  
  ## ...but not if there are zero real cherries 
  ### (cherries is coerced to FALSE where cherries == 0)
  prize[!cherries] <- 0
  
  # Step 2: Change prize for combinations that contain three of a kind 
  same <- symbols[, 1] == symbols[, 2] & 
    symbols[, 2] == symbols[, 3]
  payoffs <- c("DD" = 100, "7" = 80, "BBB" = 40, 
               "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
  prize[same] <- payoffs[symbols[same, 1]]
  
  # Step 3: Change prize for combinations that contain all bars ------
  bars <- symbols == "B" | symbols ==  "BB" | symbols == "BBB"
  all_bars <- bars[, 1] & bars[, 2] & bars[, 3] & !same
  prize[all_bars] <- 5
  
  # Step 4: Handle wilds ---------------------------------------------
  
  ## combos with two diamonds
  two_wilds <- diamonds == 2
  
  ### Identify the nonwild symbol
  one <- two_wilds & symbols[, 1] != symbols[, 2] & 
    symbols[, 2] == symbols[, 3]
  two <- two_wilds & symbols[, 1] != symbols[, 2] & 
    symbols[, 1] == symbols[, 3]
  three <- two_wilds & symbols[, 1] == symbols[, 2] & 
    symbols[, 2] != symbols[, 3]
  
  ### Treat as three of a kind
  prize[one] <- payoffs[symbols[one, 1]]
  prize[two] <- payoffs[symbols[two, 2]]
  prize[three] <- payoffs[symbols[three, 3]]
  
  ## combos with one wild
  one_wild <- diamonds == 1
  
  ### Treat as all bars (if appropriate)
  wild_bars <- one_wild & (rowSums(bars) == 2)
  prize[wild_bars] <- 5
  
  ### Treat as three of a kind (if appropriate)
  one <- one_wild & symbols[, 1] == symbols[, 2]
  two <- one_wild & symbols[, 2] == symbols[, 3]
  three <- one_wild & symbols[, 3] == symbols[, 1]
  prize[one] <- payoffs[symbols[one, 1]]
  prize[two] <- payoffs[symbols[two, 2]]
  prize[three] <- payoffs[symbols[three, 3]]
  
  # Step 5: Double prize for every diamond in combo ------------------
  unname(prize * 2^diamonds)
  
}

system.time(play_many(10000000))
##   user  system elapsed 
##  9.435   1.484  11.120 














  





























