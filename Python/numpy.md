# Calculation
##  `@` and `*` in array
* @ gives you matrix-like multiplication while * gives you direct multiplication of each components of array
```
>>> g = np.array([1,2])
>>> h = np.array([[3,4], [5,6]])

>>> g * h
array([[3,8], [5,12]])

>>> g @ h
array([13, 16])

# array([a1, a2]) * array([[b1, b2], [b3, b4]])
# = array([[a1 * b1, a2 * b2], [a1 * b3, a2 * b4]])
#
# array([a1, a2]) @ array([[b1, b2], [b3, b4]])
# = array([a1 * b1 + a2 * b3, a1 * b2 + a2 * b4])

```

# Extraction
## `np.take`
* You can extract the part of numpy array
```
import numpy as np

>>> A = np.array([[1,2,3], [4,5,6], [7,8,9], [10,11,12]], dtype = np.int32)
>>> A
array([[ 1,  2,  3],
   [ 4,  5,  6],
   [ 7,  8,  9],
   [10, 11, 12]], dtype=int32)

>>> np.take(A, [1,2], axis = 0)
array([[4, 5, 6],
   [7, 8, 9]], dtype=int32)

>>> np.take(A, [1,2], axios = 1)
array([[ 2,  3],
   [ 5,  6],
   [ 8,  9],
   [11, 12]], dtype=int32)
```

## Compare two numpy objects
```
>>> (A==B).all()
True # if A and B are identical numpy arrays
```

## dimension
* `ndim`
```
>>> A.ndim
2

>>> A.shape
(4, 3)

>>> np.take(A, [1], axis = 0).ndim
2
>>> np.take(A, [1], axis = 0)
array([[4, 5, 6]], dtype=int32)
>>> np.take(A, 1. axis = 0)
array([4,5,6], dtype=int32)

>>> A[0].ndim
1
>>> A[0]
array([1, 2, 3], dtype=int32)

>>> A[0:1]
array([[1, 2, 3]], dtype=int32)
>>> A[0:1].ndim
2
```
*　たとえ、numpy.takeやスライスを使うことで、行列が一次元（ベクトル）になっても、dimensionは二次元のままである。そのため、たとえ処理の中でnumpy.takeを用いて一次元になってしまうとしても、cythonの次元の指定の際には、`ndim = 2`のままでよい。
* ただし、一つだけ要素を取ってきた場合(`A[0]`)、dimensionは一次元になる。

# restrict range of each value
```
>>> a = np.array([1,2,3,0,-1,-1])

>>> a[a > 0]
array([1, 2, 3])

>>> a[a != 0]
array([ 1,  2,  3, -1, -1])
```

# change the data type
* Note that when you use some functions in numpy, datatyoe of the object might change. (`np.unique` or `np.sum` etc)
```
>>> a.astype(np.int32)
```

# Read numpy object
```
data = np.loadtxt("data.csv", delimiter=',')
```
If you want to skip first row.
```
data = np.loadtxt("data.csv",delimiter=',', skiprows=1)
```
If you want to skip first column, get the number of the column first to choose the appropriate place before read the file.
```
with open("data.csv") as f:
    ncols = len(f.readline().split(','))
data = np.loadtxt("data.csv",delimiter=',',usecols=range(1,ncols))
```

# How to choose row in numpy
* `np.take` is extremely slow
```
>>> X = np.zeros((30, 20))
>>> ls = range(20)
>>> start = time.time()
>>> for i in range(100000):
>>>     x = np.take(X, ls, axis = 0)
>>> time.time() - start
1.0599021911621094

>>> start = time.time()
>>> for i in range(100000):
>>>     x = X[0:20]
>>> time.time() - start
0.05764293670654297
```

# Set seed
```
>>> numpy.random.seed(123)
```

# Generate random bernoulli 
```
>>> def RBernHand(prob):
>>> 	out = npr.uniform(low = .0, high = 1.0, size = 1)
>>>     if out > prob:
>>>         res = 0
>>>     else:
>>>         res = 1
>>>     return(res)
```
* With probability annealing (simulated annealing)


$$
\beta = 
$$

```
>>> def RBernNumpy (prob):
>>>     r = npr.normal(0, .5, 1)
>>>     beta = math.exp(r)
>>>     new_prob = prob ** beta
>>>     return npr.binomial(1, new_prob), new_prob
```