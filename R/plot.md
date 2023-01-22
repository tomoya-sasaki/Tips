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
* Use `shape` package

```
library(shape)
plot(xlim = c(0, 1), ylim = c(0,1))
# draw an arrow from (0,0) to (0.5,0.5)
Arrows(0, 0, 0.5, 0.5, arr.type = "triangle")
# draw an arrow from (0,0) to (0.5,0.5) where an arrowhead is drawn at both ends (code=3)
Arrows(0, 0, 0.5, 0.5, arr.type = "triangle",code = 3)
```


## legend
### Distance between legend symbol and text

```
legend(x.intersp = 2.0)
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