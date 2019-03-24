# Table of Contents
1. [Implement R in terminal](# Implement R in terminal)
2. [Open R in English in terminal](# Open R in English in terminal)
3. [Save and Load](# Save and Load)
4. [Write files](# Write filess)
5. [Regular Expression, print family?](# Regular Expression, print family?)
6. [Measure running time](# Measure running time)
7. [Potpourri](# # Potpourri)


# Implement R in terminal
For detail, check [here](http://qiita.com/doskin/items/5e3877f110af244f7b59)

```
R --vanilla --slave < file_name.R
```

* `--vanilla`: このオプションを付けると、R がこれまでに保存していたオブジェクトを使用しないプレーンな状態で実行する
* `--slave`: このオプションを付けると、R の出力を標準出力に出力しない


# Open R in English in terminal
* Type `LC_ALL=en_US.UTF-8 R` to start R
* See [here](https://stackoverflow.com/questions/19781008/r-language-setting-cant-be-change-with-default-writes-command-on-mac), [here](https://stackoverflow.com/questions/12642651/in-r-how-to-get-error-messages-in-english), or [here](https://stackoverflow.com/questions/13575180/how-to-change-language-settings-in-r). See [here](http://qiita.com/methane/items/dac75ef5019b311a0f10) for some details of `LC_ALL`


# Save and Load
## Use Rdata
* `save(list=ls(), file = "[filename].Rdata"` to save the all objects in the console (plot, data.frame, etc)
* If you want to save specific objects (e.g. `df` and `elapsed_time`) then you use `save(list = c("df", "elapsed_time"), file = "[filename].Rdata")` to save the objects
* To load, use `load("[filename].Rdata")`

### Use other objects
* See [here](http://www.fromthebottomoftheheap.net/2012/04/01/saving-and-loading-r-objects/) or [here](https://www.trifields.jp/how-to-save-or-read-object-in-r-1397).
* The method below can contain only one objects, but this method doesn't save both the object and its name, rather it just saves a representation of the object. As a result, the saved object can be loaded into a named object within R that is different from the name it had when originally serialized.

```
res <- lm(y~x)
```

## `rds` object
###Write object

```
saveRDS(res, file = "lm.obj")
```

### Read object

```
obj2 <- readRDS("lm.obj")
```

### When you have trouble using `readRDS`
* You also can use `load()` to read `rds` object.

# Write files
## Write as csv
* `write.csv()` cannont ignore column names.
* If you want to ignore column names, you can use `write.table()` instead.

## Write as text
* `write()` and `write.lines()` forced to write `\n` in the last lines.



# Regular Expression, print family
## sprintf
### basic format
* `sprintf("%f", int)`: Count and print the string from left (from right if negative) until a decimal point, default number is 6. If the string is more than 6, it keep the string and if less it create 0 or space.
    
	```
    > sprintf("%f", 5000.000)
	[1] "5000.000000"
	
	> sprintf("%.3f", 5000.000)
	[1] "5000.000"
    	
	> sprintf("%20f", 5000.000)
	[1] "         5000.000000"
    	
	> sprintf("%-20f", 5000.000)
	[1] "5000.000000         "
    	
	> sprintf("%-20.f", 5000.000)
	[1] "5000                "
	
	> sprintf("%-20.1f", 5000.000)
	[1] "5000.0              "
	```
	
* `sprintf("%s, string)`: Count and print the string from the left (from right if negative). 
	
	```
    > sprintf("%s", "abcde")
	[1] "abcde"
	
	> sprintf("%.1s", "abcde")
	[1] "a"
    	
	> sprintf("%.s", "abcde")
	[1] ""
    	
	> sprintf("%.100s", "abcde")
	[1] "abcde"
	```
	
### Use `sprintf` inside a loop
* Use `cat`

	```
	for (i in 1:5){
		cat(sprintf("i = %d", i))
	}
	```
	
### Avoid scientific notation with `sprintf`
* You can also use `sprintf` to avoid scientific notation.

```
# %s for string
sprintf("Current working dir: %s", wd)

# %d for integer
sprintf("Current working dir: %d", id)

# %f for numeric
sprintf("Current working dir: %f", value)

# to show the width and precision
sprintf("precision %.*f", 3, pi)
[1] "precision 3.142"

sprintf("width '%*.3f'", 8, pi)
[1] "width '   3.142'"

# you can also control precision with the value before "f"
# if you want to control both width and precision, use the following expression
sprintf("width '%*.5f'", 8, pi)
[1] "width ' 3.14159'"
```

## Use latex in R plots
* `latex2exp` parses and converts LaTeX math formulas to R’s plotmath expressions. For detail, see [here][latexexp]

```
TeX('$\\alpha^\\beta$')
```
## Avoid scientific/exponential notation
* Check [here][1]
* For one shot change

```
format(1810032000, scientific = FALSE)
```

* Force to change with options

```
options("scipen"=-100, "digits"=4)
```

## colr
* To manipulate colnames and rownames. See `colr.R`.

## formattr
* To manipulate (join) strings. See `formattr.R`.

## Extracting the last n characters from a string

```
x <- "some text in a string"

substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}

substrRight(x, 6)
[1] "string"
```

# Class
## factor
### How to sort
```
d <- data.frame(x = c(1,2,1,2,3,4), y = c("1", "2", "10","1", "2", "10") )
tapply(d$x, d$y, mean)
>>   1  10   2 
>> 1.5 2.5 2.5
```
`1 10 2`という並びを`1 2 10`にしたいとき

```
factor_level = c("1", "2", "10")
# sortして　作り直す
d$y <- factor(d$y, levels = factor_level)

tapply(d$x, d$y, mean)
>>   1   2  10
>> 1.5 2.5 2.5
```

# Measure running time
## `tictoc`
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


# Potpourri


## Logical
### Check `value == integer(0)`

```
value = integer(0)

identical(value, integer(0))
# [1] TRUE

is.integer(value) && length(value) == 0
# [1] TRUE
```

## Notification

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

## Odd and even
* 50 odd numbers and 50 even numbers

```
(1:50)*2 - 1

(1:50)*2
```

## `.Last.value` 
* The value of the internal evaluation of a top-level R expression is always assigned to .Last.value (in package:base) before further processing (e.g., printing).
* You can obtain the last evaluation.

## Detach packages

```
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

## Compare a utility to compare two R objects

```
all.equal()
```

## To delete the `attr` (`names`)

```
unname(obj)
```

## Extract file name as character

```
a <- data.frame()
deparse(substitute(a))
[1] "a"
```


[1]:https://stackoverflow.com/questions/9397664/force-r-not-to-use-exponential-notation-e-g-e10
[latexexp]:https://cran.r-project.org/web/packages/latex2exp/vignettes/using-latex2exp.html
