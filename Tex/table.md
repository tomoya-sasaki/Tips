# If you want to put line in part of your table: use `\cline{}`

```
\documentclass{article}
\usepackage{array,multirow}
\begin{document}
\begin{tabular}{|c|cc|}\hline
\multirow{4}{*}{Foo} & 1 & 2 \\
    & 1 & 2 \\\cline{2-3}
    & 1 & 2 \\
    & 1 & 2 \\\hline
\multirow{4}{*}{Bar} & 1 & 2 \\
    & 1 & 2 \\\cline{2-3}
    & 1 & 2 \\
    & 1 & 2 \\\hline
\end{tabular}
\end{document}
```

# If you want to draw dashed line

```
\documentclass{report}
\usepackage{arydshln}

\begin{document}

\begin{tabular}{c:cc}
   column1a & column2a & column3a \\
   column1b & column2b   & column3b\\ \hdashline
   column1c & column2c & column3c \\ \cdashline{1-2}
   column1d & column2d & column3d \\
\end{tabular}

\end{document}
```

# Useful packages
* `array`
