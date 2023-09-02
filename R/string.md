# String in R

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

## `format`

* Large numbers separated with commas

```
format(12345.678, big.mark = ",", scientific = FALSE)
[1] "12,345.68"
```

## Use latex in R plots
* `latex2exp` parses and converts LaTeX math formulas to R’s plotmath expressions. For detail, see [here][latexexp]

```
TeX('$\\alpha^\\beta$')
```
## Capitalizing everything after a certain character

* Example: capitalize everything in a character vector that comes after the first
```
gsub("(_.*)","\\U\\1",x,perl=TRUE)
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

## Prevent scientific expression

* Check [here][1]
* For one shot change

```
format(1810032000, scientific = FALSE)
```

* Force to change with options

```
options("scipen"=-100, "digits"=4)
```

* Other methods

```
seq(-.3, .3, .1)
[1] -3.000000e-01 -2.000000e-01 -1.000000e-01  5.551115e-17  1.000000e-01
[6]  2.000000e-01  3.000000e-01

as.character(seq(-.3, .3, .1))
[1] "-0.3"                 "-0.2"                 "-0.1"
[4] "5.55111512312578e-17" "0.1"                  "0.2"
[7] "0.3"

sprintf("%.1f", seq(-.3, .3, .1))
[1] "-0.3" "-0.2" "-0.1" "0.0"  "0.1"  "0.2"  "0.3"
```

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

## Marusuji
* [here](https://qiita.com/taiyodayo/items/f3aa8b55243a5d49a33a)

```
pacman::p_load(tidyverse, stringr)
# 丸数字を通常数字に置き換える
marunum2num <- function(input) {
  maru_all <- "①②③④⑤⑥⑦⑧⑨⑩⑪⑫⑬⑭⑮⑯⑰⑱⑲⑳㉑㉒㉓㉔㉕㉖㉗㉘㉙㉚㉛㉜㉝㉞㉟㊱㊲㊳㊴㊵㊶㊷㊸㊹㊺㊻㊼㊽㊾㊿"
  maru_v <- str_split_1(maru_all, "")
  onetofifty <- 1:50 %>% as.character
  names(onetofifty) <- maru_v
  str_replace_all(input, onetofifty)
}
```