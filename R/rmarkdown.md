# rmarkdown

## Text

### Example yaml header

* Double spacing
* Times New Roman
* 12pt font
* Centered section titles

```
output:
  pdf_document:
    latex_engine: xelatex
    fig_caption: yes
indent: true
mainfont: Times New Roman
fontsize: 12pt
header-includes:
    - \usepackage{setspace}\doublespacing
    - \usepackage{booktabs}
    - \usepackage{sectsty} \sectionfont{\centering }
abstract:
  \noindent
  Abstract text here.
```