# SQL

## MySQL
* Official tutorial document [here](https://dev.mysql.com/doc/mysql-getting-started/en/)

## Variable name
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

## Computing new columns
### Compute moving average

```
select date, amount, avg(amount) over (order by visited_on range interval 6 day preceding)
from Current_table
```

### mutiply columns and then sum rows
* for each payment_id

```
SELECT payment_id, SUM(`unit cost` * quantity) AS total
FROM myTable
GROUP BY payment_id
```

## Numeric
```
select round (25.125, 2) as roundvalue
```

## Character

### Add string

```

SELECT PayerDate, '$' + CAST(PaymentAmount AS VARCHAR(15)) PaymentAmount
FROM   Payments
```

### Substring

```
SUBSTR(string, start, length)

SELECT SUBSTR("SQL Tutorial", 5, 3) AS ExtractString;
```

## Debugging

* Error: `MYSQL ERROR 1248 (42000): Every derived table must have its own alias`
* Each derived table must have an alias. `SELECT a.* FROM (SELECT ....)a`

```
SELECT xxx.* FROM
(
    SELECT ....
    FROM ....
    UNION
    (
       SELECT ....
       FROM .....
       LIMIT 46
    )
    LIMIT 50
)xxx
```