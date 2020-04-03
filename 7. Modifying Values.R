# 7 Modifying Values

deck2 <- deck

# 7.0.1 Changing Values in Place

vec <- c(0,0,0,0,0,0)
vec[1]
vec[1]<- 1000
vec[1]

# You can replace multiple values at once as long
# as the number of new values equals the number of selected values:

vec[c(1,3,5)] <- c(1,1,1)
vec

vec[4:6] <- vec[4:6] + 1
vec

# You can also create values that do not yet exist in your object. R will
# expand the object to accommodate the new values:    

vec[7] <- 0
vec

# This provides a great way to add new variables to your data set:

deck2$new <- 1:52
deck2

# You can also remove columns from a data frame (and elements from
# a list) by assigning them the symbol NULL:

deck2$new <- NULL
deck2

# In the game of war, aces are king (figuratively speaking). They receive the highest
# value of all the cards, which would be something like 14. Every other card gets the
# value that it already has in deck. To play war, you just need to change the values 
# of your aces from 1 to 14.

deck2[c(13, 26, 39, 52), ]

deck2[c(13, 26, 39, 52), 3]

deck2$value[c(13, 26, 39, 52)]

# Now all you have to do is assign a new set of values to these old values.

deck2$value[c(13, 26, 39, 52)] <- 14

# But what if the deck had been shuffled? You could look through all the cards and note
# the locations of the aces, but that would be tedious. If your data frame were larger,
# it might be impossible:

deck3 <- shuffle(deck)
head(deck3)

# 7.0.2 Logical Subsetting

# 7.0.2.1 Logical Tests

# R’s Logical Operators
# Operator	Syntax	Tests
# >	a > b	Is a greater than b?
#  >=	a >= b	Is a greater than or equal to b?
#  <	a < b	Is a less than b?
#  <=	a <= b	Is a less than or equal to b?
#  ==	a == b	Is a equal to b?
#  !=	a != b	Is a not equal to b?
#  %in%	a %in% c(a, b, c)	Is a in the group c(a, b, c)?
#  Each operator returns a TRUE or a FALSE. If you use an operator to compare vectors, 
# R will do element-wise comparisons—just like it does with the arithmetic operators:

1 > 2

1 > c(1,2,3)

# %in% is the only operator that does not do normal element-wise execution. %in% tests 
# whether the value(s) on the left side are in the vector on the right side.

1 %in% c(3, 4, 5)

c(1, 2) %in% c(3, 4, 5)

c(1, 2, 3, 4) %in% c(3, 4, 5)

# Be careful not to confuse = with ==. = does the same thing as <-: it assigns a value to an object.

# Exercise 7.1 (How many Aces?) Extract the face column of deck2 and test whether each value 
# is equal to ace.

deck2$face == 'ace'

# You can use sum to quickly count the number of TRUEs in the previous vector. Remember that R will 
# coerce logicals to numerics when you do math with them. R will turn TRUEs into ones and FALSEs
# into zeroes. As a result, sum will count the number of TRUEs:

sum(deck2$face == 'ace')

# Then use the test to single out the ace point values. Since the test returns a logical vector, 
# you can use it as an index. Finally, use assignment to change the ace values in deck3:

deck3$value[deck3$face=='ace'] <- 14

head(deck3)

# Logical subsetting is a powerful technique because it lets you quickly identify, extract, 
# and modify individual values in your data set. When you work with logical subsetting,
# you do not need to know where in your data set a value exists. You only need to know how
# to describe the value with a logical test.

deck4 <- deck
deck4$value <- 0

# except cards in the suit of hearts and the queen of spades. Each card in the suit of 
# hearts has a value of 1. Can you find these cards and replace their values? Give it a try.

deck4$value[deck4$suit == 'hearts'] <- 1

# But that’s 12 cards too many. What you really want to find is all of the cards that have both 
# a face value equal to queen and a suit value equal to spades. You can do that with a Boolean
# operator. Boolean operators combine multiple logical tests together into a single test.

# 7.0.2.2 Boolean Operators

# Boolean operators are things like and (&) and or (|). They collapse the results of multiple
# logical tests into a single TRUE or FALSE. R has six boolean operators,

# Operator	Syntax	Tests
# &	cond1 & cond2	Are both cond1 and cond2 true?
# |	cond1 | cond2	Is one or more of cond1 and cond2 true?
# xor	xor(cond1, cond2)	Is exactly one of cond1 and cond2 true?
#  !	!cond1	Is cond1 false? (e.g., ! flips the results of a logical test)
#any	any(cond1, cond2, cond3, ...)	Are any of the conditions true?
#  all	all(cond1, cond2, cond3, ...)	Are all of the conditions true?

# Example

a <- c(1, 2, 3)
b <- c(1, 2, 3)
c <- c(1, 2, 4)

a == b

b == c

a == b & b == c

# Could you use a Boolean operator to locate the queen of spades in your deck? Of course you can.

deck4[deck4$face == 'queen' & deck4$suit == 'spades',] 

# Then change value 

deck4$value[deck4$face == 'queen' & deck4$suit == 'spades'] <- 13

sum(deck4$value)

# Example blackjack

deck5 <- deck

# You can change the value of the face cards in one fell swoop with %in%:

facecards <- deck5$face %in% c('king','queen','jack')

deck5[facecards,]

deck5$value[facecards] <- 10    

head(deck5,13)

# 7.0.3 Missing Information

# The NA character is a special symbol in R. It stands for “not available”
# and can be used as a placeholder for missing information

# 7.0.3.1 na.rm

mean(c(NA,1:50))

# Understandably, you may prefer a different behavior. Most R functions come
# with the optional argument, na.rm, which stands for NA remove. R will ignore 
# NAs when it evaluates a function if you add the argument na.rm = TRUE:

mean(c(NA,1:50),na.rm = TRUE)

# 7.0.3.2 is.na

# On occasion, you may want to identify the NAs in your data set with a logical
# test, but that too creates a problem.

# This don't work

NA == NA

c(1,2,3,NA) == NA

# This works 

is.na(NA)

is.na(c(1,2,3,NA))

# Let’s set all of your ace values to NA. This will accomplish two things. First, 
# it will remind you that you do not know the final value of each ace. Second, it 
# will prevent you from accidentally scoring a hand that has an ace before you 
# determine the ace’s final value.

# You can set your ace values to NA in the same way that you would set them to a number:

deck5$value[deck5$face=='ace'] <- NA

# Congratulations. Your deck is now ready for a game of blackjack. :) :) :) 

















































