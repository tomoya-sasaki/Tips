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