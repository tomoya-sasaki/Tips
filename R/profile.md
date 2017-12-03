You can profile your code to check the time consuming functions and stucking parts in your code.

## Use `Rprofile`
### Example
```
f <- function() {
  pause(0.1)
  g()
  h()
}
g <- function() {
  pause(0.1)
  h()
}
h <- function() {
  pause(0.1)
}
```
We evaluate the code above.

```
tmp <- tempfile()
Rprof(tmp, interval = 0.1) # default interval is 0.2)
f()
Rprof(NULL)
```

## Use `lineprof`
### Example
Save the code above and name `profiling-example.R`
```
library(lineprof)
source("profiling-example.R")
l <- lineprof(f())
```
The output of l is shown below.
```
l
#    time alloc release dups                    ref         src
# 1 0.092 0.001       0    2    c("pause", ".Call") pause/.Call
# 2 0.089 0.001       0    0  profiling-example.R#7 g/pause    
# 3 0.092 0.001       0    0  profiling-example.R#8 g/h        
```

4 0.088 0.000       0    0 profiling-example.R#11 h/pause    
