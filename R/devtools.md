# Create a package
## Useful references
* [https://r-pkgs.org/whole-game.html](https://r-pkgs.org/whole-game.html)
* [https://devtools.r-lib.org/](https://devtools.r-lib.org/)
* [https://usethis.r-lib.org/](https://usethis.r-lib.org/)

## How to start
* `usethis::create_package(PATH)`: create a new directory and initialize package
* `usethis::use_git()`: make the package directory as a Git repository (it does not work in my environment because I haven't defined my git username)
* Edit DESCRIPTION. By using `usethis::use_mit_license(YOUR NAME)`, you can automatically add MIT license. 

## Write a function
* Write a function and put in the folder `R/`
* Write roxygen comment. `devtools::document()` will create `Rd` file under `man/`
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

## Development
* `devtools::load_all()`: simulates installing and reloading the package, loading R code in `R/`, compiled shared objects in `src/`, and data files in `data/`
* `devtools::test()` to reload with `devtools::load_all()` and run all `testhat` tests

## Build and install
* `devtools::install()`: reinstalls the package, detaches the currently loaded version then reloads the new version with `library()`
* `devtools::build()`: builds a pacakge file from package soruces. Use this to build a binary version of the package (tar.gz file etc)

## Check and release
* `devtools::check` automatically builds and checks a source package, using all known best practices. `devtools::check_built` checks an already built package
* `devtools::release()` makes sure everything is ok with your package (including asking you a number of questions), then builds and uploads to CRAN.


### Differences among build, install etc
* `devtools::load_all()`: simulates the process of buidling, installing and attaching the package as if you build and install the package and attached it via `library()`
* `devtools::intall()`: actually reinstall the package
* Check Rstudio cheatsheet page one for more detail


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
> devtools::document();pkgdown::build_reference()
```

## Update vignette
```
# path starts from vignettes and do not include the extension Rmd
> devtools::document();pkgdown::build_article("path_wo_Rmd")
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