# data.table

## Create a grouping variable
* Use `.GRP`

```
# by key
DT[, Index := .GRP, key(DT)]

# by two variables
DT[, Index := .GRP, .(V1, V2)]
```

## Sample groups with replacement

```
samp <- sample(unique(DT$id), 100, replace = TRUE)
setkey(DT, "id")
DTnew <- DT[J(samp), allow.cartesian = TRUE]

```