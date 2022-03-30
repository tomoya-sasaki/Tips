# `foreach`
## Using random number generator
* Use `doRNG`

```
library(doParallel)
library(doRNG)
library(doMC)

registerDoParallel(cores = 20)

y <- foreach(i = 1:100) %dorng% {
	rnorm(1)
}
```



# `pforeach`

## When your desired out put is `list`
* You can "wrap" your results with a list.

```
library(pforeach)

cores <- 4
z <- pforeach(i = 1:8, .cores = cores)({
	set.seed(i)
	y <- list(10 + rnorm(1, 0, 1), 5 + rnorm(1, 0, 1))
	x <- list(10 + rnorm(1, 0, 1), 5 + rnorm(1, 0, 1))
	list(x = x, y = y)
})

> z
$x
$x[[1]]
[1] 9.164371

$x[[2]]
[1] 6.595281


$y
$y[[1]]
[1] 9.373546

$y[[2]]
[1] 5.183643


$x
$x[[1]]
[1] 11.58785

$x[[2]]
[1] 3.869624


$y
$y[[1]]
[1] 9.103085

$y[[2]]
[1] 5.184849

...
```

## The problem not yet resolved

```
Error in sendMaster(try(lapply(X = S, FUN = FUN, ...), silent = TRUE)) : 
  write error, closing pipe to the master
```
[here](https://stackoverflow.com/questions/21486658/warnings-suppressed-with-mclapply-in-r/21486716) in Stackoverflow
