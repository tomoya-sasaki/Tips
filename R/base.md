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


## Replace `Nan` with zeros

```
is.nan.data.frame <- function(x)
do.call(cbind, lapply(x, is.nan))

data123[is.nan(data123)] <- 0
```

## Replace `Inf`wit zeros

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

# vector
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

# Dataframe
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




[1]:https://stackoverflow.com/questions/16905425/find-duplicate-values-in-r
[2]:https://stackoverflow.com/questions/23518605/add-an-index-numeric-id-column-to-large-data-frame