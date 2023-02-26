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
