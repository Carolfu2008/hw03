### 3) Binomial Probability Functions

#Function is_integer()
#'@ title is_integer
#'@ description tests if a numeric value can be considered to be an integer number
#'@ param x any numeric value
#'@ return TRUE or FALSE

is_integer <- function(x){ #1
  if ( x%%2 ==1| x%%2 ==0){
    return(TRUE)
  } else{
    return(FALSE)
  }
}#1
```
```{r}
# TRUE's
is_integer(-1)
is_integer(0)
is_integer(2L)
is_integer(2)
# FALSE's
is_integer(2.1)
is_integer(pi)
is_integer(0.01)

#Function is_positive()
#'@ title is_positive
#'@ description tests if a numeric value is a positive number
#'@ param x any numeric value
#'@ return TRUE or FALSE
is_positive <- function(x){ #1
  if (x>0){
    return(TRUE)
  } else{
    return(FALSE)
  }
}#1


# TRUE's
is_positive(0.01)
is_positive(2)
# FALSE's
is_positive(-2)
is_positive(0)


#Function is_nonnegative()
#'@ title is_nonnegative
#'@ description tests if a numeric value is a non-negative number
#'@ param x any numeric value
#'@ return TRUE or FALSE
is_nonnegative <- function(x){ #1
  if (x>=0){
    return(TRUE)
  } else{
    return(FALSE)
  }
}#1


# TRUE's
is_nonnegative(0)
is_nonnegative(2)
# FALSE's
is_nonnegative(-0.00001)
is_nonnegative(-2)


#Function is_positive_integer()
#'@ title is_positive_integer
#'@ description tests if a numeric value is a positive_integer
#'@ param x any numeric value
#'@ return TRUE or FALSE
is_positive_integer <- function(x){ #1
  if ((x%%2 ==0 | x%%2==1)& x>0){
    return(TRUE)
  } else{
    return(FALSE)
  }
}#1


# TRUE
is_positive_integer(2)
is_positive_integer(2L)
# FALSE
is_positive_integer(0)
is_positive_integer(-2)


#Function is_nonneg_integer()
#'@ title is_nonneg_integer
#'@ description tests if a numeric value can be considered to be a non-negative integer
#'@ param x any numeric value
#'@ return TRUE or FALSE
is_nonneg_integer <- function(x){ #1
  if ((x%%2 ==0 | x%%2 ==1) && x>=0){
    return(TRUE)
  } else{
    return(FALSE)
  }
}#1


# TRUE's
is_nonneg_integer(0)
is_nonneg_integer(1)
# FALSE
is_nonneg_integer(-1)
is_nonneg_integer(-2.5)


#Function is_probability()
#'@ title is_probability
#'@ description tests if a given number p is a valid probability value: 0 <=p<=1
#'@ param p any numeric value
#'@ return TRUE or FALSE
is_probability <- function(p){ #1
  if (p>=0 & p<=1){
    return(TRUE)
  } else{
    return(FALSE)
  }
}#1


# TRUE's
is_probability(0)
is_probability(0.5)
is_probability(1)
# FALSE's
is_probability(-1)
is_probability(1.0000001)

for(i in 1:x){
  y <-y*((1:x)[i])
}
print(y)

#Function bin_factorial()
#'@ title bin_factorial
#'@ description Use a for loop to write a function bin_factorial() that calculates the factorial of a nonnegative integer n
#'@ param x any numeric value
#'@ return TRUE or FALSE
y=1
bin_factorial <- function(x){
  if (x>0){
    for(i in 1:x){
      y <- y*i
    }
    return(y)
  }
  else if(x==0){
    return(1)
  }
  else{
    stop("ahhh,The input should be a non-negative integer")
  }
}

# valid
bin_factorial(5)
## [1] 120
bin_factorial(0)
## [1] 1


# Use bin_factorial() to write a function bin_combinations() that calculates the number of combinations in which k successes can occur in n trials.
#' @Title bin_combinations
#' @description: calculates the number of combinations in which k successes can occur in n trials
#' @param n trials, a non-negative discrete value
#' @param k successes, a non-negative discrete value
#' @return

y=1

bin_combinations <- function(n,k){
  y = bin_factorial(n)/(bin_factorial((n-k))*bin_factorial(k))
  return(y)
}
```
```{r}
bin_combinations(n = 5, k = 2)
bin_combinations(10, 3)
bin_combinations(4, 4)


# Function bin_probability()
# Use your functions is_nonneg_integer(), is_probability(), and bin_combinations()
# to create a bin_probability() function. Your function should have arguments trials, success, and prob.
#' @Title bin_probability
#'
#' @param trials, a non-negative discrete value
#' @param success, a non-negative discrete value
#' @param prob
#'
#' @return

bin_probability <- function(trials, success, prob){
  if(is_nonneg_integer(trials)==FALSE){
    stop("Error! Number of trials are invalid.")
  }else if(is_nonneg_integer(success)==FALSE){
    stop("Error! Number of successes are invalid.")
  }else if(is_probability(prob)==FALSE){
    stop("Error! Probability should between 0 and 1.")
  }else{
    y = bin_combinations(trials,success)*(prob)^success*(1-prob)^(trials-success)
  }
  return(y)
}


#test
bin_probability(trials = 5, success = 2, prob = 0.5)



# Function bin_distribution()
# Use bin_probability() to create a bin_distribution() function. Your function should have arguments trials, and prob. This function should return a data frame with the probability distribution. binomial probability distribution

bin_distribution <- function(trials,prob){
  success=0:trials
  probability=rep(0, length=(trials+1))
  i=1
  while(i<=trials+1){
    probability[i] <- bin_probability(trials,success[i],prob)
    i=i+1
    dat <- data.frame(success, probability)
  }
  dat
}



#bin_distribution <- function(n,k)
bin_distribution(trials = 5, prob = 0.5)



# Assume that the ¡§successful¡¨ event is getting a ¡§six¡¨ when rolling a die. Consider rolling a fair die 10 times. Use bin_probability() to find the probability of getting exactly 3 sixes.
bin_probability(trials = 10, success = 3, prob = 1/6)


# Use bin_distribution() to obtain the distribution of the number of ¡§sixes¡¨ when
# rolling a loaded die 10 times, in which the number ¡§six¡¨ has probability of 0.25. Make a plot of this distributiona plot of this distribution.

bin_distribution(trials = 10, prob = 0.25)

plot <- ggplot(bin_distribution(trials = 10, prob = 0.25), aes(x = success, y = probability)) +
  geom_bar(stat = "identity",  fill = "lightblue") +
  labs(title = "Distribution for a Loaded Die")

print(plot)


# ¡E Use bin_probability(), and a for loop, to obtain the probability of getting more
# than 3 heads in 5 tosses with a biased coin of 35% chance of heads.

success=4:5
for(i in 1:2){

  moreThan3[i] <- bin_probability(trials = 5, success[i], prob = 0.35)
}
sum(moreThan3)

# ¡E Use bin_distribution() to obtain the probability distribution of the number of heads when tossing a loaded coin 15 times, with 35% chance of heads. Make a plot of this distribution.
bin_distribution(trials = 15, prob = 0.35)
plot1 <- ggplot(bin_distribution(trials = 15, prob = 0.35), aes(x = success, y = probability)) +
  geom_bar(stat = "identity",  fill = "lightgreen") +
  labs(title = "Distribution for Number of Head")

print(plot1)
