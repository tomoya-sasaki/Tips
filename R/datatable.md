# data.table

## Install
* Check [general.md](general.md) for `Makevars` file

## Setup

https://rpubs.com/Kibalnikov/776164

* Change the path to llvm if you are using Intel
* Set path in .zshrc as brew suggests

Not sure needed: Set path in .Renviron as Yiqing suggests: https://yiqingxu.org/public/BigSurError.pdf

### .zshrc

```
export PATH="/usr/local/opt/llvm/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"
```

### Makevars

```
# if you downloaded llvm manually above, replace with your chosen NEW_PATH/clang
LLVM_LOC = /usr/local/opt/llvm
CC=$(LLVM_LOC)/bin/clang -fopenmp
CXX=$(LLVM_LOC)/bin/clang++ -fopenmp
# -O3 should be faster than -O2 (default) level optimisation ..
CFLAGS=-g -O3 -Wall -pedantic -std=gnu99 -mtune=native -pipe
CXXFLAGS=-g -O3 -Wall -pedantic -std=c++11 -mtune=native -pipe
LDFLAGS=-L/opt/homebrew/opt/gettext/lib -L$(LLVM_LOC)/lib -Wl,-rpath,$(LLVM_LOC)/lib
CPPFLAGS=-I/opt/homebrew/opt/gettext/include -I$(LLVM_LOC)/include
```

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

## Comparisons with `dplyr`

* [ref](https://stackoverflow.com/questions/38236499/what-is-the-equivalent-of-dplyr-mutate-and-summarise-in-data-table)

```
# equivalent to dplyr::mutate by group
MT[, max_mpg := max(mpg), by = cyl]

# equivalent to dplyr::summarise by group
MT[, .(max_mpg = max(mpg)), by = cyl]
```