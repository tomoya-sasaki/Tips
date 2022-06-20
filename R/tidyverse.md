# `tidyverse`

## `bind_rows` and `bind_cols`
* Bind matrices or dataframes in a list into a single matrix of dataframe

```
bind_rows(list_of_df) # do.call("rbind", list_of_df) also works
bind_cols(list_of_df) # do.call("cbind", list_of_df) also works
```

## `dplyr` and `plyr`
* Sometimes `group_by` function of `dplyr` does no work.
* "Best answer is to load plyr ALWAYS before dplyr, AND not load plyr again. Pasting his tweet for reference." For detail, [here][1].

## `group_by`

### `group_by` inside functions

* You need quotes.
 
```
library(rlang)
mytable <- function(x, ...) {
  group_ <- syms(...)
  x %>% 
    group_by(!!!group_) %>% 
    summarise(n = n())
}
mytable(iris, "Species")
```

### Select rows within each group with a condition

```
# data
df <- data.frame(ID= rep(1:3, each=3), date=c('02/20/1989',
'03/14/2001', '02/25/1990',  '04/20/2002', '02/04/2005', '02/01/2008',
'08/22/2011','08/20/2009', '08/25/2010' ), stringsAsFactors=FALSE)

# select the mots recent date
df %>% 
  group_by(ID) %>%
  slice(which.max(as.Date(date, '%m/%d/%Y')))
```

## Split a column into two strings

```
before = data.frame(attr = c(1,30,4,6), type=c('foo_and_bar','foo_and_bar_2'))

str_split_fixed(before$type, "_and_", 2)

separate(before$type, into = c("foo", "bar"), sep = "_and_")
```

## Collapse several rows

```
df <- data.frame(a=rep(c("x","y"), 2),
                 b=c("Rome", "Venice", "Barcelona", "Paris"))

# with summarise
df %>%
  group_by(a) %>%
  summarise(b = paste(b, collapse = ", "))

# with nest
df %>%
  mutate(b = as.character(b)) %>%
  nest(b) %>%
  mutate(cityList = map_chr(data, ~paste(.$b, collapse = ", "))) %>%
  select(-data)

```


## Find rows with NA
* Find rows with `NA` in any column

```
df %>% 
  select(var1, var2) %>% 
  mutate(na = rowSums(is.na(.))) %>%
  filter(na > 0)
```


# `readr` 
## Warning column specificaition
* "By default readr only looks at the first 1000 rows. This keeps file parsing speedy, but can generate incorrect guesses. For example, in challenge.csv the column types change in row 1001, so readr guesses the wrong types. One way to resolve the problem is to increase the number of rows" (from readr manual)
* This could be a problem when you are dealing with a giant matrix with a large number of rows.

# `purrr`

* R List of lists to dataframe with list name as extra column

```
ans <- map_df(past_earnings_lists, ~as.data.frame(.x), .id="id")
```


[1]:https://stackoverflow.com/questions/31644739/loading-dplyr-after-plyr-is-causing-issues