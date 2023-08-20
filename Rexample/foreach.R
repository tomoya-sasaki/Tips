library(foreach)
library(doFuture)
library(progressr)
library(doRNG)

st <- Sys.time()
plan(multicore, workers = 5)
res <- foreach(i = 1:20) %dorng% {
  set.seed(i)
  Sys.sleep(0.2)

  rnorm(10)
}
Sys.time() - st

st <- Sys.time()
res <- foreach(i = 1:100) %do% {
  set.seed(i)

  rnorm(10)
  Sys.sleep(0.2)
}
Sys.time() - st
