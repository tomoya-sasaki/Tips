# variable name
* refrain from using the same variable name as the column name
* Even in R dbplyr

```
# does not filter by year
year <- 1998
df %>% 
	filter(year == year)

# you need to contain 1998 in a variable with a different name
YEAR <- 1998
df %>% 
	filter(year == YEAR)
```