## General Explanations
A set object is an unordered collection of distinct hashable objects. 
A set tyoe is mutable- the contents can be changed using methods like `add()` and `remove()`. However, sine it is mutable, it has no hash value and cannot be used as either a dictionary key or as an element of another set. 

A frozenset is immutable and hashable- its contents cannont be altered after it is created and therefore you can use it as a dictionary key or as an element of another set.

```
# create set
n1 = set ('123')
n2 = {2,3,4}
# both n1 and n2 are sets

n1 & n2
>>> set (['3','2'])
n1 | n2
>>> set(['1','2','3','4'])

# blank set
z1 = {} # incorrect
z1
>>> {}
z2 = set()
z2 
>>> set([])
```

