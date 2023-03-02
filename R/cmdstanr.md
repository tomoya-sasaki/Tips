# cmdstanr

* Lightweighted stan interface for R
* Still developing, not on CRAN

## Install

```
install.packages("cmdstanr", repos = "https://mc-stan.org/r-packages/")

library(cmdstanr)

# check that your toolchain is set up properly
check_cmdstan_toolchain()

# isntall CmdStan
install_cmdstan(cores = 2)
```

## Use `cmdstanr` in a package
* Write this in R functions to compile and fit a model
* Not sure this is the right way to do this

```
# path to the stan file in the package
standir <- system.file(paste0("stan/lm.stan"), package = "cmdstanrtest")

# compile
stanmodel <-cmdstanr::cmdstan_model(standir)

# fit
out <- stanmodel$sample(data = standata, ...)

```

* Compiled `stan` is created when you compile it by calling (R) functions after loading the package, not when you load the function