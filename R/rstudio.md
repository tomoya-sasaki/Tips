# Rstudio
## Preamble
### Adding new command
* You can use the same command as LATEX

```
---
title: "Untitled"
author: "An Author"
date: "January 15, 2017"
output: html_document
---

\newcommand{\var}{\mathrm{Var}}
```

### Add today date
* `%Y` for year, `&B` for month, and `%d` for date, 

```
date: '`r format(Sys.time(), "%d %B, %Y")`'
```

## Unicode issue

"Standard LaTeX can’t handle raw Unicode characters like √, but XeLaTeX can. Add latex_engine: xelatex to your YAML front matter: output: pdf_document: latex_engine: xelatex" [here](https://community.rstudio.com/t/tidyverse-1-2-1-knitting-to-pdf-issue/2880)

# Rsweave
* Use "Weave Rnw files using:" `knitr` instead of `Sweave` to show shaded code chunks in options 


# Miscellaneous
## Add values from R console
* `r [your value]`
* e.g. `r max(data)`


## Useful shortcuts
* <kbd>Ctrl</kbd>+<kbd>2</kbd> : Move cursor to console
* <kbd>Ctrl</kbd>+<kbd>1</kbd> : Move cursor to source editor
* <kbd>F7</kbd> : Check spelling
