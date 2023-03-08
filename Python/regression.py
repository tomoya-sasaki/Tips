import numpy as np
import statsmodels.api as sm

N = 100
x = np.random.normal(size = (N, 2))
coef = np.array([-1, 2])
y = np.dot(x, coef) + np.random.normal(size = N)

xtx = np.dot(x.transpose(), x)
xty = np.dot(x.transpose(), y)

beta = np.dot(np.linalg.inv(xtx), xty)
print(beta)

x2 = sm.add_constant(x)
model = sm.OLS(y, x)
results = model.fit()
results.summary()