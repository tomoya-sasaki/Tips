# stats

## Interpreting log-transormed variables in a regression

* Reference [here](https://stats.stackexchange.com/questions/18480/interpretation-of-log-transformed-predictor-and-or-response)

1. Outcome log-transformed `log(y) = alpha + beta x + e`: one unit increase in `x` is associated with `beta` unit increase in `y`
2. Explanatory variable log-transformed `y = alpha + beta log(x) + e`: one unit increase in `x` is assocaited with (`beta * 100`) percent increase in `y`
3. Both log-transformed `log(y) = alpha + beta log(x) + e`: one unit increase in `x` is associated with `beta` percent increase in `y`