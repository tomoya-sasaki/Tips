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