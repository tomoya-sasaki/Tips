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

## Save draws

* Make sure to save draws after you fit the model.
* `in order to save a fitted model object containing all of the posterior draws and sampler diagnostics you should either make sure to call fit$draws() and fit$sampler_diagnostics() before saving the object fit, or use the special $save_object() method provided by CmdStanR, which will ensure that everything has been read into R before saving the object using saveRDS()`


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