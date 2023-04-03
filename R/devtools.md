# Create a package
## Useful references
* [https://r-pkgs.org/whole-game.html](https://r-pkgs.org/whole-game.html)
* [https://devtools.r-lib.org/](https://devtools.r-lib.org/)
* [https://usethis.r-lib.org/](https://usethis.r-lib.org/)

## How to start
* Check if the name is available using `available::available("NAME")`
* `usethis::create_package("PATH")`: create a new directory and initialize package
* `usethis::use_git()`: make the package directory as a Git repository (it does not work in my environment because I haven't defined my git username)
* Edit DESCRIPTION. By using `usethis::use_mit_license("YOUR NAME")`, you can automatically add MIT license. 
* Write package help file with `usethis::use_package_doc()`. This creates `[package name]-package.R` under `R/` folder. 

## Write a function
* Write a function and put in the folder `R/`
* `usethis::use_r("FUNCTION")`: open and/or create `FUNCTION.R` under `R/` folder 
* Write roxygen comment. `document()` will create `Rd` file under `man/`
* Example roxyegen comment

```
#' Bind two factors
#'
#' Create a new factor from two existing factors, where the new factor's levels
#' are the union of the levels of the input factors.
#'
#' @param a factor
#' @param b factor
#'
#' @return factor
#' @export
#' @examples
#' fbind(iris$Species[c(1, 51, 101)], PlantGrowth$group[c(1, 11, 21)])
```

## Testing
* `usethis::use_testthat()`: declare an intent to write unit tests and to use thei testhat package for testing
* `usethis::use_test("FUNCTION NAME")`: open/create a test file under `testthat` folder, use after `use_testthat()`
* `test()`: conduct test, make sure to run `library([packagename])` before the test

## Use functions in other packages
* Import functions from the namespace of other packages
* `usethis::use_package("PACKAGE")`: declare that you use functions from a package. This adds the package to the “Imports” section of DESCRIPTION.
* Alternatively, you can hand-write each package with `@import` in roxygen comment and let `document()` function edit NAMESPACE

## Others
* `usethis::use_readme_rmd()`: create `README.Rmd` and `README.md` with some sections ready, basically a skeleton of the package description
* When you plan to upload your package to CRAN, there may be several files or folders that you need to let CRAN to ignore (e.g., `.git`, `pkgdown/` etc). You need to add them to `.Rbuildignore`. You can add them with `usethis::use_build_ignore()`. 
* Use `use_package("PACKAGE NAME")` when the package requires to use other packages. This adds the name of other packages in `DESCRIPTION`. `use_package("PACKAGE NAME", "Suggests)` when the package `Suggests` to use other packages.
* `person("Hadley", "Wickham", email = "hadley@rstudio.com", role = c("aut", "cre"))`: add author

## Development
* `load_all()`: simulates installing and reloading the package, loading R code in `R/`, compiled shared objects in `src/`, and data files in `data/`
* `test()`: reload with `load_all()` and run all `testhat` tests

## Testing
* `devtools::test()` reads objects in the global environment and so `devtools::test()` might pass even when `devtools::check()` fails.
* Also, `devtools::test()` attaches objects to the global environment

## Build and install
* `install()`: reinstalls the package, detaches the currently loaded version then reloads the new version with `library()`. Make sure to run `document()` before running this to reflect changes in `man/` file
* `build()`: builds a pacakge file from package sources. Can use this to build a binary version of the package (tar.gz file etc).

## README
* Initialize with `usethis::use_readme_rmd()` or `usethis::use_readme_md()`
* Build the readme with `devtools::build_readme()` if you use `README.Rmd` generated with `usethis::use_readme_rmd()` for `README.md`

## Check and release
* `check()`: automatically builds and checks a source package, using all known best practices. `check_built` checks an already built package
* `release()`: makes sure everything is ok with your package (including asking you a number of questions), then builds and uploads to CRAN.
* The `styler` package restyles your scripts and packages

## Differences among build, install etc
* `load_all()`: simulates the process of buidling, installing and attaching the package as if you build and install the package and attached it via `library()`. Loads functions in memory but does not instal. Reflects edits
* `build()`: create a compressed file of the package. The package does not reflect edits once you end the R session and load again with `library()`.
* `check()` build and check (does not create a compresed file in the parent directory)
* `intall()`: actually (re)install the package and 
put them in memory (like after `library()`). Installed package is a binary package that has been decompressed into a package library
* Check Rstudio cheatsheet page one for more detail

## Workflow
1. Initialize
2. Write a function
3. Test and load with `load_all`. Write test files under `tests/testthat` and also run `test()`
4. Create `Rd` files with `document`
5. Repeat 2 to 4. Occasionally use `check`
6. Install with `install` and restart when you have repeated 2-4 multiple times

# Misc tips
## R CMD check Note when using tidyverse

```
my_summary_function <- function(data) {
  data %>% 
    filter(x > 0) %>% 
    group_by(grp) %>% 
    summarise(y = mean(y), n = n())
}
```

You’ll get an R CMD CHECK NOTE:

```
N  checking R code for possible problems
   my_summary_function: no visible binding for global variable ‘x’, ‘grp’, ‘y’
   Undefined global functions or variables:
     x grp y
```

You can eliminate this by using .data$var and importing .data from its source in the rlang package (the underlying package that implements tidy evaluation):

```
#' @importFrom rlang .data
my_summary_function <- function(data) {
  data %>% 
    filter(.data$x > 0) %>% 
    group_by(.data$grp) %>% 
    summarise(y = mean(.data$y), n = n())
}
```

# Compile
## Install new creating package on cluster
```
library(devtools)
install("path/to/package")
```

## When you fail to compile
* You may see error like this (MacOS)

```
Error: package or namespace load failed for [packagename] in dyn.load ...
```

## From `pkgdown`

```
# if you get an error try this
> pkgbuild::compile_dll()
```

## Update `.Rd` file
```
> document();pkgdown::build_reference()
```

## Update vignette
```
# path starts from vignettes and do not include the extension Rmd
> document();pkgdown::build_article("path_wo_Rmd")
```

```
pkgdown::build_site()
# if it takes time
pkgdown::build_site(install = F)
```

* Then you might want to try...
	* Try install [this][1]
	* Try install using Rstudio

	
[1]:https://github.com/coatless/r-macos-rtools