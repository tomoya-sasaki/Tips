# rstantools

* Explain the general workflow to create an R package using Stan.
* Focus on the differences with the recommendation on `https://r-pkgs.org/`.

## Beginning
* Run `rstan_create_package`
* Delete `Read-and-delete-me` file or include this in `.gitignore` and `.Rbuildignore`
* Edit `Description`


## Workflow
* Edit scripts
	* Stan files in `inst/stan`
* Run `pkgbuild::compile_dll()`
* Run `roxygen2::roxytenize()`
	* `devtools::document()` doesn't seem to work. Thre are multiple unsuccessful solutions online.
	* (Probably) Since `devtools::document()` doesn't work, `devtools::check()` does not work either.
* Run `devtools::install()`
* `devtools::load_all()` does not work
* `devtools::load_all()`, `devtools::document()`, and `devtools::check()`all return the same error

```
Error in getDLLRegisteredRoutines.DLLInfo(dll, addNames = FALSE) :   must specify DLL via a “DLLInfo” object. See getLoadedDLLs()
```