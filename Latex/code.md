# `verbatim`

## Referencing code blocks
### Using `figure` environment

```
\begin{figure}
    \begin{verbatim}
        int main()
        {
        }
    \end{verbatim}
    \caption{My Caption}
    \label{my-label}
\end{figure}
```

### Using `listings` package

```
\documentclass{article}
\usepackage{listings}
\begin{document}

\begin{lstlisting}[language=C,frame=single,caption=My caption here,label=code1]
int main()
  {
  }
\end{lstlisting}

From code~\ref{code1} it can be seen clearly....

\end{document}
```

* [here](https://tex.stackexchange.com/questions/581714/how-to-use-caption-in-a-verbatim-environment)

```
\documentclass{article}

\usepackage{listings}

\lstnewenvironment{myverbatim}[1][]{%
  \lstset{
    basicstyle=\ttfamily,
    frame=tb,
    #1
  }%
}{}

\begin{document}


\begin{myverbatim}[title={Behold this fully functional input file.}]
SDSSJ1206+4332
-0.664,.0137,1.748,.028
#1.320,0.147,5.999,0.148
#-2.052,0.200,2.397,0.152
A,0,0.11,0,0.01,18.05,.02
B,-0.098,0.006,2.894,.009,18.38,.02
\end{myverbatim}


\end{document}
```

```
\documentclass{article}
\usepackage{verbatimbox,caption,float,lipsum}
\newfloat{Code}
\captionsetup{Code}
\begin{document}
\lipsum[1]

\begin{verbbox}
SDSSJ1206+4332
-0.664,.0137,1.748,.028
#1.320,0.147,5.999,0.148
#-2.052,0.200,2.397,0.152
A,0,0.11,0,0.01,18.05,.02
B,-0.098,0.006,2.894,.009,18.38,.02
\end{verbbox}
{\centering
\theverbbox
\captionof{Code}{Behold this fully functional input file.}\par
}
{\centering
\fbox{\theverbbox}
\captionof{Code}{Behold this fully functional input file.}\par
}
\end{document}
```