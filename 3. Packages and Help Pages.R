# 3. Packages and Help Pages

# 3.1 install.packages. 
# Each R package is hosted at http://cran.r-project.org

install.packages("gplot2")

library("ggplot2")

qplot

x <- c(-1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1)
x

y <- x^3
y

# Draw scalerplot
qplot(x,y)

# Draw histogram

x <-c(1,2,2,2,3,3)
qplot(x, binwidth = 1)
x

x2 <- c(1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 4)
qplot(x2,binwidth = 1)

x3 <- c(0, 1, 1, 2, 2, 2, 3, 3, 4)
qplot(x3, binwidth = 1)

# Ejercise 3.1 Visualize a Histogram with dice

replicate(3,1 +1)

# Function roll
roll <- function() {
  die <- 1:6
  dice <- sample(die, size=2, replace = TRUE)
  sum(dice)
}

replicate (10,roll())

rolls <- replicate(10000, roll())
qplot(rolls, binwidth=1)

# 3.2 Getting Help with Help Pages

?sqrt
?sample

# If you'd like to look up the help page for a function but have forgotten the function's name,
# you can search by keyword.
??log

# Function roll with diferente probability
roll <- function(){
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE, 
                 prob = c(1/8, 1/8, 1/8, 1/8, 1/8, 3/8))
  sum(dice)
}

rolls <- replicate(10000, roll())
qplot(rolls, binwidth = 1)

