# data.table

## Install
* Check [general.md](general.md) for `Makevars` file

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

## Apply the same operation to multiple columns

```
dt <- data.table(a = 1:3, b = 1:3, d = 1:3)
cols <- c("a", "b")
# multiply by -1
for (j in cols) set(dt, j = j, value = -dt[[j]])
```