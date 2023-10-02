# Rcpp

## Vector

### Subset vector by bool vector in Rcpp

```
#include <Rcpp.h>
// [[Rcpp::plugins(cpp11)]]

// [[Rcpp::export]]
Rcpp::NumericVector subset1() {
  Rcpp::NumericVector in = {1.0, 2.0, 3.0, 4.0};
  Rcpp::LogicalVector mask = {false, true, true, true};
  return in[mask];
}

// [[Rcpp::export]]
Rcpp::NumericVector subset2() {
  Rcpp::NumericVector in = Rcpp::runif(10);
  Rcpp::LogicalVector mask = in > 0.5;
  return in[mask];
}

/*** R
subset1()
set.seed(42)
subset2()
*/
```

## Matrix

### Create a matrix from a vector


```
#include <Rcpp.h>

// [[Rcpp::export]]
Rcpp::NumericMatrix vec2mat(Rcpp::NumericVector vec, int n, int k) {
    Rcpp::NumericMatrix mat = Rcpp::no_init(n, k);
    for (auto i = 0; i < n * k; i++) mat[i] = vec[i];
    return mat;
}

// [[Rcpp::export]]
Rcpp::NumericMatrix vec2mat2(Rcpp::NumericVector vec, int n, int k) {
    Rcpp::NumericMatrix mat(n, k, vec.begin());
    return mat;
}

/*** R
v <- (1:9) * 1.0  # numeric
vec2mat(v, 3, 3)
vec2mat2(v, 3, 3)
*/
```
