# Implementation
## Compile Cython (*.pyx) file
```
$ python setup.py build_ext --inplace
```
## Then main.py
```
$ python main.py
```
## 計算
* [参考1](https://github.com/cython/cython/blob/master/Cython/Includes/libc/math.pxd)、[参考2](https://gist.github.com/fccoelho/757090)、[参考3](https://stackoverflow.com/questions/32341152/incomplete-gamma-functions-can-this-code-get-any-faster-in-cython-c-or-fortra)
```
cdef extern from "math.h":
    double log (double x) nogil
    double exp (double x) nogil
    double lgamma (double x) nogil
    double tgamma (double x) nogil

```

## Compare speed
See [here][1] and [here][2]
```



```

## Import functions in cython
* To call functions in cython from other file, you need to have it in Python object in the origin file (`def` not in `cdef`).
* You can call the object in either Python or Cython object.
### Example
* In main cython file
```
from origin import func

>>> def test(double x):
>>> 	return func(x)

>>> def test2(double x):
>>> 	return testc.func(x)

>>> cdef testc (double x):
>>> 	return func(x)
```
* In the origin cython file (`origin.py`)
```
>>> def func(x):
>>> 	return func_c(x)

>>> cdef func(x):
>>> 	return x*2
```

[1]:
[2]: