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