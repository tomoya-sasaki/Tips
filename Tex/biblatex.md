# Biblatex
## Date and Year
* Exclude date and year from bibliography
```
\DeclareSourcemap{
  \maps[datatype=bibtex]{
    \map{
      \step[fieldset=month, null]
      \step[fieldsource=date, match=\regexp{([0-9]{4})-([0-9]{2})(-[0-9]{2})?}, replace={1}]
    }
  }
}
```

## Eprint
* Exclude eprint from bibliography (arxiv ID, DOI etc)
```
\usepackage[%
eprint = false, %exclude arxiv ID
doi = false, %exclude DOI
isbn = false %exclude isbn
]{biblatex-chicago} 
```
