# rstantools

* Explain the general workflow to create an R package using Stan using the `rstantools` package
* Focus on the differences with the recommendation on `https://r-pkgs.org/`.
* [Vignette](https://mc-stan.org/rstantools/articles/minimal-rstan-package.html)

## Beginning

* Use `rstantools`
* Run `rstan_create_package(path = [packagename])`

```
rstan_create_package("[packagename]")
```

* Delete `Read-and-delete-me` file or include this in `.gitignore` and `.Rbuildignore`
* Edit `Description`
* Create `stan` and `R` functions. 
* Run the following scripts:

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
2. Run `pkgbuild::compile_dll()` (can be skipped)
3. Run `roxygen2::roxytenize()`
	* `devtools::document()` works, too. 
4. Run `devtools::install(quick = FALSE)` (default option)
	* The argument quick=FALSE is necessary if you want to recompile the Stan models. 
	*  If you only make a change to the R code or the documentation, you can set quick=TRUE to speed up the process, or use `devtools::load_all()`.

* `devtools::load_all()`, `devtools::test()`, etc also work

## Misc
### The following will be useful at initialization
* Choose license if necessary (e.g., `usethis::use_mit_license()` or `usethis::use_gpl_license(version = 3)`
* Create readme with `usethis::use_readme_rmd()` and compile with `usethis::build_readme()` to create `README.MD` from `README.Rmd`

### Others
* Use `rm(list = ls())` occationally to clean up the enviornment
	* Especially after you test, because testing create new object in the global enviornment 