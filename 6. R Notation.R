# 6 R Notation

deck <- read.csv('deck.csv')

# 6.1 Selecting Values

# deck[ , ]

# They are all very simple and quite handy, so let’s take a look at each of them. 
# You can create indexes with:
  
# Positive integers
# Negative integers
# Zero
# Blank spaces
# Logical values
# Names

# 6.1.1 Positive Integers

deck[1,1]

# To extract more than one value, use a vector of positive integers. For example, 
# you can return the first row of deck with deck[1, c(1, 2, 3)] or deck[1, 1:3]

deck[1, c(1,2,3)]

deck[1,1:3]

# Repetition

deck[c(1,1), c(1,2,3)]

deck[c(1), c(1,1,1)]

# R’s notation system is not limited to data frames. You can use the same syntax 
# to select values in any R object, as long as you supply one index for each 
# dimension of the object. So, for example, you can subset a vector (which has 
# one dimension) with a single index:

vec <- c(6, 1, 3, 6, 10, 5)
vec[1:3]
vec[c(1,2)]

# Indexing begins at 1
 
# In some programming languages, indexing begins with 0. This means that 0 returns
# the first element of a vector, 1 returns the second element, and so on.

# This isn’t the case with R. Indexing in R behaves just like indexing in linear algebra.
# The first element is always indexed by 1. Why is R different? Maybe because it was 
# written for mathematicians. Those of us who learned indexing from a linear algebra
# course wonder why computers programmers start with 0.

# 6.1.2 Negative Integers

# Negative integers do the exact opposite of positive integers when indexing. R will
# return every element except the elements in a negative index.

deck[-(2:52),c(1:3)]

# Negative integers are a more efficient way to subset than positive integers if you
# want to include the majority of a data frame’s rows or columns.

# 6.1.3 Zero

#  This creates an empty object

deck[0,0]

# To be honest, indexing with zero is not very helpful.

# 6.1.4 Blank Spaces

# You can use a blank space to tell R to extract every value in a dimension. This lets
# you subset an object on one dimension but not the others, which is useful for 
# extracting entire rows or columns from a data frame:

deck[1,]

# 6.1.5 Logical Values

# If you supply a vector of TRUEs and FALSEs as your index, R will match each TRUE and
# FALSE to a row in your data frame (or a column depending on where you place the index).

deck[1, c(TRUE, TRUE, FALSE)]

rows <- c(TRUE, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, 
          F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, 
          F, F, F, F, F, F, F, F, F, F, F, F, F, F)
deck[rows, ]

# 6.1.6 Names

# This is a common way to extract the columns of a data frame, since columns 
# almost always have names:

deck[1, c("face", "suit", "value")]

# 6.2 Deal a Card
deal <- function(cards){
  cards[1,]
}

deal(deck)

# 6.3 Shuffle the Deck

shuffle <- function(cards){
  random <- sample(1:52, size = 52)
  cards[random,]
}

head(shuffle(deck))

deal(shuffle(deck))

# 6.4 Dollar Signs and Double Brackets

# $. Notice that no quotes should go around the column name:

deck$value

# From time to time, you’ll want to run a function like mean or median on the values in a variable.

mean(deck$value)
