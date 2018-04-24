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
mylist[c(5,7,9)]
```

## Find unique component
* For detail, see [here][1]

```
unique(unlist(x, use.names = FALSE))
```

[1]:https://stackoverflow.com/questions/3879522/finding-unique-values-from-a-list