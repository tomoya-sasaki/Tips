1. [vector](#vector)
2. [matrix](#matrix)
3. [dataframe](#dataframe)
4. [list](#list)
5. [pipe](#pipe)

# base
## table
### Add column- and row-sums to table

```
# both column and row sums
addmargins(table(df$Company,df$Marital))

# only sum for each column, 2 for each row
addmargins(table(df$Company,df$Marital), 1)
```

### Include NAs

```
table(vec, useNA = "always") # always displays the number of missing values
table(vec, useNA = "ifany") # only displays the number of missing values if there are some
```


## binning
* Age etc


```
# option 1
findInterval(ages, c(20, 30, 40))

# option 2
data %>% dplyr::mutate(agegroup = case_when(age >= 40  & age <= 49 ~ '3',
                                             age >= 30  & age <= 39 ~ '2',
                                             age >= 20  & age <= 29 ~ '1'))
```

## Grouping
* Split a dataframe into groups based on one variable

```
# for data frame
df %>%
  split(f = as.factor(.$Cluster))
```

## `rowSums` and `colSums`
* `rowSums`is slower than `colSums`


# vector
## Convert one row/column of dataframe into vector
```
as.numeric(df[, 1])
```

## replicate the same operation

```
> replicate(3, rnorm(5))

           [,1]        [,2]       [,3]
[1,]  0.7086600 -0.28753399  2.7394584
[2,]  1.2401119 -1.56940352  0.3100194
[3,]  1.7929567  1.25951315 -1.9236301
[4,] -0.4647647  0.51893826  0.1365466
[5,] -0.4669128  0.02026587 -0.4949872
```


## Find common elements

```
a <- c(1,3,5,7,9)
b <- c(3,6,8,9,10)
c <- c(2,3,4,5,7,9)
# works fine
intersect(intersect(a,b),c)

# more clever way if you have many vectors
Reduce(intersect, list(a,b,c))
```

## Find non-duplicated elements between two vectors

```
outersect <- function(x, y) {
  sort(c(setdiff(x, y),
         setdiff(y, x)))
}
```

## find index of an element in vector

* Single match: only returns the first encounter of a match

```
x <- sample(1:10)
x
# [1]  4  5  9  3  8  1  6 10  7  2
match(c(4,8),x)
# [1] 1 5
```

* Multiple matches: a logical vector as long as the first argument, with a `TRUE` if that value can be found in the second argument and a `FALSE` otherwise

```
x <- sample(1:4,10,replace=TRUE)
x
# [1] 3 4 3 3 2 3 1 1 2 2
which(x %in% c(2,4))
# [1]  2  5  9 10
```

## Find the nearest value in a vector and return that ID
* Check which value in vector `x` is closet to `14`

```
x <- c(1, 6, 12, 28, 33)
which.min(abs(x - 14))

```

# matrix
## Check
* Check the dataframe entry with 1 ([here](https://stackoverflow.com/questions/50476617/extract-the-column-names-for-each-row-which-meets-a-condition))

## Drop based on colnames
```
df <- data.frame(ID = 1:10,
                 A1 = rnorm(10),
                 A2 = rnorm(10),
                 B1 = letters[1:10],
                 B2 = letters[11:20])
df[, -grep("1$", colnames(df))]
```


## Convert the values in a column into rownames in an existing matrix

```
mat <- cbind(x = c("a", "b", "c"), y = c(1,2,3))

rownames(mat) <- mat[,1]
mat[,1] <- NULL
# or alternately you can this
mat <- mat[, -1]
# you can do the same thing for dataframe
```

## Sorting columns/rows

* Sort the rownames of `DF1` based on the rownames of `DF2`.

```
# row-wise
DF1[match(rownames(DF2), rownames(DF1)), ]
# column-wise
DF1[, match(rownames(DF2), rownames(DF1))]
```

## Find duplicates

* "This table has five columns, the first of which holds the respondent ID numbers. I want to check if any respondents appear twice, or if all respondents are unique." [here][1]

```
# idea 1
n_occur <- data.frame(table(vocabulary$id))
# gives you a data frame with a list of ids and the number of times they occurred.

n_occur[n_occur$Freq > 1,]
# tells you which ids occurred more than once.

vocabulary[vocabulary$id %in% n_occur$Var1[n_occur$Freq > 1],]
# returns the records with more than one occurrence.

# idea 2
# id has some dupliates
duplicates <- as.character(dd$id[duplicated(dd$id)])
dd2 <- dd[dd$id %in% duplicates, ]
```

* Alternative context

```
df <- data.frame(a = c(1,2,3,4,1,5,6,4,2,1))

duplicated(df) | duplicated(df, fromLast = TRUE)

duplicated(df) | duplicated(df, fromLast = TRUE)
#[1]  TRUE  TRUE FALSE  TRUE  TRUE FALSE FALSE  TRUE  TRUE  TRUE

```

## Replace `NaN` with zeros

```
is.nan.data.frame <- function(x)
do.call(cbind, lapply(x, is.nan))

data123[is.nan(data123)] <- 0
```

## Replace `Inf` with zeros

```
data[data == Inf] <- 0
data[data == -Inf] <- 0
```

## Ranking values

* How to get column name of the variable with the top 10 highest values?

```
# idea 1
> DF <- data.frame(V1=c(2,8,1),V2=c(7,3,5),V3=c(9,6,4))
k <- 2

mx <- t(apply(DF,1,function(x)names(DF)[sort(head(order(x,decreasing=TRUE),k))]))
> mx
     [,1] [,2]
[1,] "V2" "V3"
[2,] "V1" "V3"
[3,] "V2" "V3"

# idea 2
set.seed(1)
df <- data.frame(matrix(runif(600*10), ncol = 600))

foo <- function(x, names) {
  ord <- order(x, decreasing = TRUE)[1:5]
  names[ord]
}

nams <- colnames(df)
apply(df, 1, foo, names = nams)

# idea 3
set.seed(123)
d <- data.frame(
  x   = runif(90),
  grp = gl(3, 30))

d %>%
  group_by(grp) %>%
  top_n(n = 5, wt = x)
```

* Ranking per row over multiple columns in R

```
d <- matrix(c(11, 21, 35, 3, 2, 1, 22, 12, 66, 2, 3, 1, 44, 22, 12, 1, 2, 3), nrow = 3, ncol = 6, byrow = T)
colnames(d) <- c("V1", "V2", "V3", "NewVariable_V1", "NewVariable_V2", "NewVariable_V3")

data.frame(d, t(apply(-d, 1, rank, ties.method='min')))
```

## Diagnoal matrix

```
> diag(1, nrow = 3, ncol = 3)
     [,1] [,2] [,3]
[1,]    1    0    0
[2,]    0    1    0
[3,]    0    0    1
```

## Matrix VS vector operation

* Use `sweep`
* Default operation is "-"

```
M <- matrix(1:12, nrow = 3)
M
     [,1] [,2] [,3]
[1,]    1    5    9
[2,]    2    6   10
[3,]    3    7   11
[4,]    4    8   12

# 1 for rowwise operation and
# 2 for column wise operation
sweep (M, 1, c(1:4), "+")
     [,1] [,2] [,3]
[1,]    2    6   10
[2,]    4    8   12
[3,]    6   10   14
[4,]    8   12   16
```

# dataframe
## Create a new column with
You can add a sequence of numbers very easily with

```
data$ID <- seq.int(nrow(data))
```

Of course it will have no real meaning so it might not be of use in analysis.

If you are already using library(tidyverse), you can use

```
data <- tibble::rowid_to_column(data, "ID")
```
Check [here][2]

## Assign column names to a function

```
df <- data.frame(A=1:10, B=2:11, C=3:12)
fun1 <- function(x, column){
  max(x[,column])
}
fun1(df, "B")
fun1(df, c("B","A"))
```

There's no need to use substitute, eval, etc.
You can even pass the desired function as a parameter:

```
fun1 <- function(x, column, fn) {
  fn(x[,column])
}
fun1(df, "B", max)
```

Alternatively, using `[[`  also works for selecting a single column at a time:

```
df <- data.frame(A=1:10, B=2:11, C=3:12)
fun1 <- function(x, column){
  max(x[[column]])
}
fun1(df, "B")
```

# list
## Change the order of list

```
Freedom <- c(1, 2, 3)
Equality <- c(2, 3, 1)
TypeCountry <- c("South", "East", "East")

Example <- list(Freedom, Equality, TypeCountry)
names(Example) <- c("Freedom", "Equality", "TypeCountry")
```

* You do this

```
Ex <- Example[c("TypeCountry","Freedom", "Equality")]
```

## list to dataframe

```
df <- map_df(list_of_dfs, ~as.data.frame(.x), .id="id")
```

## Select using vector

```
## Choose 5, 7, 9th elements of the list
mylist[c(5,7,9)]
```

## Name the list


## Find unique component
* For detail, see [here](https://stackoverflow.com/questions/3879522/finding-unique-values-from-a-list)

```
unique(unlist(x, use.names = FALSE))
```

## Appending lists

```
## base
ll <- list(a = 1, b = 2)
lll <- list(c = 3)
append(ll, lll)

## use rlist function
library(rlist)

rlist::list.append(ll, c = 3)
```

### Speed comparison
* **Never append matrix (or dataframe) to matrix (or dataframe)**
* Use list instead when you need to append matrix or dataframe and merge them later

```
tictoc::tic("base")
l <- list()
for (i in 1:10000) {
	l[[i]] <- matrix(rnorm(100), ncol = 5)
}
mat <- do.call(rbind, l)
tictoc::toc()
base: 0.16 sec elapsed

tictoc::tic("base and dataframe")
l <- list()
for (i in 1:10000) {
	l[[i]] <- data.frame(matrix(rnorm(100), ncol = 5))
}
mat <- do.call(rbind, l)
tictoc::toc()
base and dataframe: 1.497 sec elapsed

tictoc::tic("base and dataframe")
l <- list()
for (i in 1:10000) {
	l[[i]] <- data.frame(matrix(rnorm(100), ncol = 5))
}
mat <- data.table::rbindlist(l)
tictoc::toc()
base and dataframe: 0.93 sec elapsed

tictoc::tic("base and dataframe 2")
l <- list()
for (i in 1:10000) {
	l[[i]] <- data.frame(rnorm(20),rnorm(20),rnorm(20),rnorm(20),rnorm(20))
}
mat <- do.call(rbind, l)
tictoc::toc()
base and dataframe 2: 4.646 sec elapsed

tictoc::tic("list append")
l <- list()
for (i in 1:10000) {
	l <- list.append(l, matrix(rnorm(100), ncol = 5))
}
mat <- do.call(rbind, l)
tictoc::toc()
list append: 0.773 sec elapsed

tictoc::tic("appending matrix")
mat <- NA
for (i in 1:10000) {
	mat <- rbind(mat, matrix(rnorm(100), ncol = 5))
}
tictoc::toc()
appending matrix: 24.342 sec elapsed

```

# pipe
* Object in the LHS of the operator is evaluated at the first argument of the RHS function
* You need an anonymous function to use the LHS object as the non-first argument in the RHS function

```
# this does not work
diamonds |>
	aggregate(cbind(price, carat)~color, FUN = mean)

# use anonymouus function to use LHS object
diamonds |>
	(\(x) aggregate(cbind(price, carat)~color, data = x, FUN = mean))()

# or with magrittr
diamonds %>%
	aggregate(cbind(price, carat)~color, data = ., FUN = mean)
```

# Misc
* Rの<-と=は、どちらも付値を行う演算子ですが、<-は一般的に付値できる一方、=はトップレベルでしか付値できず、以下のように関数の中では付値できません。


```
mean(x<-rnorm(100))
x

mean(y=rnorm(100))
y

```

* %$%はtable()をとるときに便利に使っています。

```
cars %$% table(speed)
```

あと%>%でやる場合は{}の使い方もポイントで、cars %>% table(.$speed)ではcars %>% table(., .$speed)みたいな解釈になるので(?)エラーになります。それを回避するためにcars %>% {table(.$speed)}。


* Rでベクトルの要素の頻度を集計するときに、table()関数をよく使うが、useNA = "always" とオプション指定しておくと、NAの件数を常に表示してくれる


[1]:https://stackoverflow.com/questions/16905425/find-duplicate-values-in-r
[2]:https://stackoverflow.com/questions/23518605/add-an-index-numeric-id-column-to-large-data-frame