# Setup

## Options 
### Error options
* [here](https://tex.stackexchange.com/questions/258814/what-is-the-difference-between-interaction-nonstopmode-and-halt-on-error)

The two settings control different behaviours. Setting `-interaction=nonstopmode` tells the TeX engine to run with minimal interaction with the user and as far as possible to 'go past' errors. It's therefore very useful in automation. Setting `-halt-on-error` tells the engine to stop processing the document at the first error, rather than trying to keep going. Thus setting both will cause the run to terminate after the first error whilst only setting `-interaction=nonstopmode` will cause TeX to keep going but not ask you to 'help'.

To enumerate the combinations:

* Neither option: TeX will prompt the user for interaction in the event of an error ('error' includes \show or similar) (The user may of course alter the run mode within TeX using the related primitives.)

* `-interaction=nonstopmode`: TeX will run without interaction from the user but will continue past any error messages (up to 100 errors). TeX will abort if there is a 'serious' error such as a missing file.

* `-halt-on-error`: TeX will abort the run at the first error

* `-interaction=nonstopmode -halt-on-error`: As `-halt-on-error` as once an error is reached the run is aborted

### Latexmk and bibtex

* [here](https://tex.stackexchange.com/questions/564626/latexmk-4-70a-doesnt-compile-document-with-bibtex-citation?noredirect=1)
* Include `$bibtex_fudge=1` option when running bibtex