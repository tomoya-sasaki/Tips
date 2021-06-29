# Biblatex

## Add `.bst` file and `.bib`
* Add `.bst` file and `.bib` file under `texmf` folder
* Create a new folder if it does not exist

```
# bib
/Users/tomoyasasaki/Library/texmf/bibtex/bib/


# bst
/Users/tomoyasasaki/Library/texmf/bibtex/bst/
```

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

## Sort bib file
* Use `bibtool`. Install with brew.
* [Link](https://tex.stackexchange.com/questions/426341/using-bibtool-to-sort-a-bib-file-by-types-and-keys-alphabetically)

```
% by key (within each type, sorted with key)
bibtool -s --sort.format='{%s($key)}' -i bibsort.bib -o bibsorted.bib
% sort with two variables
bibtool -s --sort.format='{%s($type) %s($key)}' -i bibsort.bib -o bibsorted.bib
```