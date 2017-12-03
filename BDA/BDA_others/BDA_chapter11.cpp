// [[Rcpp::depends(RcppArmadillo)]]
#include <RcppArmadillo.h>
#include <RcppArmadilloExtensions/rmultinom.h>
using namespace Rcpp;
using namespace arma;

// [[Rcpp::export]]
List HierarchicalNormal(colvec y, colvec g, int burnin, int iter, int thin) {
  int i, j, k;
  int n = y.n_rows;  // number of all observations
  int J = max(g);  // number of groups
  colvec theta(J);  // initial values are not needed for theta
  double mu = R::rnorm(0, 1);  // initial value for mu
  double sigma = R::runif(0, 1);  // initial value for sigma
  double sigma2 = sigma * sigma;
  double tau = R::rnorm(0, 1);  // initial value for tau
  double tau2 = tau * tau;
  colvec nobs(J);  // number of observations in each groups
  colvec averagey(J);  // average of observed values in each group (sufficient statistics for theta)
  for (k = 0; k < J; k ++) {
    uvec index = find(g == k + 1);  // row index of observations whose group is (k + 1)
    nobs(k) = index.n_rows;
    averagey.row(k) = mean(y.rows(index));
  }
  int sigma2shape = n / 2;  // shape parameter for sigma is computed in advance since it is constant
  int tau2shape = (J - 1) / 2;  // shape parameter for tau is computed in advance since it is constant
  double thetahat, V, Vsqrt, muhat, musd, sigma2rate, tau2rate;
  colvec deviation(n);
  colvec groupdeviation(J);
  rowvec parameter(J + 3);
  mat sample(iter, J + 3);
  for (i = 0; i < burnin; i ++) {
    // draw theta
    for (k = 0; k < J; k ++) {
      V = 1 / (1 / tau2 + nobs(k) / sigma2);
      Vsqrt = sqrt(V);  // not that R::rnorm() takes a sd parameter, not a variance parameter
      thetahat = V * (mu / tau2 + (nobs(k) * averagey(k)) / sigma2);
      theta(k) = R::rnorm(thetahat, Vsqrt);
    }
    // draw mu
    muhat = mean(theta);
    musd = sqrt(tau2 / J);
    mu = R::rnorm(muhat, musd);
    // draw sigma
    for (k = 0; k < n; k ++) {
      deviation(k) = (y(k) - theta(g(k) - 1)) * (y(k) - theta(g(k) - 1));
    }
    sigma2rate = 2 / (sigma2shape * mean(deviation));  // note that R::rgamma() takes a rate parameter, not a scale parameter
    sigma2 = 1 / R::rgamma(sigma2shape, sigma2rate);  // note that rchisq(v, s2) is the same as rgamma(v / 2, 2 / v * s2)
    // draw tau
    for (k = 0; k < J; k ++) {
      groupdeviation(k) = (theta(k) - mu) * (theta(k) - mu);
    }
    tau2rate = 2 / (tau2shape * (accu(groupdeviation) / (J - 1)));
    tau2 = 1 / R::rgamma(tau2shape, tau2rate);
  }
  for (i = 0; i < iter; i ++) {
    for (j = 0; j < thin; j ++) {
      // draw theta
      for (k = 0; k < J; k ++) {
        V = 1 / (1 / tau2 + nobs(k) / sigma2);
        Vsqrt = sqrt(V);  // not that R::rnorm() takes a sd parameter, not a variance parameter
        thetahat = V * (mu / tau2 + (nobs(k) * averagey(k)) / sigma2);
        theta(k) = R::rnorm(thetahat, Vsqrt);
      }
      // draw mu
      muhat = mean(theta);
      musd = sqrt(tau2 / J);
      mu = R::rnorm(muhat, musd);
      // draw sigma
      for (k = 0; k < n; k ++) {
        deviation(k) = (y(k) - theta(g(k) - 1)) * (y(k) - theta(g(k) - 1));
      }
      sigma2rate = 2 / (sigma2shape * mean(deviation));  // note that R::rgamma() takes a rate parameter, not a scale parameter
      sigma2 = 1 / R::rgamma(sigma2shape, sigma2rate);  // note that rchisq(v, s2) is the same as rgamma(v / 2, 2 / v * s2)
      // draw tau
      for (k = 0; k < J; k ++) {
        groupdeviation(k) = (theta(k) - mu) * (theta(k) - mu);
      }
      tau2rate = 2 / (tau2shape * (accu(groupdeviation) / (J - 1)));
      tau2 = 1 / R::rgamma(tau2shape, tau2rate);
    }
    sigma = sqrt(sigma2);
    tau = sqrt(tau2);
    parameter.cols(0, J - 1) = trans(theta);
    parameter(J) = mu;
    parameter(J + 1) = sigma;
    parameter(J + 2) = tau;
    sample.row(i) = parameter;
    if (i % 10000 == 0) {
      parameter.print("Sampling, current parameters:");
    }
  }
  return List::create(Named("mcmc") = wrap(sample));
}