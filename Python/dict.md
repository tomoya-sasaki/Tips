# General Explanaation

A dictionary is a data structure that maps one value to another (key and value). You can use curly braces ( {} ) to define dictionary.
In the case below, `a` and `b` are the keys and `apple` and `banana` are the values.
See [here](1).
```
>>> d1 = {'a': 'apple', 'b' : 'banana'}
```
# Extract data
## Extract values
```
>>> print(d1.values())
dict_values(['apple', 'banana'])
```
## Extract keys
```
>>> print(d1.keys())
dict_keys(['a', 'b'])
```
## Extract both keys and values
```
>>> print(d1.items())
dict_items([('a', 'apple'), ('b', 'banana')])
```
## Extract both values separately
* Easy method when you search inside the dictionary

```
>>> for k, v in d1.items():
>>> 	print("k", k, "v", v)
k a v apple
k b v banana
```
[1]:https://qiita.com/shinjikoike/items/9f0f7ae716bce77a1b8a