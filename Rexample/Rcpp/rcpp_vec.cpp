#include <Rcpp.h>
#include <RcppEigen.h>
#include <Eigen/Dense>

using namespace Rcpp;
using namespace Eigen;
using namespace std;

// [[Rcpp::depends(RcppEigen)]]

// [[Rcpp::export]]
NumericMatrix ret_rnorm(const int N) {
  NumericMatrix X(N, 4);
  // X.row(1) = Rcpp::rnorm(4, 0.0, 1.0);

  for (int it = 0; it < N; it++) {
    X(it, _) = Rcpp::rnorm(4, 0.0, 1.0);
    // X.row(it) = Rcpp::rnorm(4, 0.0, 1.0);
    // Rcout << "The value of v : " <<  << "\n";
  }
  return X;
}

// [[Rcpp::export]]
MatrixXd ret_rnorm_eigen(const int N) {
  MatrixXd Y(N, 4);
  NumericMatrix X(N, 4);

  for (int it = 0; it < N; it++) {
    X.row(it) = Rcpp::rnorm(4, 0.0, 1.0);
  }
  Y = Rcpp::as<Eigen::Map<Eigen::MatrixXd>>(X);
  
  return Y;
}

// [[Rcpp::export]]
void ret_test() {
  
  // Eigen::Matrix3Xf A(3, 2);  // 3x2
  Eigen::MatrixXd A = Eigen::MatrixXd(3, 2);  // 3x2
  A << 1, 2, 2, 2, 3, 5;
  std::cout << A << std::endl;

  // Eigen::Vector3f V = Eigen::Vector3f(1, 2, 3);
  Eigen::VectorXf V = Eigen::VectorXf(10);
  V << 1,1,1,1,1,1,1,1,1,1;

  // const Eigen::MatrixXd C = A.array().colwise() * V.array();

  std::cout << V << std::endl;

}

// [[Rcpp::export]]
MatrixXd mat_vec_eigen(Eigen::MatrixXd m, Eigen::MatrixXd v) {
  MatrixXd output = m * v;

  // MatrixXd res = Eigen::stats::dnorm(X = v, mean = output, sd = 1.0, log_form = true);

  if (m.cols() != v.rows()) {
    cout << "Something is wrong" << endl;
  }
  // if (output.rows() != m.rows()) {
  //   cout << "Something is wrong" << endl;
  // }
  
  // const Eigen::MatrixXd C = m.array().colwise() * v.array();
  return output;
}


// [[Rcpp::export]]
List dnorm_cpp_eigen(NumericVector z, NumericVector d, MatrixXd x, VectorXd y, VectorXd par,
                     double alpha) {  
  const int N = x.rows();
  int K = x.cols();
  // List ret;
  List tmp;
  double tmp2 = 0.0;
  double rhs;
  // VectorXd alpha_eigen;
  // std::vector<double> alpha_vec(N, alpha);
  // Eigen::MatrixXd alpha_eigen = Eigen::Map<Eigen::Matrix<double, N, 1>>(alpha_vec.data());

  // for (int i = 0; i < N; i++) {
  //   alpha_eigen(i) = alpha;
  // }

  // input check
  if (K != par.size()) {
    stop("The dimension of parameter and x does not match.");
  }

  VectorXd rhs2 = x * par;
  rhs2.array() += alpha;
  
  cout << N << endl;
  for (int j = 0; j < 20000; j ++) {
    for (int it = 0; it < N; it++) {
      // Rcout << it << endl;
      if (z(it) == 1 & d(it) == 1) {
        rhs = x.row(it) * par + alpha;
        tmp2 += R::dnorm(y(it), rhs, 1.0, true) + R::pnorm(rhs2(it), 0.0, 1.0, true, true);
      } else if (z(it) == 1 & d(it) == 0) {
        rhs = x.row(it) * par + alpha;
        tmp2 += R::dnorm(y(it), rhs, 1.0, true) + R::pnorm(rhs2(it), 0.0, 1.0, true, true);
      } else {
        rhs = x.row(it) * par + alpha;
        tmp2 += R::dnorm(y(it), rhs, 1.0, true) + R::pnorm(rhs2(it), 0.0, 1.0, true, true);
      }
    }
  }  

  // const Eigen::MatrixXd C = m.array().colwise() * v.array();

  // return tmp2;

  tmp = List::create(Named("result") = tmp2, Named("RHS") = rhs2);
  return tmp;
}

// [[Rcpp::export]]
double dnorm_cpp(NumericVector z, NumericVector d, 
                 NumericMatrix x, NumericVector y, 
                 NumericVector par) {  
  int N = x.rows();
  int K = x.cols();
  // List ret;
  List tmp;
  double tmp2 = 0.0;
  double rhs;

  // input check
  if (K != par.size()) {
    stop("The dimension of parameter and x does not match.");
  }
  
  // cout << N << endl;
  for (int j = 0; j < 20000; j++) {
    rhs = 0.0;
    for (int it = 0; it < N; it++) {
      // Rcout << it << endl;
      if (z(it) == 1 & d(it) == 1) {
        for (int k = 0; k < K; k++) {
          rhs += x(it, k) * par(k);
        }
        tmp2 += R::dnorm(y(it), rhs, 1.0, true);
      } else if (z(it) == 1 & d(it) == 0) {
        for (int k = 0; k < K; k++) {
          rhs += x(it, k) * par(k);
        }
        tmp2 += R::dnorm(y(it), rhs, 1.0, true);
      } else {
        for (int k = 0; k < K; k++) {
          rhs += x(it, k) * par(k);
        }
        tmp2 += R::dnorm(y(it), rhs, 1.0, true);
      }
    }
  }  
  // const Eigen::MatrixXd C = m.array().colwise() * v.array();

  return tmp2;

  // tmp = List::create(Named("result") = tmp2);
  // return tmp;
}


// [[Rcpp::export]]
Rcpp::IntegerVector test(Rcpp::CharacterVector SampleInModel,
                         Rcpp::CharacterVector SampleInPlink) {
  Rcpp::IntegerVector posSampleInPlink = Rcpp::match(SampleInModel, 
                                                     SampleInPlink);
  return posSampleInPlink;
}

// /*** R
// test(c(1,3,5,7,9),1:10)
// */

// [[Rcpp::export]]
VectorXd mat_vec(MatrixXd x, VectorXd par) {
  VectorXd y = x * par;

  return y;
}

