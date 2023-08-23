# SQL

## MySQL
* Official tutorial document [here](https://dev.mysql.com/doc/mysql-getting-started/en/)
* Documentation [here](https://dev.mysql.com/doc/refman/8.1/en/)

### Installation
* Install with homebrew: references [here](https://www.novicedev.com/blog/how-install-mysql-macos-homebrew), [here](https://hackernoon.com/how-to-install-mysql-8-on-macos-using-homebrew)

### Create new table from a csv file
* `LOAD DATA INFILE` or `mysqlimport`. References [here](https://dev.mysql.com/doc/refman/8.1/en/mysqlimport.html), [here](https://www.mysqltutorial.org/import-csv-file-mysql-table/), [here](https://stackoverflow.com/questions/3635166/how-do-i-import-csv-file-into-a-mysql-table)
* If you use `LOAD DATA INFILE`, you need to create an empty table beforehand
* `mysqlimport` does not require you to create an empty table

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