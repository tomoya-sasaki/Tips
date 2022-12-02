## General workflow

```
import numpy as np
import statsmodels.api as sm

X = np.array([0, 1, 2, 3])
y = np.array([1, 2, 3.5, 4])
X = sm.add_constant(X)
model = sm.OLS(y, X)
results = model.fit()

# Predict at x=2.5
X_test = np.array([1, 2.5])  # "1" refers to the intercept term
results.get_prediction(X_test).summary_frame(alpha=0.05)  
```