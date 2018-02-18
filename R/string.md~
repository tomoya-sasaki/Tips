## String in R

### 変数名を変えながら値を代入したい
[参考](http://futabooo.hatenablog.com/entry/20110910/1315634652)
1.  値を代入する
```
a <- 10
assign(a, 10)
# the above two examples return same results
```

2. 文字列を結合する
```
x <- paste("Hello", "World", sep = "")
x
>> "HelloWorld"

y <- paste("Hello", "World", sep = " ")
y
>> "Hello World"
```

3. 両者を合わせる
```
for (i in 1:10){
    assign( paste("x", i, sep = ""), i )
}
```
3-1. ファイル名を変えながら、上のデータを各々書き出す
```
for ( i in 1:10 ){
	filename <- paste("x", i, sep = "")
	write.csv(get(paste("x", i, sep = "")), filename)
}
```






