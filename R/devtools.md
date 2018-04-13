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

* Then you might want to try...
	* Try install [this][1]
	* Try install using Rstudio

	
[1]:https://github.com/coatless/r-macos-rtools