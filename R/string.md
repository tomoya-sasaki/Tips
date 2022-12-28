# String in R

## Extract URL
* [here](https://blog.statsbeginner.net/entry/2022/12/28/040830)

```
grep('https?://[\\w!\\?/\\+\\-_~=;\\.,\\*&@#\\$%\\(\\)\'\\[\\]]+', x, perl=TRUE)
```


## 変数名を変えながら値を代入したい
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

[1] "HelloWorld"

y <- paste("Hello", "World", sep = " ")
y
[1] "Hello World"
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

4. Take out last n characters

```
x <- "text in a string"
str_sub(x, -6, -1)
[1] "string"

str_sub(x, max = -6)
[1] "string"
```

5. Remove \n (\r) from strings

```
x <- "foo\nbar\rbax\r\nquux"
gsub("[\r\n]", "", x)

library(stringr)
str_replace_all(x, "[\r\n]", "")
```

6. Read a html file as strings

```
paste(readLines("./path_to_file.html"), collapse = "\n")
```

7. Remove html tags from strings

```
cleanHTML <- function(html_string){
	return( gsub("<.*?>", "", html_string))
}
```

8. Remove punctuation

```
gsub("[[:punct:]]", "", text	)
```

9. Merge Multiple spaces to single space; remove trailing/leading spaces

```
string <- "  Hi buddy   what's up   Bro "
library(stringr)
str_replace(gsub("\\s+", " ", str_trim(string)), "B", "b")
# [1] "Hi buddy what's up bro"
```

10. Removing duplicate words in a string in R

```
str <- "How do I best try and try and try and find?"
d <- unlist(strsplit(str, split=" "))


paste(unique(d), collapse = ' ')

```

11. Trim leading and trailing whitespace 

```
# returns string w/o leading whitespace
trim.leading <- function (x)  sub("^\\s+w", "", x)

# returns string w/o trailing whitespace
trim.trailing <- function (x) sub("\\s+$", "", x)

# returns string w/o leading or trailing whitespace
trim <- function (x) gsub("^\\s+|\\s+$", "", x)

trim(text)
```

Insert a character at a specific location in a string

```
gsub('^([a-z]{3})([a-z]+)$', '\\1d\\2', 'abcefg')
# [1] "abcdefg"
```