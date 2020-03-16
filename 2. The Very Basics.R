# Create an object named die
die <- 1:6
die

# I can see which object names you have already used with the fuction ls:
ls()

# Math operations
die -1 
die/2
die * die

# R does not always follow the rules of matrix multiplication.

# R will repeat a short vector to do elements-wise two vectors of uneven length
die * c(1,2)

# Inner multiplication with the %*%
die%*%die

# Outer multiplication with the %o%
die%o%die

# Transpose t()
t(die)

# Determinant det()
det(die)

# Functions 

# The data that you pass into the function is called the function's argument.

# Many R functuions take multiple arguments that help them do their job.

sample(die, size = 1)

# If you're not sure which names to use with a function, you can look up the function's arguments
# with args.

args(sample)

# Change default value in optional arguments 

round(3.1415)
round(3.1415, digits=2)

# Die with replace
args(sample)
sample(die, size = 2, replace = TRUE)

dice <- sample(die, size = 2, replace = TRUE)
dice
sum(dice)

# The function constructor

# Every funton in R has three basic parts: a name, a body of code, and a set arguments.

roll <- function() {
  die <- 1:6
  dice <- sample(die, size=2, replace = TRUE)
  sum(dice)
}

roll()

# This is a default value bones = 1:6

roll2 <- function(bones = 1:6) {
  dice <- sample(bones, size=2, replace = TRUE)
  sum(dice)
}

roll2()

# Parts function
# 1. The Name
# 2. The body
# 3. The arguments 
# 4. The default values
# 5. The last line of code




