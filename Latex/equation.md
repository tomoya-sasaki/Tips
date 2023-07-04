# label and numbering
## only numbering and label the last line in align environment
* see [here](https://tex.stackexchange.com/questions/66759/make-align-number-the-last-equation) and [here](https://tex.stackexchange.com/questions/42726/align-but-show-one-equation-number-at-the-end)


## Texts in equations

It seems there are four ways to include texts in equations. For the detail, see [1][here]
```
\textrm{this is textrm}
\textsf{this is textsf}
\textnormal{this is textnormal}
\text{and this is just text}
```

## Non-independence

```
\documentclass{article}
\usepackage{unicode-math}

\makeatletter
\newcommand*{\indep}{%
  \mathbin{%
    \mathpalette{\@indep}{}%
  }%
}
\newcommand*{\nindep}{%
  \mathbin{%                   % The final symbol is a binary math operator
    %\mathpalette{\@indep}{\not}% \mathpalette helps for the adaptation
    \mathpalette{\@indep}{/}%
                               % of the symbol to the different math styles.
  }%
}
\newcommand*{\@indep}[2]{%
  % #1: math style
  % #2: empty or \not
  \sbox0{$#1\perp\m@th$}%        box 0 contains \perp symbol
  \sbox2{$#1=$}%                 box 2 for the height of =
  \sbox4{$#1\vcenter{}$}%        box 4 for the height of the math axis
  \rlap{\copy0}%                 first \perp
  \dimen@=\dimexpr\ht2-\ht4-.2pt\relax
      % The equals symbol is centered around the math axis.
      % The following equations are used to calculate the
      % right shift of the second \perp:
      % [1] ht(equals) - ht(math_axis) = line_width + 0.5 gap
      % [2] right_shift(second_perp) = line_width + gap
      % The line width is approximated by the default line width of 0.4pt
  \kern\dimen@
  \ifx\\#2\\%
  \else
    \hbox to \wd2{\hss$#1#2\m@th$\hss}%
    \kern-\wd2 %
  \fi
  \kern\dimen@
  \copy0 %                       second \perp
}
\makeatother

```

## Spaces in `\underbrace{}`

* "Add an appropriate `\vphantom` and flatten the longer text horizontally":

 [here](https://tex.stackexchange.com/questions/275121/underbrace-spacing)


[1]:https://tex.stackexchange.com/questions/130510/write-text-correctly-in-equations
[2]:https://tex.stackexchange.com/questions/174118/not-independent-sign-in-latex