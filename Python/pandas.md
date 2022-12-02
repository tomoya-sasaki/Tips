# Index
## Reset the index
```
df.reset_index(drop = True)
```

# Write and Read
```
# read file
df = pd.read_csv('data.csv')

# write file
df_C.to_csv("Cutpoints_" + model + ".csv")
```

# Adding and deleting rows and columns

## Adding a new column
```
# empty column
# assume you have a dataframe name "df" and want to assingn a new empty column named "temp"
df["temp"] = ""
```

## Dropping a column

```
df.drop('column_name', axis=1)
# 1 is the axis number (0 for rows and 1 for columns.)
```

## Plot
```

```

## Column bind or concatenate columns of two dataframes

```
import pandas pd
 
pd.concat([df1, df2], axis=1, ignore_index=True)
```

## Create binary variables from a categorical variable

```
pd.get_dummies(df)
```