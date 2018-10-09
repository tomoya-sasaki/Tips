# matrix
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

[1]:https://stackoverflow.com/questions/16905425/find-duplicate-values-in-r