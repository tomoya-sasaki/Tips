# Preamble
## Adding new command
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

## Add today date
* `%Y` for year, `&B` for month, and `%d` for date, 

```
date: '`r format(Sys.time(), "%d %B, %Y")`'
```