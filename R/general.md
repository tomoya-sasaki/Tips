# general

## Makevars file

```
# add based on here https://stackoverflow.com/questions/69639782/installing-gfortran-on-macbook-with-apple-m1-chip-for-use-in-r
FC = /opt/homebrew/Cellar/gcc/13.1.0/bin/gfortran
F77 = /opt/homebrew/Cellar/gcc/13.1.0/bin/gfortran
FLIBS = -L/opt/homebrew/Cellar/gcc/13.1.0/lib/gcc/11

# the following lines probably only when you install data.table package
# igraph package does not compile with the following lines
# if you downloaded llvm manually above, replace with your chosen NEW_PATH/clang
LLVM_LOC = /opt/homebrew/opt/llvm
CC=$(LLVM_LOC)/bin/clang -fopenmp
CXX=$(LLVM_LOC)/bin/clang++ -fopenmp
# -O3 should be faster than -O2 (default) level optimisation ..
CFLAGS=-g -O3 -Wall -pedantic -std=gnu99 -mtune=native -pipe
CXXFLAGS=-g -O3 -Wall -pedantic -std=c++11 -mtune=native -pipe
LDFLAGS=-L/opt/homebrew/opt/gettext/lib -L$(LLVM_LOC)/lib -Wl,-rpath,$(LLVM_LOC)/lib
CPPFLAGS=-I/opt/homebrew/opt/gettext/include -I$(LLVM_LOC)/include

```

## Implement R in terminal
For detail, check [here](http://qiita.com/doskin/items/5e3877f110af244f7b59)

```
$ R --vanilla --slave < file_name.R
$ Rscript --vanilla --slave file_name.R
```

* `--vanilla`: このオプションを付けると、R がこれまでに保存していたオブジェクトを使用しないプレーンな状態で実行する
* `--slave`: このオプションを付けると、スクリプト実行時に標準出力に表示される情報を出力しない


## Open R in English in terminal
* Type `LC_ALL=en_US.UTF-8 R` to start R
* See [here](https://stackoverflow.com/questions/19781008/r-language-setting-cant-be-change-with-default-writes-command-on-mac), [here](https://stackoverflow.com/questions/12642651/in-r-how-to-get-error-messages-in-english), or [here](https://stackoverflow.com/questions/13575180/how-to-change-language-settings-in-r). See [here](http://qiita.com/methane/items/dac75ef5019b311a0f10) for some details of `LC_ALL`

## Measure running time
### `tictoc`
```
install.packages("tictoc")
library(tictoc)

tic()
Sys.sleep(1)
toc()
```
Output
```
1.003 sec elapsed
```

### Progress bar with `progressr`
https://cran.r-project.org/web/packages/progressr/vignettes/progressr-intro.html


## Misc

### Logical
#### How to check `value == integer(0)`

```
value = integer(0)

identical(value, integer(0))
# [1] TRUE

is.integer(value) && length(value) == 0
# [1] TRUE
```

#### Use inherits

```
> class(1L)
[1] "integer"
> is.numeric(1L)
[1] TRUE
> is(1L, "numeric")
[1] TRUE
> inherits(1L, "numeric")
[1] FALSE
```

### Notification

```
system("say Just finished!")
# then the computer will speak "Just finished"
system("say -v Kathy Just finished!")
# this time, Kathy (some other voice) will speak

library(beepr)
beep()
# beep

browseURL('https://www.youtube.com/watch?v=QH2-TGUlwu4')
# open a URL (this one is Hikaru Utada "wait and see")
```

### Odd and even
* 50 odd numbers and 50 even numbers

```
(1:50)*2 - 1

(1:50)*2
```

### `.Last.value`
* The value of the internal evaluation of a top-level R expression is always assigned to .Last.value (in package:base) before further processing (e.g., printing).
* You can obtain the last evaluation.

### Detach packages

```
detach("package:[yourpackage]", unload=TRUE)

detachAllPackages <- function() {

  basic.packages <- c("package:stats",
  "package:graphics",
  "package:grDevices",
  "package:utils",
  "package:datasets",
  "package:methods",
  "package:base")

  package.list <- search()[ifelse(unlist(gregexpr("package:",search()))==1,TRUE,FALSE)]

  package.list <- setdiff(package.list,basic.packages)

  if (length(package.list)>0)  for (package in package.list) detach(package, character.only=TRUE)

}

detachAllPackages()
```

### Compare a utility to compare two R objects

```
all.equal()
```

### To delete the `attr` (`names`)

```
unname(obj)
```

### Extract file name as character

```
a <- data.frame()
deparse(substitute(a))
[1] "a"
```

### Check existence of directory

```
mainDir <- "c:/path/to/main/dir"
subDir <- "outputDirectory"

if (file.exists(subDir)){
    setwd(file.path(mainDir, subDir))
} else {
    dir.create(file.path(mainDir, subDir))
    setwd(file.path(mainDir, subDir))

}
```

### askYesNo
* Standard way to ask a yes/no question to users
* Yes, No, cancel return TRUE, FALSE, NA respectively

```
askYesNo(msg = "Do you like R?")

# use 1/2/3 for yes/no/cancel
askYesNo(msg = "Do you like R?", prompts = "1/2/3")
```

### Installing `units` package
* You need to specify both `--with-udunits2-include` and `--with-udunits2-lib`

```
install.packages("units", configure.args = c("--with-udunits2-include=/opt/homebrew/Cellar/udunits/2.2.28/include", "--with-udunits2-lib=/opt/homebrew/Cellar/udunits/2.2.28/lib"))
```

### Keep R awake
* Use caffeinate command in macOS

```
system("caffeinate -dim", wait = FALSE)
```

* To stop, use `killall caffeinate`


## Update
* Use `https://cloud.r-project.org/bin/macosx/base/` to find binariles of R builds for macOS
* Remove existing R and RStudio before upgrading R

```
$ sudo rm -rf /Applications/R.app
$ sudo rm -rf /Library/Frameworks/R.framework
```



[1]:https://stackoverflow.com/questions/9397664/force-r-not-to-use-exponential-notation-e-g-e10
[latexexp]:https://cran.r-project.org/web/packages/latex2exp/vignettes/using-latex2exp.html