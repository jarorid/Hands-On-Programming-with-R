# 5.5.2 Factors

# To make a factor, pass an atomic vector into the factor function. 
# R will recode the data in the vector as integers and store the results in an integer vector. 

gender <- factor(c("male", "female", "female", "male"))
typeof(gender)
attributes(gender)
unclass(gender)

# Factors make it easy to put categorical variables into a statistical model because the 
# variables are already coded as numbers. However, factors can be confusing since they 
# look like character strings but behave like integers.

# You can convert a factor to a character string with the as.character function. R will 
# retain the display version of the factor, not the integers stored in memory:

as.character(gender)

# Each atomic vector can only store one type of data. As a result, R coerces all 
# of your values to character strings

card <- c("ace", "hearts", 1)
card

# 5.6 Coercion

# If a vector only contains logicals and numbers, R will convert the logicals 
# to numbers; every TRUE becomes a 1, and every FALSE becomes a 0.

# If character strings are present, everything will be coerced to a character 
# string. Otherwise, logicals are coerced to numerics.

as.character(1)

as.logical(1)

as.numeric(1)

# Many data sets contain multiple types of information. The inability of vectors, 
# matrices, and arrays to store multiple data types seems like a major limitation.

# In other cases, allowing only a single type of data is not a disadvantage. 
# Vectors are the most common data structure in R because they store variables very well. 
# Each value in a variable measures the same property, so there’s no need to use different 
# types of data.

# 5.7 List

# Lists are like atomic vectors because they group data into a one-dimensional set. 
# However, lists do not group together individual values; lists group together R objects, 
# such as atomic vectors and other lists. For example, you can make a list that contains 
# a numeric vector of length 31 in its first element, a character vector of length 1 in 
# its second element, and a new list of length 2 in its third element.

list1 <- list(100:130, "R", list(TRUE, FALSE))
list1


# 5.8 Data Frames

# Data frames are the two-dimensional version of a list. They are far and away the most
# useful storage structure for data analysis, and they provide an ideal way to store an
# entire deck of cards. You can think of a data frame as R’s equivalent to the Excel 
# spreadsheet because it stores data in a similar format.

# Data frames store data as a sequence of columns. Each column can be a different data type. 
# Every column in a data frame must be the same length.


# Creating a data frame by hand takes a lot of typing, but you can do it (if you like) with
# the data.frame function. Give data.frame any number of vectors, each separated with a comma.
# Each vector should be set equal to a name that describes the vector. data.frame will turn 
# each vector into a column of the new data frame:

df = data.frame(face=c("ace","two","six"),
           suit = c("clubs", "clubs", "clubs"), 
           value = c(1, 2, 3))

df 

# You’ll need to make sure that each vector is the same length or can be made so with R’s
# recycling rules, as data frames cannot combine columns of different lengths.

typeof(df)

class(df)

str(df)

# Notice that R saved your character strings as factors. I told you that R likes factors!
# It is not a very big deal here, but you can prevent this behavior by adding the argument 
# stringsAsFactors = FALSE to data.frame:

df = data.frame(face=c("ace","two","six"),
                suit = c("clubs", "clubs", "clubs"), 
                value = c(1, 2, 3),
                stringsAsFactors = FALSE)
str(df)


deck <- data.frame(
  face = c("king", "queen", "jack", "ten", "nine", "eight", "seven", "six",
           "five", "four", "three", "two", "ace", "king", "queen", "jack", "ten", 
           "nine", "eight", "seven", "six", "five", "four", "three", "two", "ace", 
           "king", "queen", "jack", "ten", "nine", "eight", "seven", "six", "five", 
           "four", "three", "two", "ace", "king", "queen", "jack", "ten", "nine", 
           "eight", "seven", "six", "five", "four", "three", "two", "ace"),  
  suit = c("spades", "spades", "spades", "spades", "spades", "spades", 
           "spades", "spades", "spades", "spades", "spades", "spades", "spades", 
           "clubs", "clubs", "clubs", "clubs", "clubs", "clubs", "clubs", "clubs", 
           "clubs", "clubs", "clubs", "clubs", "clubs", "diamonds", "diamonds", 
           "diamonds", "diamonds", "diamonds", "diamonds", "diamonds", "diamonds", 
           "diamonds", "diamonds", "diamonds", "diamonds", "diamonds", "hearts", 
           "hearts", "hearts", "hearts", "hearts", "hearts", "hearts", "hearts", 
           "hearts", "hearts", "hearts", "hearts", "hearts"), 
  value = c(13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 13, 12, 11, 10, 9, 8, 
            7, 6, 5, 4, 3, 2, 1, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 13, 12, 11, 
            10, 9, 8, 7, 6, 5, 4, 3, 2, 1)
)


# 5.9 Loading Data

# Get working directory
getwd()

# Set working directory
setwd('/Users/jahirrodriguez/Downloads')

# Read de csv file
deck <- read.csv('deck.csv')

# head and tail are two functions that provide an easy way to peek at large data sets. 
# head will return just the first six rows of the data set, and tail will return just 
# the last six rows. To see a different number of rows, give head or tails a second 
# argument, the number of rows you would like to view, for example, head(deck, 10).
head(deck)

# 5.10 Saving Data

# You can save any data frame in R to a .csv
# You can customize the save process with write.csv’s large set of optional arguments
# (see ?write.csv for details). However, there are three arguments that you should use
# every time you run write.csv.

# First, you should give write.csv the name of the data frame that you wish to save. 
# Next, you should provide a file name to give your file. R will take this name quite
# literally, so be sure to provide an extension.

# Finally, you should add the argument row.names = FALSE. This will prevent R from adding
# a column of numbers at the start of your data frame.

write.csv(deck, file='cards.csv', row.names = FALSE)
  
