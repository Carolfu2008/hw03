hw03- Pipes and Programming Basics
================
Huiqing Fu
3/16/2018

``` r
library("ggplot2")
```

``` bash

mkdir hw03
cd hw03
mkdir code
mkdir data
mkdir report
mkdir images
echo "#hw03" >> READMD.md
```

``` bash
cd data/
curl -O https://raw.githubusercontent.com/ucb-stat133/stat133-spring-2018/master/data/nba2017-roster.csv
```

    ## bash: line 0: cd: data/: No such file or directory
    ##   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
    ##                                  Dload  Upload   Total   Spent    Left  Speed
    ## 
      0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
      0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
      0     0    0     0    0     0      0      0 --:--:--  0:00:01 --:--:--     0
      0     0    0     0    0     0      0      0 --:--:--  0:00:02 --:--:--     0
     75 20751   75 15541    0     0   3885      0  0:00:05  0:00:03  0:00:02  3885
    100 20751  100 20751    0     0   5157      0  0:00:04  0:00:04 --:--:--  5158

### 2) Pipelines and Redirection

##### 2.1) Write a pipeline to obtain the unique team names, and redirect the output to a text file team-names.txt. Use head to display the first five lines of the created file (output shown belown).

``` bash
cut -f 2 -d "," nba2017-roster.csv  | tail +2 | sort -u > team-names.txt 
head -n 5 team-names.txt
```

    ## "ATL"
    ## "BOS"
    ## "BRK"
    ## "CHI"
    ## "CHO"

##### 2.2)Write a pipeline to obtain the unique positions, and redirect the output to a text file position-names.txt. Use head to display the first five lines of the created file (output shown belown).

``` bash
cut -f 3 -d "," nba2017-roster.csv | tail +2 | sort -u > position-names.txt
head -n 5 position-names.txt
```

    ## "C"
    ## "PF"
    ## "PG"
    ## "SF"
    ## "SG"

##### 2.3) Write a pipeline to obtain the counts (i.e. frequencies) of the different experience values, displayed from largest to smallest (i.e. descending order). Redirect the output to a text file experience-counts.txt. Use head to display the first five lines of the created file (output 4 shown belown). The first column corresponds to count, the second column corresponds to experience.

``` bash
cut -f 7 -d "," nba2017-roster.csv | tail +2  | sort -n| uniq -c > experience-counts.txt
head -n 5 experience-counts.txt
```

    ##   80 0
    ##   52 1
    ##   46 2
    ##   36 3
    ##   35 4

##### 2.4)Use output redirection commands to create a CSV file LAC.csv containing data for the LAC team (Los Angeles Clippers). Your CSV file should include column names. Use cat to display the content of the created file (output shown belown).

``` bash
head -n 1 nba2017-roster.csv |cat
grep "LAC" nba2017-roster.csv > LAC.csv
cat LAC.csv
```

    ## "player","team","position","height","weight","age","experience","salary"
    ## "Alan Anderson","LAC","SF",78,220,34,7,1315448
    ## "Austin Rivers","LAC","SG",76,200,24,4,1.1e+07
    ## "Blake Griffin","LAC","PF",82,251,27,6,20140838
    ## "Brandon Bass","LAC","PF",80,250,31,11,1551659
    ## "Brice Johnson","LAC","PF",82,230,22,0,1273920
    ## "Chris Paul","LAC","PG",72,175,31,11,22868828
    ## "DeAndre Jordan","LAC","C",83,265,28,8,21165675
    ## "Diamond Stone","LAC","C",83,255,19,0,543471
    ## "J.J. Redick","LAC","SG",76,190,32,10,7377500
    ## "Jamal Crawford","LAC","SG",77,200,36,16,13253012
    ## "Luc Mbah a Moute","LAC","SF",80,230,30,8,2203000
    ## "Marreese Speights","LAC","C",82,255,29,8,1403611
    ## "Paul Pierce","LAC","SF",79,235,39,18,3500000
    ## "Raymond Felton","LAC","PG",73,205,32,11,1551659
    ## "Wesley Johnson","LAC","SF",79,215,29,6,5628000

##### 2.5) Write a pipeline to display the age frequencies of LAL players. The first column corresponds to count, the second column corresponds to age.

``` bash
tail +2 nba2017-roster.csv |grep "LAL" | cut -f 6 -d ","  | sort| uniq -c > age-count.csv
cat age-count.csv
```

    ##    2 19
    ##    1 20
    ##    2 22
    ##    3 24
    ##    2 25
    ##    2 30
    ##    2 31
    ##    1 37

##### 2.6) Write a pipeline to find the number of players in CLE (Cleveland) team; the output should be just the number of players.

``` bash
tail +2 nba2017-roster.csv | grep "CLE" | wc -l
```

    ##       15

##### 2.7) Write pipelines to create a CSV file gsw-height-weight.csv that contains the player, height and weight of GSW players. Your CSV file should include column names. Use cat to display the file contents:

``` bash
#head nba2017-roster.csv
cut -f 1,4-5 -d "," nba2017-roster.csv | head -n 1 |cat
#grep "GSW" nba2017-roster.csv | cut -f 1,4-5 -d "," | cat 
grep "GSW" nba2017-roster.csv | cut -f 1,4-5 -d ","  |cat > gsw-height-weight.csv
cat gsw-height-weight.csv
```

    ## "player","height","weight"
    ## "Andre Iguodala",78,215
    ## "Damian Jones",84,245
    ## "David West",81,250
    ## "Draymond Green",79,230
    ## "Ian Clark",75,175
    ## "James Michael McAdoo",81,230
    ## "JaVale McGee",84,270
    ## "Kevin Durant",81,240
    ## "Kevon Looney",81,220
    ## "Klay Thompson",79,215
    ## "Matt Barnes",79,226
    ## "Patrick McCaw",79,185
    ## "Shaun Livingston",79,192
    ## "Stephen Curry",75,190
    ## "Zaza Pachulia",83,270

##### 2.8)Write pipelines to create a file top10-salaries.csv containing the top10 player salaries, arranged by salary from largest to smallest. Your CSV file should include column names. Use cat to display the file contents

``` bash
#head -n 5 nba2017-roster.csv 
#cut -f 1,8 -d "," nba2017-roster.csv | head -n 1 | cat
cut -f 1,8 -d "," nba2017-roster.csv | tail +2 | sort -n -k 2 -r -t '\,'| head -n 10 | cat > top10-salaries.csv
cat top10-salaries.csv
```

    ## "LeBron James",30963450
    ## "Russell Westbrook",26540100
    ## "Mike Conley",26540100
    ## "Kevin Durant",26540100
    ## "James Harden",26540100
    ## "DeMar DeRozan",26540100
    ## "Al Horford",26540100
    ## "Carmelo Anthony",24559380
    ## "Damian Lillard",24328425
    ## "Dwyane Wade",23200000

### 3) Binomial Probability Functions

``` r
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

``` r
# TRUE's
is_integer(-1)
```

    ## [1] TRUE

``` r
is_integer(0)
```

    ## [1] TRUE

``` r
is_integer(2L)
```

    ## [1] TRUE

``` r
is_integer(2)
```

    ## [1] TRUE

``` r
# FALSE's
is_integer(2.1)
```

    ## [1] FALSE

``` r
is_integer(pi)
```

    ## [1] FALSE

``` r
is_integer(0.01)
```

    ## [1] FALSE

``` r
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
```

``` r
# TRUE's
is_positive(0.01)
```

    ## [1] TRUE

``` r
is_positive(2)
```

    ## [1] TRUE

``` r
# FALSE's
is_positive(-2)
```

    ## [1] FALSE

``` r
is_positive(0)
```

    ## [1] FALSE

``` r
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
```

``` r
# TRUE's
is_nonnegative(0)
```

    ## [1] TRUE

``` r
is_nonnegative(2)
```

    ## [1] TRUE

``` r
# FALSE's
is_nonnegative(-0.00001)
```

    ## [1] FALSE

``` r
is_nonnegative(-2)
```

    ## [1] FALSE

``` r
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
```

``` r
# TRUE
is_positive_integer(2)
```

    ## [1] TRUE

``` r
is_positive_integer(2L)
```

    ## [1] TRUE

``` r
# FALSE
is_positive_integer(0)
```

    ## [1] FALSE

``` r
is_positive_integer(-2)
```

    ## [1] FALSE

``` r
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
```

``` r
# TRUE's
is_nonneg_integer(0)
```

    ## [1] TRUE

``` r
is_nonneg_integer(1)
```

    ## [1] TRUE

``` r
# FALSE
is_nonneg_integer(-1)
```

    ## [1] FALSE

``` r
is_nonneg_integer(-2.5)
```

    ## [1] FALSE

``` r
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
```

``` r
# TRUE's
is_probability(0)
```

    ## [1] TRUE

``` r
is_probability(0.5)
```

    ## [1] TRUE

``` r
is_probability(1)
```

    ## [1] TRUE

``` r
# FALSE's
is_probability(-1)
```

    ## [1] FALSE

``` r
is_probability(1.0000001)
```

    ## [1] FALSE

``` r
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
```

``` r
# valid
bin_factorial(5)
```

    ## [1] 120

``` r
## [1] 120
bin_factorial(0)
```

    ## [1] 1

``` r
## [1] 1
```

``` r
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

``` r
bin_combinations(n = 5, k = 2)
```

    ## [1] 10

``` r
bin_combinations(10, 3)
```

    ## [1] 120

``` r
bin_combinations(4, 4)
```

    ## [1] 1

``` r
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
```

``` r
bin_probability(trials = 5, success = 2, prob = 0.5)
```

    ## [1] 0.3125

``` r
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
```

``` r
#bin_distribution <- function(n,k)
bin_distribution(trials = 5, prob = 0.5)
```

    ##   success probability
    ## 1       0     0.03125
    ## 2       1     0.15625
    ## 3       2     0.31250
    ## 4       3     0.31250
    ## 5       4     0.15625
    ## 6       5     0.03125

``` r
# Assume that the “successful” event is getting a “six” when rolling a die. Consider rolling a fair die 10 times. Use bin_probability() to find the probability of getting exactly 3 sixes.

bin_probability(trials = 10, success = 3, prob = 1/6)
```

    ## [1] 0.1550454

``` r
# Use bin_distribution() to obtain the distribution of the number of “sixes” when
# rolling a loaded die 10 times, in which the number “six” has probability of 0.25. Make a plot of this distributiona plot of this distribution.

bin_distribution(trials = 10, prob = 0.25)
```

    ##    success  probability
    ## 1        0 5.631351e-02
    ## 2        1 1.877117e-01
    ## 3        2 2.815676e-01
    ## 4        3 2.502823e-01
    ## 5        4 1.459980e-01
    ## 6        5 5.839920e-02
    ## 7        6 1.622200e-02
    ## 8        7 3.089905e-03
    ## 9        8 3.862381e-04
    ## 10       9 2.861023e-05
    ## 11      10 9.536743e-07

``` r
plot <- ggplot(bin_distribution(trials = 10, prob = 0.25), aes(x = success, y = probability)) + 
  geom_bar(stat = "identity",  fill = "lightblue") + 
  labs(title = "Distribution for a Loaded Die") +
  scale_x_discrete(limits=c(0:10))
print(plot)
```

![](images/unnamed-chunk-32-1.png)

``` r
# • Use bin_probability(), and a for loop, to obtain the probability of getting more
# than 3 heads in 5 tosses with a biased coin of 35% chance of heads.

success=4:5
for(i in 1:2){
  
  moreThan3[i] <- bin_probability(trials = 5, success[i], prob = 0.35)
}
```

    ## Error in eval(expr, envir, enclos): object 'moreThan3' not found

``` r
sum(moreThan3)
```

    ## Error in eval(expr, envir, enclos): object 'moreThan3' not found

``` r
# • Use bin_distribution() to obtain the probability distribution of the number of heads when tossing a loaded coin 15 times, with 35% chance of heads. Make a plot of this distribution.
bin_distribution(trials = 15, prob = 0.35)
```

    ##    success  probability
    ## 1        0 1.562069e-03
    ## 2        1 1.261672e-02
    ## 3        2 4.755531e-02
    ## 4        3 1.109624e-01
    ## 5        4 1.792469e-01
    ## 6        5 2.123387e-01
    ## 7        6 1.905604e-01
    ## 8        7 1.319264e-01
    ## 9        8 7.103729e-02
    ## 10       9 2.975066e-02
    ## 11      10 9.611752e-03
    ## 12      11 2.352527e-03
    ## 13      12 4.222484e-04
    ## 14      13 5.246873e-05
    ## 15      14 4.036056e-06
    ## 16      15 1.448841e-07

``` r
plot1 <- ggplot(bin_distribution(trials = 15, prob = 0.35), aes(x = success, y = probability)) + 
  geom_bar(stat = "identity",  fill = "lightgreen") + 
  labs(title = "Distribution for Number of Head") +
  scale_x_discrete(limits=c(0:15))

print(plot1)
```

![](images/unnamed-chunk-34-1.png)
