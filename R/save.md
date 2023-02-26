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

## Save output
* Save both outputs and messages [here](https://stackoverflow.com/questions/7096989/how-to-save-all-console-output-to-file-in-r)

```
con <- file("test.log")
# by adding both line, you can save all messages
sink(con, append=TRUE)
sink(con, append=TRUE, type="message")

# This will echo all input and not truncate 150+ character lines...
source("script.R", echo=TRUE, max.deparse.length=10000)

# Restore output to console
sink() 
sink(type="message")

# And look at the log...
cat(readLines("test.log"), sep="\n")
```

## `rds` object
### Write object

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
