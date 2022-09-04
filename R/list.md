# List
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

## Select using vector

```
## Choose 5, 7, 9th elements of the list
mylist[c(5,7,9)]
```

## Name the list


## Find unique component
* For detail, see [here][1]

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


[1]:https://stackoverflow.com/questions/3879522/finding-unique-values-from-a-list