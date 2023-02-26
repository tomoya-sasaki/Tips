# plot

## rug

```
x <- c(1:100)

plot(xlim = c(1,100), ylim = c(0,1))
rug(x)
rug(x, line = 1, col = "red")
rug(x, line = -1, col = "blue")
rug(x, side = 3, col = "green")
```

## arrows

### base

```
plot(xlim = c(0, 1), ylim = c(0,1))
# draw an arrow from (0,0) to (0.5,0.5)
arrows(-1, 0, -1, 0.5,
		lwd = 2, code = 3, xpd = TRUE, length = 0.1)
# code: 
# 1: arrowhead at x0, y0
# 2: arrowhead at x1, y1
# 3: arrowhead at both sides
# xpd to FALSE and then all plotting is NOT clipped to the plot region
```

* Draw (coefficient) errorbar with the arrows function by setting `length = 0` and not drawing arrowheads

### Use `shape` package

```
library(shape)
plot(xlim = c(0, 1), ylim = c(0,1))
# draw an arrow from (0,0) to (0.5,0.5)
Arrows(0, 0, 0.5, 0.5, arr.type = "triangle")
# draw an arrow from (0,0) to (0.5,0.5) where an arrowhead is drawn at both ends (code=3)
Arrows(0, 0, 0.5, 0.5, arr.type = "triangle",code = 3)
```


## legend
### Distances
* Distance between legend symbol and text

```
legend(x.intersp = 2.0)
```
* Vertical distance

```
legend(y.intersp = 2.0)
```


### legend line length
* The default is 2

```
legend(seg.len=5)
```

### legend position
* "bottomright", "bottom", "bottomleft", "left", "topleft", "top", "topright", "right" and "center"

### surrounding square lines

```
# no square lines
legend(box.lty=0)

# color square lines
legend(box.col="red") 
```