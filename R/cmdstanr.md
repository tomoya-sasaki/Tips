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