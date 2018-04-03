# Convert the values in a column into rownames in an existing matrix

```
mat <- cbind(x = c("a", "b", "c"), y = c(1,2,3))

rownames(mat) <- mat[,1]
mat[,1] <- NULL
# or alternately you can this
mat <- mat[, -1]
# you can do the same thing for dataframe
```
