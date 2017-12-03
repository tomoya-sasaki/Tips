# R code tips

## Implement R in terminal
For detail, check [here](http://qiita.com/doskin/items/5e3877f110af244f7b59)
```
R --vanilla --slave < file_name.R
```
* `--vanilla`: このオプションを付けると、R がこれまでに保存していたオブジェクトを使用しないプレーンな状態で実行する
* `--slave`: このオプションを付けると、R の出力を標準出力に出力しない


## Open R in English in terminal
* Type `LC_ALL=en_US.UTF-8 R` to start R
* See [here](https://stackoverflow.com/questions/19781008/r-language-setting-cant-be-change-with-default-writes-command-on-mac), [here](https://stackoverflow.com/questions/12642651/in-r-how-to-get-error-messages-in-english), or [here](https://stackoverflow.com/questions/13575180/how-to-change-language-settings-in-r). See [here](http://qiita.com/methane/items/dac75ef5019b311a0f10) for some details of `LC_ALL`


## Save and Load
### Use Rdata
* `save(list=ls(), file = "[filename].Rdata"` to save the all objects in the console (plot, data.frame, etc)
* If you want to save specific objects (e.g. `df` and `elapsed_time`) then you use `save(list = c("df", "elapsed_time"), file = "[filename].Rdata")` to save the objects

### Use other objects
* See [here](http://www.fromthebottomoftheheap.net/2012/04/01/saving-and-loading-r-objects/) or [here](https://www.trifields.jp/how-to-save-or-read-object-in-r-1397).
* The method below can contain only one objects, but this method doesn't save both the object and its name, rather it just saves a representation of the object. As a result, the saved object can be loaded into a named object within R that is different from the name it had when originally serialized.
```
res <- lm(y~x)

## Write object
saveRDS(res, file = "lm.obj")

## Read object
obj2 <- readRDS("lm.obj")
```

## Regular Expression, print family?
### sprintf
#### basic format
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

### colr
* To manipulate colnames and rownames. See `colr.R`.

### formattr
* To manipulate (join) strings. See `formattr.R`.

# Write file
## Write as csv
* `write.csv()` cannont ignore column names.
* If you want to ignore column names, you can use `write.table()` instead.

## Write as text
* `write()` and `write.lines()` forced to write `\n` in the last lines.

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