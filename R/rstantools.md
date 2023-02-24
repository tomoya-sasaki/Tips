# rstantools

* Explain the general workflow to create an R package using Stan.
* Focus on the differences with the recommendation on `https://r-pkgs.org/`.
* [Vignette](https://mc-stan.org/rstantools/articles/minimal-rstan-package.html)

## Beginning
* Run `rstan_create_package`
* Delete `Read-and-delete-me` file or include this in `.gitignore` and `.Rbuildignore`
* Edit `Description`
* Create first `stan` and `R` functions. 
* Run the following scrits:

```
example(source) # defines the sourceDir() function
try(roxygen2::roxygenize(load_code = sourceDir), silent = TRUE)
roxygen2::roxygenize() # you might need to run this twice according to the vignette
```
* If you do not run the scripts above properly, `devtools::load_all()`, `devtools::document()`, and `devtools::check()`all return the same error later

```
Error in getDLLRegisteredRoutines.DLLInfo(dll, addNames = FALSE) :   must specify DLL via a “DLLInfo” object. See getLoadedDLLs()
```


## Workflow
1. Edit scripts
	* Stan files in `inst/stan`
2. Run `pkgbuild::compile_dll()`
3. Run `roxygen2::roxytenize()`
	* `devtools::document()` works, too. 
4. Run `devtools::install()`

* `devtools::load_all()`, `devtools::test()`, etc also work

## Misc
### The following will be useful at initialization
* Choose license if necessary (e.g., `usethis::use_mit_license()`
* Create readme with `usethis::use_readme_rmd()`

### Others
* Use `rm(list = ls())` occationally to clean up the enviornment