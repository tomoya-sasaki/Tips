# List
## adding to list
### append
adding new object in the list
```
list = ["a", "b", "c"]
list.append("d")
print (list)
	["a", "b", "c", "d"]
```

### extend
adding another list in the list
```
list.extend(["d", "e"])
print (list)
	["a", "b", "c", "d", "e"]
```

#### if you use append to add another list
```
list.append(["d", "e"])
print (list)
	["a", "b", "c", "d", ["d", "e"]]
```

## tuple and list
### tuple: immutable (cannot change the content, list is mutable)
```
t = ('a', 'b', 'c')

a = (10) # create int
a = (10,) # create tuple, you need comma
```

## enumurate
* return all the index corresponds to the certain item in addition to the content of the list
```
>>> L = ["a", "b", "c"]

>>> for item in L:
>>> 	print (item)
a, b, c

>>> for ind, item in enumurate(L):
>>> 	print (ind, item)
0 a
1 b
2 c

# you can use list comprehension to obtain the all indices which contain the object "b"
>>> [i for i, x in enumurate(L) if x == "b"]
1
```

## create new list
* 10個の空リストを作る
```
>>> dis = {}
>>> for elem in range(10):
      dis[elem] = []
```
* 連続した整数のリストを作成する
```
>>> new_list = list(range(10))
>>> new_list
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
```