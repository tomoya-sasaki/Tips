# notion

## Functions
* Function to return today
* Note that the column `when` includes information about the date

```
dateBetween(prop("When"), now(), "days") <= -1 or formatDate(prop("When"), "MMM DD, YYYY") == formatDate(now(), "MMM DD, YYYY")
```