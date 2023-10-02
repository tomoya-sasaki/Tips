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

### Select columns


```
#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

// [[Rcpp::export]]
arma::mat matrix_subset_idx(const arma::mat& x,
                            const arma::uvec& y) {

    // y must be an integer between 0 and columns - 1
    // Allows for repeated draws from same columns.
    return x.cols( y );
}


// [[Rcpp::export]]
arma::mat matrix_subset_logical(const arma::mat& x,
                                const arma::vec& y) {
    // Assumes that y is 0/1 coded.
    // find() retrieves the integer index when y is equivalent 1.
    return x.cols( arma::find(y == 1) );
}


/*** R
x <- matrix(1:15, ncol = 5)
matrix_subset_logical(x, c(0, 1, 0, 0, 1))
matrix_subset_idx(x, c(1, 3))

*/

```


* Without `Armadillo`

```
#include <Rcpp.h>

// [[Rcpp::export]]
Rcpp::NumericMatrix matrix_subset_idx_rcpp(
        Rcpp::NumericMatrix x, Rcpp::IntegerVector y) {

    // Determine the number of observations
    int n_cols_out = y.size();

    // Create an output matrix
    Rcpp::NumericMatrix out = Rcpp::no_init(x.nrow(), n_cols_out);

    // Loop through each column and copy the data.
    for(unsigned int z = 0; z < n_cols_out; ++z) {
        out(Rcpp::_, z) = x(Rcpp::_, y[z]);
    }

    return out;
}
```