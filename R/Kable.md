# Kable
## `kable_styling`

*  In `kableExtra` package
* HTML Table Attributes. This function provides a cleaner approach to modify the style of HTML tables other than using the table.attr option in knitr::kable(). Note that those bootstrap options requires Twitter bootstrap theme, which is not avaiable in some customized template being loaded.
* Detail [here](https://haozhu233.github.io/kableExtra/kableExtra_in_other_HTML_themes.html)

```
kable(dt) %>%
  kable_styling()
  
```