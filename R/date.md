# date
## sequence of dates
* You can specify `by` with "day", "week", "month", "quarter", "year", `difftime` object, or the number of dates

```
seq(as.Date("2020-1-1"), as.Date("2021-12-01"), by = "month")
seq(as.Date("2020-1-1"), as.Date("2021-12-01"), by = 20)
seq(as.Date("2000/1/1"), by = "month", length.out = 12)
```

## sequence of dates and times

* You can specify `by` with "sec", "min", "hour", "day", "DSTday", "week", "month", "quarter", "year", `difftime`, or the number of seconds

```
seq(ISOdate(1910,1,1), ISOdate(1999,1,1), "years")
seq(ISOdate(2000,1,31), by = "month", length.out = 4)
```

## Obtain the day of week

```
df = data.frame(date=c("2012-02-01", "2012-02-01", "2012-02-02"))
lubridate::wday(df$date, label=TRUE) # with label
lubridate::wday(df$date) # with number
```

## Grouping based on time difference
* [here](https://stackoverflow.com/questions/43899898/r-grouping-based-on-time-difference)

```
df <- data.frame(col_1 = c('11/13/2007', '11/17/2007', '11/19/2007', '11/25/2007', '11/28/2007'),
                 col_2 = c('A', 'B', 'C', 'D', 'E'))

df$col_1 <- as.POSIXct(df$col_1, format = "%m/%d/%Y")

lag_time_diff <- difftime(df$col_1, lag(df$col_1, default = df$col_1[1]), units = "days")
df$group <- cumsum(ifelse(lag_time_diff>5,1,0))

df
#       col_1 col_2 group
#1 2007-11-13     A     0
#2 2007-11-17     B     0
#3 2007-11-19     C     0
#4 2007-11-25     D     1
#5 2007-11-28     E     1
```
