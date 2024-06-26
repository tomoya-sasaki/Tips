# 4

rm(list= ls())

(y <- seq(1, 10, length.out = 5))

#surrounding the assignment with parentheses, which causes assignment and “print to screen” to happen.
# カッコで囲むと、プリントしてくれる


# =====================
# 5
rm(list = ls())

library(nycflights13)
library(tidyverse)

# Pick observations by their values (filter()).
# Reorder the rows (arrange()).
# Pick variables by their names (select()).
# Create new variables with functions of existing variables (mutate()).
# Collapse many values down to a single summary (summarise())

# 1. The first argument is a data frame.
# 2. The subsequent arguments describe what to do with the data frame, using the variable names (without quotes).
# 3. The result is a new data frame.

##############################################################################
# 5.2
filter(flights, month == 1, day == 1)

# you can do
filter(flights, month < 2)
filter(flights, month > 2)
filter(flights, month != 2)
filter(flights, month <= 2)
filter(flights, month >= 2)

# Computers use finite precision arithmetic (they obviously can’t store an infinite number of digits!) so remember that every number you see is an approximation. Instead of relying on ==, use near()
# bad example
sqrt(2)^2 == 2
# good example 
near(sqrt(2)^2, 2)

# you can also do
filter(flights, month == 11| month == 12) # november or feburary
filter(flights, month %in% c(11, 12)) # november or feburary

# !(x & y) is the same as !x | !y
# and !(x | y) is the same as !x & !y
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

# NAs 
NA == NA
#> [1] NA
#It’s easiest to understand why this is the case with a bit more context:
# Let x be Mary's age. We don't know how old she is.
x <- NA
# Let y be John's age. We don't know how old he is.
y <- NA
# Are John and Mary the same age?
x == y
#> [1] NA
# We don't know!

# check whether NA or not
x <- NA
is.na(x)

# include NA in filter or other functions
df <- tibble(x = c(1, NA, 3))
filter(df, x >1) # does not include NA
filter(df, x >1 | x > 1) # include NA

# 5.2.4 excersize
# 1.1
filter(flights, arr_delay >= 2)
# 1.2 
filter(flights, dest %in% c("IAH", "HOU")) # you need "" for chr class
# 1.5 
filter(flights, !is.na(dep_delay), dep_delay >= 60, dep_delay - arr_delay > 30)
# 60分以上遅れたが、30分以上遅れを取り戻したパターン

# 2
filter(flights, between(month, 7, 9))

# 3
filter(flights, is.na(dep_time))


##############################################################################
# 5.3
arrange(flights, year, month, day)
# If you provide more than one column name, each additional column will be used to break ties in the values of preceding columns:

arrange(flights, desc(arr_delay))
# Use desc() to re-order by a column in descending order:
# 降順、多い順

# missing values always sort at the end 

# 5.3.1
# 1
arrange(flights, !is.na(arr_time)) 
# is.na()だと昇順でNAが最後に来るから、!is.na()として降順にした
arrange(flights, desc(is.na(arr_time)))
# same as above

# 2
arrange(flights, desc(dep_delay))
arrange(flights, dep_time)

# 3
arrange(flights, air_time)

# 4
arrange(flights, distance)


##############################################################################
# 5.4
# select variables year, month, and day
dplyr::select(flights, year, month, day)
# you need `dplyr::` because there is multiple `select` function including MASS

# select variables between yaar and day (inclusive)
dplyr::select(flights, year:day)

# select variables except those between yaar and day (inclusive)
dplyr::select(flights, -(year:day))

# starts_with("abc"): matches names that begin with “abc”.
# ends_with("xyz"): matches names that end with “xyz”.
# contains("ijk"): matches names that contain “ijk”.
# matches("(.)\\1"): selects variables that match a regular expression. This one matches any variables that contain repeated characters. You’ll learn more about regular expressions in strings.
# num_range("x", 1:3): matches x1, x2 and x3

# rename the column
rename(flights, tail_num = tailnum) # older one on the right and the new one on the left

# put chosen columns to the start of the data frame
dplyr::select(flights, time_hour, air_time, everything()) # everything() put everything else after `time_hour` and `air_time`

# select with string match
dplyr::select(flights, matches("^(dep|arr)_(time|delay)$"))
# `^` to indicate to match with the string that starts with the words in the following blacket
# `$` to indicate to match with the string that ends with the words in the preceding blacket


# 5.4.1
# 3
vars <- c("year", "month", "day", "dep_delay", "arr_delay")
select(flights, one_of(vars))
# select the columns in `vars`

# 4 
# `contains` has some conflict with other packages
# you need
dplyr::select(flights, dplyr::contains("time"))
# The one_of vector allows you to select variables with a character vector rather than as unquoted variable names. It’s useful because then you can easily pass vectors to select().


##############################################################################
# 5.5
flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time)
mutate(flights_sml, gain = arr_delay - dep_delay, speed = distance / air_time * 60)
# adding new columns in the end of the dataframe

mutate(flights_sml, gain = arr_delay - dep_delay, speed = distance / air_time * 60, gain_per_hour = gain / hours)
# you can use columns that you have just created

transmute(flights, gain = arr_delay - dep_delay, speed = distance / air_time * 60)
# only keep new variables

# 5.5.1
# %/% (integer division) and %% (remainder), 
# All else being equal, I recommend using log2() because it’s easy to interpret: a difference of 1 on the log scale corresponds to doubling on the original scale and a difference of -1 corresponds to halving.

x <- 1:10
lag(x) # take lagging variabe
lead(x) # take leading variables
cumsum(x) # cumulative sum
cummean(x) # take cumulative mean
min_rank(x) # ranking, default gives smallest values the small ranks
min_rank(desc(x)) # ranking, gives smallest values the largest ranks
# > desc(x)
# [1]  -1  -2  -3  -4  -5  -6  -7  -8  -9 -10

y <- c(1,2,2,NA,4,5)
row_number(y) # give an id skipping NA
row_number(y)
#> [1]  1  2  3 NA  4  5
dense_rank(y)
#> [1]  1  2  2 NA  3  4
percent_rank(y)
#> [1] 0.00 0.25 0.25   NA 0.75 1.00
cume_dist(y)
#> [1] 0.2 0.6 0.6  NA 0.8 1.0delay <- summarise()

# 5.5.2
# 1
dplyr::transmute(flights, dep_time_new = dep_time%%100 + dep_time%/%100 * 60) 
# or aliternatively
time2mins <- function(x) {
  x %/% 100 * 60 + x %% 100
}
dplyr::transmute(flights, dep_time_new = time2mins(dep_time)) 

# 2
dplyr::mutate(flights, air_time2 = arr_time - dep_time) %>% dplyr::select(air_time, air_time2)
# the problem of the different time-zones
# also naively take the difference between arr_time and dep_time does not make sense since the scaling is different 

# 3
dplyr::select(flights, dep_time, sched_dep_time, dep_delay) %>% mutate(diff = time2mins(dep_time) - time2mins(sched_dep_time))

# 4 delayed flight == departure is delayed
dplyr::select(flights, arr_delay) %>% arrange(arr_delay, ties.method = minimum)
# answer
mutate(flights, dep_delay_rank = min_rank(-dep_delay)) %>%
  arrange(dep_delay_rank) %>% 
  filter(dep_delay_rank <= 10) %>%
  dplyr::select(dep_delay_rank, dep_delay) 

# 5
# 6


##############################################################################
# 5.6
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, day))
# by using group_by, the unit of analysis becomes the unique combination of year, month, and day, which is "grouped" by group_by


# 5.6.1
by_dest <- group_by(flights, dest)
# class(by_dest)
# [1] "grouped_df" "tbl_df"     "tbl"        "data.frame"

by_dest %>% summarise(count= n(), dist = mean(distance, na.rm = T), delay = mean(arr_delay, na.rm = T)) %>% filter(count > 220, dest != "HNL")
# `n(x)` for a countof x, here count destination
# `sum(!is.na(x))` for a count of non-missing values

# 5.6.3
not_cancelled <- flights %>% 
	filter(!is.na(dep_delay), !is.na(arr_delay)) 

flights %>% 
	filter(!is.na(dep_delay), !is.na(arr_delay)) %>% 
	group_by(tailnum) %>%  
	summarise(delay = mean(arr_delay)) %>% 
	ggplot(mapping = aes(x = delay)) + 
		geom_freqpoly(binwidth = 10)
# `geom_freqpoly` create plots for frequent function


flights %>% 
	filter(!is.na(dep_delay), !is.na(arr_delay)) %>% 
	group_by(tailnum) %>%  
	summarise(mean_delay = mean(arr_delay, na.rm = T), n = n()) %>% # count the number of flight per each tailnum
	ggplot(mapping = aes(x = n , y = mean_delay)) +
		geom_point(alpha = 1/10) # the plot show the average delay for each flight


library(Lahman)
batting <- as.tibble(Lahman::Batting)

batters <- batting %>%
	group_by(playerID) %>%
	summarise(ba = sum(H, na.rm = T) / sum(AB, na.rm = T), ab = sum(AB, na.rm = T)) 
# ab: 打席
# ba: 打率

batters %>%
	filter(ab > 100) %>%
	ggplot(mapping = aes(x = ab, y = ba)) +
		geom_point() + 
		geom_smooth(se = F)


# 5.6.4
not_cancelled %>%
	group_by(year, month, day) %>%
	summarise(first = min(dep_time), last = max(dep_time))
# first and last flight of each day
not_cancelled %>%
	group_by(year, month, day) %>%
	summarise(first = first(dep_time), last = last(dep_time))
# same as above
# other sumary functions: quantile(x, 0.25)

not_cancelled %>%
	group_by(year, month, day) %>%
	mutate(r = min_rank(desc(dep_time))) %>%  # dep_timeに応じてrank付けした新しいcolumnを作成した
	filter(r %in% range(r)) %>% # group_byはここで聞いてくるようだ、1位と最下位を返す
	dplyr::select(month, day, r, dep_time)

not_cancelled %>% 
	group_by(dest) %>%
	summarise(carriers = n_distinct(carrier)) %>% # summarise the unique number of carrier using this destination per each destination
	arrange(desc(carriers)) 

not_cancelled %>% 
	group_by(dest) %>%
	summarise(carriers = n()) %>% # count the number of planes landed for each destination per each destination
	arrange(desc(carriers)) 

not_cancelled %>%
	count(dest)
not_cancelled %>% 
	group_by(dest) %>%
	summarise(carriers = n())
# above two give same result

not_cancelled %>%
	count(tailnum)

not_cancelled %>%
	count(tailnum, wt = distance)
# count the number of `tailnum` and weight it by `distance`
# to understand more, use the code below
(df <- data.frame(weight = c(1,2,2,2,3,3,3,3), num = c(1,1,1,1,2,2,2,2)))
df %>% count(num, wt = weight)
df %>% count(num)
##########################################################

not_cancelled %>%
	group_by(year, month, day) %>%
	summarise(n_early = sum(dep_time < 500))
# take sum for dep_time < 500


# 5.6.5
daily <- group_by(flights, year, month, day)
(per_day <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = n())) # this sums up the number of days
(per_month <- summarise(per_day, flights = sum(flights)))

(per_year <- summarise(per_month, flights = sum(flights)))

# 5.6.6
daily %>% ungroup() %>% summarise(flights = n())
summarise(flights, flights = n())
# the above two give same results

# 5.6.7
# 1
flights %>% 
	group_by(flight) %>%
	summarise()
	count(flights = sum() )

# 4
flights %>% 
	mutate(cancelled = (is.na(arr_delay) | is.na(dep_delay))) %>%
	group_by(year, month, day) %>%
	summarise(mean_cancel = mean(cancelled), avg_dep_delay = mean(dep_delay, na.rm = T)) %>%
	ggplot(mapping = aes(y = mean_cancel, x = avg_dep_delay)) +  # reverse x and y will gives you different quite differenet plot
		geom_point() +
		geom_smooth()


#################################################
# 5.7
flights_sml %>%
	group_by(year, month, day) %>%
	filter(rank(desc(arr_delay)) < 10) 
# worst 9 delayed flights for each day

popular_dests <- flights %>% 
  group_by(dest) %>% 
  filter(n() > 365)
# 365回以上の着陸がない空港をデータセットから排除した
# この段階では、未だデータセットの観察の単位は各フライト毎になっている


# 5.7.1
# 2
flights %>% 
	dplyr::select(month:arr_time, tailnum) %>%
	arrange( desc(dep_delay) ) #  or maybe desc(arr_delay)

flights %>%
	group_by(tailnum) %>%
	summarise(arr_delay = mean(arr_delay, na.rm = T)) %>%
	filter (rank(desc(arr_delay)) <= 1)
# ungroup() is inserted between summarise() and filter() in the answer code, but you do not need it

# 3
flights %>%
	group_by(hour) %>%
	summarise(mean_delay = mean(arr_delay, na.rm = T)) %>%
	arrange(desc(mean_delay))
# there is no flight in 1 AM

# 4
flights %>%
	group_by(year, month, day) %>%
	filter(!is.na(dep_delay)) %>%
	mutate(lag_delay = lag(dep_delay))
# the method of answer is not good

# 7
# experiment
flights %>%
	dplyr::select(dest, carrier) %>%
	count(dest, carrier)
flights %>%
	group_by(dest, carrier)
	dplyr::select(dest, carrier) %>%
	count(carrier)
# botht two gives same results

# answer
flights %>%
#	group_by(dest, carrier) %>%
	dplyr::select(dest, carrier) %>%
	count(dest, carrier) %>%
	summarise(n())
# you do not need group_by if you put both variables in `count()`

flights %>%
	group_by(dest, carrier) %>%
	dplyr::select(dest, carrier) %>%
	count(carrier) %>%
	summarise(n())
# since `group_by` for both `dest` and `carrier`, you need additional line

flights %>%
	group_by(dest) %>%
	dplyr::select(dest, carrier) %>%
	summarise(count = n_distinct(carrier))
# just `group_by` for `dest`, the last line gives you count carrier per each dest