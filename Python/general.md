# General syntax
## `for` loop
```
>>> for i in range(3):
>>> 	print(i)
0
1
2

>>> for i in range(0,3):
>>> 	print(i)
0
1
2

>>> for i in range(2, -1, -1):
>>> 	print(i)
2
1
0
```

## More and less
* `10:`: more than 10 (does not include 10th object)
* `:10`: less than 10 (does not include 10th object)

## Add/subtract/multiple/divide and assign new value
```
i = 2
i += 3
i
# 5

i = 2
i *= 3
i
# 6

i = 2
i /= 3
i
# 0.666666666...
```

## Copying the objects
Since ` = ` in Python just create the reference to the list, not the copies of actual list, you need to copy the list in order to keep the original list while modifying the new list (refer [here](http://stackoverflow.com/questions/23200969/how-to-clone-or-copy-a-set-in-python))

```
# you can slice
new_list = old_list[:]

# you can create new list by list() function
new_list = list(old_list)

# you can copy 
import copy
new_list = copy.copy(old_list)
new_lsit = old_list.copy() # equivalent to above, but recommmend above method

# if the list contains the objects and you want to copy them as well, you can use deepcopy. 
#If you use the method above, you cannot create the copy of the objects in the list, rather the reference to the older list.
import copy
new_list = copy.deepcopy(old_list)
```

# class method
## @staticmethod
By using static method, you could change the part of the logic of the method inside and you can override with sub-class.

```
class Parent(object):

    def __init__(self, text):
        self.text = text

    @staticmethod
    def newlines(s):
        return s.replace('\n','\r')

    def printer(self):
        return self.newlines(self.text)

class Child(Parent):

  @staticmethod
  def newlines(s):
    return s.replace('\n\r', '\n')

p = Parent('\n\r')
p.printer()
>>> '\r\r'

p = Child('\n\r')
p.printer()
>>> '\n'
# This means that Child class override with Parent but changing the logic of `newlines`.
``` 

## Use of object and class method
```
class Parent(object):

    class_var = 'parent_class_var'

    @classmethod
    def class_method(cls):
        print('cls: {}'.format(cls))
        print("class_var: {}".format(cls.class_var))

    @staticmethod
    def static_method(raw_str):
        print(raw_str.strip())

if __name__ == '__main__':
    raw_str = 'He has been fired\n'
    # cls: <class '__main__.Parent'>
    # class_var: parent_class_var
    Parent.class_method()
    # He has been fired
    Parent.static_method(raw_str)

    parent = Parent()
    # cls: <class '__main__.Parent'>
    # class_var: parent_class_var
    parent.class_method()
    # He has been fired
    parent.static_method(raw_str)
```

## Profile
```
$ python -m cProfile -o main.profile -s time main.py
```
`-m cProfile` to profile, `-o main.profile` to save, and `-s ncalls` to sort by number of the function called, and `-s time` to sort by spent time. For detail, see [here][1]

[1]:http://blog.amedama.jp/entry/2016/08/30/214718

## move files
```
## move one file
import shutil
shutil.copyfile('origin', 'destination')
shutil.copy('origin', 'destination')

## if you also copy meta-data
shutil.copy2('origin', 'destination')

## move all files in a folder to a new folder
shutil.copyfile('origin', 'destination')

## ir you move all files to a existing folder
from distutils import dir_util
dir_util.copy_tree('origin', 'destination')

## move whole path
import shutil
shutil.move('old path', 'new path)
```

# Speed
## Calculate sqrt
* Using `x**.5` is faster than `numpy.sqrt(x)`
```
>>> start = time.time()
>>> for i in range(100000):
>>>     np.sqrt(10000)
>>> end = time.time()
>>> print(end - start)
0.14058399200439453

>>> start = time.time()
>>> for i in range(100000):
>>>     10000 ** .5
>>> end = time.time()
>>> print(end - start)
0.008305072784423828
```

## Extend or append a vector
* `append` argument in `list` object is faster than imputing `numpy` object

## Zip a file

```
import shutil
shutil.make_archive(output_filename, 'zip', dir_name)
```

