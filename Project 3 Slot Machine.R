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

score <- function (symbols) {
# Identify case
same <- symbols[1] == symbols[2] && symbols[1] == symbols[3]
bars <- symbols %in% c("B", "BBB", "BB")


# Get prize
# <1> - Test whether the symbols are three of a kind.
if (same){
  print ('The symbols are same')
  payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25, 
               "B" = 10, "C" = 10, "0" = 0)
  prize <- unname(payouts[symbols[1]])
}

# <2> - Test whether the symbols are all bars.
if (all(bars)){
  print ('The symbols are all bars')
  }

# <3> - Look up the prize for three of a kind based on the common symbol.
if (same) {
  symbol <- symbols[1]
  if (symbol == "DD") {
    prize <- 800
  } else if (symbol == "7") {
    prize <- 80
  } else if (symbol == "BBB") {
    prize <- 40
  } else if (symbol == "BB") {
    prize <- 5
  } else if (symbol == "B") {
    prize <- 10
  } else if (symbol == "C") {
    prize <- 10
  } else if (symbol == "0") {
    prize <- 0
  }
}
# <4> - Assign a prize of $5.
# <5> - Count the number of cherries.
cherries <-(sum(symbols == 'C'))
prize <- c(0,2,5)[cherries+1]
# <6> - Count the number of diamonds.
diamonts <-(sum(symbols == 'DD'))
prize * 2 ^ diamonts
# <7> - Calculate a prize based on the number of cherries.
# <8> - Adjust the prize for diamonds.


#if ( # Case 1: all the same <1>) {
#  prize <- # look up the prize <3>
#  } else if ( # Case 2: all bars <2> ) {
#    prize <- # assign $5 <4>
#    } else {
      # count cherries <5>
#      prize <- # calculate a prize <7>
#    }

# count diamonds <6>
# double the prize if necessary <8>
}















  





























