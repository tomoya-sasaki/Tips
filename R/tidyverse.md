# `tidyverse`

## dplyr
### `bind_rows` and `bind_cols`
* Bind matrices or dataframes in a list into a single matrix of dataframe

```
bind_rows(list_of_df) # do.call("rbind", list_of_df) also works
bind_cols(list_of_df) # do.call("cbind", list_of_df) also works
```

### `group_by`

#### `group_by` inside functions

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

#### Select rows within each group with a condition

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

### Collapse several rows

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

### Find rows with NA
* Find rows with `NA` in any column

```
df %>%
  select(var1, var2) %>%
  mutate(na = rowSums(is.na(.))) %>%
  filter(na > 0)
```

### `across` and create new name

```
df |>
  mutate(across(v1:v3, mean, .names = "{col}_mean"))
```

### Dynamically renaming columns

```
i <- 1
# rename column
d |> rename("a.{i}" := a)
# create new column
d |> mutate("a.{i}" := a)
```


### `misc`

#### `between`

```
between(1:12, 7, 9)
#>  [1] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE FALSE FALSE
#> [12] FALSE

mtcars %>% filter(between(row_number(), 1, 10))
```

#### `rank`


```
x <- c(5, 1, 3, 2, 2, NA)
row_number(x)
#> [1]  5  1  4  2  3 NA
min_rank(x)
#> [1]  5  1  4  2  2 NA
dense_rank(x)
#> [1]  4  1  3  2  2 NA
percent_rank(x)
#> [1] 1.00 0.00 0.75 0.25 0.25   NA
cume_dist(x)
#> [1] 1.0 0.2 0.8 0.6 0.6  NA
```

## tidyr
### `nest`

```
> data

  Country   type                           crop
  <chr>     <chr>                          <chr>
1 Australia Set equal to PP  BA, BF, CT, EG, OA
```
* You want to split entries in `crop` separated by each comma

```
data %>%
  mutate(crop_nest = crop) %>%
  nest(crop_nest = crop_nest) %>%
  mutate(crop_sep = map(crop_nest, function(x) strsplit(x[[1]], split = ",")[[1]])) %>%
  # mutate(crop_sep = map(crop, ~str_squish(.x))) %>%
  unnest(crop_sep) %>%
  mutate(crop_sep = str_squish(crop_sep))

# A tibble: 15 × 5
   Country   type             crop               crop_nest        crop_sep
   <chr>     <chr>            <chr>              <list>           <chr>
 1 Australia Set equal to PP  BA, BF, CT, EG, OA <tibble [1 × 1]> "BA"
 2 Australia Set equal to PP  BA, BF, CT, EG, OA <tibble [1 × 1]> "BF"
 3 Australia Set equal to PP  BA, BF, CT, EG, OA <tibble [1 × 1]> "CT"
 4 Australia Set equal to PP  BA, BF, CT, EG, OA <tibble [1 × 1]> "EG"
 5 Australia Set equal to PP  BA, BF, CT, EG, OA <tibble [1 × 1]> "OA"
```

### Fill in missing values

```
fill(data, ..., .direction = c("down", "up", "downup", "updown"))
```


## `dplyr` and `plyr`
* Sometimes `group_by` function of `dplyr` does no work.
* "Best answer is to load plyr ALWAYS before dplyr, AND not load plyr again. Pasting his tweet for reference." For detail, [here][1].

## `stringr`

### Split a column into two strings

```
before = data.frame(attr = c(1,30,4,6), type=c('foo_and_bar','foo_and_bar_2'))

str_split_fixed(before$type, "_and_", 2)

separate(before$type, into = c("foo", "bar"), sep = "_and_")
```


## `readr`
### Warning column specificaition
* "By default readr only looks at the first 1000 rows. This keeps file parsing speedy, but can generate incorrect guesses. For example, in challenge.csv the column types change in row 1001, so readr guesses the wrong types. One way to resolve the problem is to increase the number of rows" (from readr manual)
* This could be a problem when you are dealing with a giant matrix with a large number of rows.

## `purrr`

### Add a column to each dataframe in a list


* R List of lists to dataframe with list name as extra column

```
ans <- map_df(past_earnings_lists, ~as.data.frame(.x), .id = "id")

ans <- map_df(past_earnings_lists, ~as_tibble(.x), .id = "id")
```

* The column name comes from outside

```
# new column name comes from colnames
# make sure to check the length of colnames and list_of_dfs
list_of_dfs %>%
	map2(colnames, ~.x %>% mutate(id = .y))
```

### Use tidyverse functions to each dataframe in a list


```
list_of_dfs %>%
  map(~ .x %>% filter(alpha != 0 & delta != 0))
```

## `magrittr`

### Conditionally applying pipleline step

* Reference [here](https://stackoverflow.com/questions/44001722/conditionally-apply-pipeline-step-depending-on-external-value)


```
# pattern 1
mtcars %>%
	tibble::rownames_to_column(var = "model") %>%
	filter(if(applyfilter== 1) grepl(x = model, pattern = "Merc") else TRUE) %>%
	group_by(am) %>%
	summarise(meanMPG = mean(mpg))

# pattern 2
mtcars %>%
  tibble::rownames_to_column(var = "model") %>%
  {if(applyfilter == 1) filter(., grepl(x = model, pattern = "Merc")) else .} %>%
  group_by(am) %>%
  summarise(meanMPG = mean(mpg))

# pattern 3
mtcars %<>%
  tibble::rownames_to_column(var = "model")

if(applyfilter == 1) mtcars %<>% filter(grepl(x = model, pattern = "Merc"))

mtcars %>%
  group_by(am) %>%
  summarise(meanMPG = mean(mpg))

```


## `lubridate`

* "A date-time is a date plus a time: it uniquely identifies an instant in time (typically to the nearest second). Tibbles print this as <dttm>. Elsewhere in R these are called POSIXct, but I don’t think that’s a very useful name."


[1]:https://stackoverflow.com/questions/31644739/loading-dplyr-after-plyr-is-causing-issues