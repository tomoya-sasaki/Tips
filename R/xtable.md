# xtable

## Print options

* `big.mark`: comma separators
* `decimal.mark`: decimal marks

```
print(xtable(x), format.args = list(big.mark = "'", decimal.mark = ","))
```

* Do not print rownames

```
print(xtable(x), include.rownames = FALSE)
```