args <- commandArgs(trailingOnly=TRUE)


library(gtools)
set.seed(as.integer(args[1]))

print(rdirichlet(1, alpha = rep(1, 20)))