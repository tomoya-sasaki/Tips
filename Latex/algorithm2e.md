# algorithm2e

## Comment

```
\begin{algorithm}
\tcc{Comment{
\end{algorithm}
```


## for, while, if

```
\begin{algorithm}
\For{$i \gets 1$ \KwTo $N$}{
	Do something
}

\While{$i < N}{
	Do something
}

\tcc{ifelse}
\eIF{condition}{
	Do something
}{
	Do something else
}

\tcc{multiple ifelse's}
\uIF{condition}{
	Do something
}
\uElseIf{
	Do something else
}{
	Do something else
}


\end{algorithm}
```