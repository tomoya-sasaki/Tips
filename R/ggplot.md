# ggplot
## A barplot
```{r, warning=FALSE, message=FALSE, fig.align='center'}
d %>%
	ggplot(., aes(x=ownchild)) +
	geom_bar() +
	ggtitle("Barplot: Number of children") +
	xlab("Number of Children") + ylab("Count") +
	form1
```

## A probability density graph overlaid on a histogram
```{r, warning=FALSE, message=FALSE, fig.align='center'}
d %>%
	ggplot(., aes(x=age)) +
	geom_histogram(aes(y=..density..), colour="black", bins=20) +
	geom_density(colour="red", adjust=4) +
	xlab("Age") +
	ggtitle("A density plot and histogram of age") +
	form1
```
## `geom_vline` and legend
* If you want to make legend, you need to put the variables in `aes(xintercept=)`.
* However, `geom_vline` allows length 1 or the same length as the data. Otherwise you will get a following error.

```
>>> plot + geom_vline(aes(xintercept = c(1,2,3))
Error: Aesthetics must be either length 1 or the same as the data (53940): xintercept
```

* You need to add one by one.

```
>>> plot + geom_vline(aes(xintercept = c(1))) + 	
	geom_vline(aes(xintercept = c(2))) + 
    geom_vline(aes(xintercept = c(3)))
```
 

## ggjoy
* See [here](https://simplystatistics.org/2017/07/13/the-joy-of-no-more-violin-plots/)
* Produce a stack histogram for each group
* Alternative for so-called the violin plot?

## data format
* You cannot use `factor` class in the data you want to plot
* However, you need `factor` to classify the data by `colour = ` or `linetypes = `

## Labels
### Date and lines
* to add vline or cline when you are dealing with date format data
* you need to transform the `date` variable into `numeric`
`+ geom_vline(as.numeric([date]), colour...)`

###  Blank titles
* if you want to blank the title of axis

* `+ axis.title.x = element_blank()`,  `+ axis.title.y = element_blank()`

### Center titles

```
ggplot() +
  ggtitle("Default in 2.2.0 is left-aligned")
  
ggplot() +
  ggtitle("Use theme(plot.title = element_text(hjust = 0.5)) to center") +
  theme(plot.title = element_text(hjust = 0.5))
```

### Log-scale data
* data -> log scale & axis label -> non log scale
* example
```
data$exp_A <- exp(data$A)
ggplot(data, aes(x = exp_A)) + scale_x_continuous(trans="log")
```

### size of axis label and axis title
* axis label size
`theme(axis.text.x = element_text(size=12), axis.text.y = element_text(size=12))`
* axis title size
`theme(axis.title.x = element_text(size=15), axis.title.y = element_text(size=15))` 
* legend text size
`theme(legend.title = element_text(size=15), legend.text = element_text(size=15))`

### if you want to split your title to two or more lines
* use `\n`

### Change angle of the label
* `theme(axis.text.x = element_text(angle = 45, hjust = 1))`



## color 
### make grey gradation
* `scale_fill_grey(start = 0, end = 1, name = "Type")`
* `Type` refers to source of the gradation

## Scales for date/time data
Basic

```
scale_x_date(name = waiver(), breaks = waiver(), date_breaks = waiver(),
  labels = waiver(), date_labels = waiver(), minor_breaks = waiver(),
  date_minor_breaks = waiver(), limits = NULL, expand = waiver(),
  position = "bottom")

scale_y_date(name = waiver(), breaks = waiver(), date_breaks = waiver(),
  labels = waiver(), date_labels = waiver(), minor_breaks = waiver(),
  date_minor_breaks = waiver(), limits = NULL, expand = waiver(),
  position = "left")

scale_x_datetime(name = waiver(), breaks = waiver(),
  date_breaks = waiver(), labels = waiver(), date_labels = waiver(),
  minor_breaks = waiver(), date_minor_breaks = waiver(), timezone = NULL,
  limits = NULL, expand = waiver(), position = "bottom")

scale_y_datetime(name = waiver(), breaks = waiver(),
  date_breaks = waiver(), labels = waiver(), date_labels = waiver(),
  minor_breaks = waiver(), date_minor_breaks = waiver(), timezone = NULL,
  limits = NULL, expand = waiver(), position = "left")

scale_x_time(name = waiver(), breaks = waiver(), minor_breaks = waiver(),
  labels = waiver(), limits = NULL, expand = waiver(), oob = censor,
  na.value = NA_real_, position = "bottom")

scale_y_time(name = waiver(), breaks = waiver(), minor_breaks = waiver(),
  labels = waiver(), limits = NULL, expand = waiver(), oob = censor,
  na.value = NA_real_, position = "left")

```
The arguments you could add in `date_breaks`.

```
date_breaks("1 week"), date_breaks("10 years"), date_breaks("5 days") etc
```

## Themes
* My template

```
ng1 <- theme(panel.background = element_rect(fill = "white", colour = "white"), 
	panel.grid.major = element_line(colour = NA), 
	axis.line = element_line(size = 1, colour="black"), 
	axis.ticks=element_line(color="black"), 
	axis.text=element_text(color="black",size=15), 
	axis.title=element_text(color="black",size=20), 
	panel.grid.minor = element_line(colour = NA), 
	legend.position = "top", 
	legend.direction="horizontal", 
	legend.text = element_text(size=20), 
	legend.key = element_rect(fill = "white"), 
	#legend.title = element_blank(),
	plot.title = element_text(hjust = 0.5),
	legend.key.size = unit(1.5, "cm"))
```



#### Remove borders
```
theme(panel.border = element_blank())

```

### Remove grid and background

```
panel.border = element_rect(fill = NA, linewidth = 0.8),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank())
```


# Legend
* You need to use identical name and labels values for both shape and colour scale.

```
## Examples
## Even when you use different color types and size types, you can integrate them
g <- ggplot(binded_plot, aes(x = X2, y = X3, group = X5)) + 
		geom_line(aes(size = X5, color = X5) )+ 
		scale_size_manual(name = "# of topics", 
		label = c("K + 8*K sLDA", "K + 9*K sLDA", "K + 10*K sLDA", "K + 8*K LDA", "K + 9*K LDA", "K + 10*K LDA"),
		values = c(.6, 1.2, 2, .6, 1.2, 2)) +
		scale_color_manual(name = "# of topics", 
		label = c("K + 8*K sLDA", "K + 9*K sLDA", "K + 10*K sLDA", "K + 8*K LDA", "K + 9*K LDA", "K + 10*K LDA"), 
		values=c("red", "red", "red", "blue", "blue", "blue"))
```

Aesthetics can be set or mapped within a ggplot call.
An aesthetic defined within aes(...) is mapped from the data, and a legend created. An aesthetic may also be set to a single value, by defining it outside aes(). In this case, it appears you wish to set alpha = 0.8 and map colour = group (no legend).
To do this, place the alpha = 0.8 outside the aes() definition.

```
g <- ggplot(df, aes(x = x, y = y, group = group))
g <- g + geom_line(aes(colour = group))
g <- g + geom_point(aes(colour = group), alpha = 0.8)
```


### Change spaces between legends and figures

```
ggplot(dfr,aes(x=x,y=value,fill=variable))+
  geom_bar(stat="identity")+
  theme(legend.position="top",
        legend.justification="right",
        legend.margin=margin(0,0,0,0),
        legend.box.margin=margin(-10,-10,-10,-10))
# the last two lines change margins of legend
```

### Remove legend titles

Remove legend for a particular aesthetic (fill):

```
bp  + guides(fill=FALSE)
```

It can also be done when specifying the scale:

```
bp + scale_fill_discrete(guide=FALSE)
```

This removes all legends:

```
bp + theme(legend.position="none")
```

# Small tips
## Finish with `NULL`

```
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point() +
  geom_smooth(alpha = 0.6) +
  NULL
```

If you finish your ggplot with `NULL`, you can easily cut & paste or change the order of each argument.

## Fit weighted regression

```
wtdlm <- lm(mpg ~ hp, data = mtcars, weights = cyl)
mp <- as.data.frame(cbind(hp = mtcars$hp, predict(wtdlm, interval = 'confidence')))
# Base plot
p1 <- ggplot(mtcars, aes(x = hp, y = mpg)) + geom_point(aes(size = cyl))
# Add the fitted model + confidence envelope
p1 + geom_line(data = mp, aes(x = hp, y = fit), size = 1, color = 'blue') +
	geom_line(data = mp, aes(x = hp, y = lwr), color = 'gray80') +
	geom_line(data = mp, aes(x = hp, y = upr), color = 'gray80') +
	geom_ribbon(data = mp, aes(x = hp, ymin = lwr, ymax = upr), alpha = 0.1)
```

## Create a map of the US and fit Alaska and Hawaii

* Reference [here](https://r-spatial.org/r/2018/10/25/ggplot2-sf-3.html), [here](https://stackoverflow.com/questions/49523375/graphing-lat-long-data-points-on-us-map-50-states-including-alaska-hawaii), or [here](https://stackoverflow.com/questions/13757771/relocating-alaska-and-hawaii-on-thematic-map-of-the-usa-with-ggplot2)

```
library(ggplot2)
library(cowplot)
(mainland <- ggplot(data = usa) +
     geom_sf(fill = "cornsilk") +
     coord_sf(crs = st_crs(2163), xlim = c(-2500000, 2500000), ylim = c(-2300000, 730000)))
         
(alaska <- ggplot(data = usa) +
     geom_sf(fill = "cornsilk") +
     coord_sf(crs = st_crs(3467), xlim = c(-2400000, 1600000), ylim = c(200000, 2500000), expand = FALSE, datum = NA))

(hawaii  <- ggplot(data = usa) +
     geom_sf(fill = "cornsilk") +
     coord_sf(crs = st_crs(4135), xlim = c(-161, -154), ylim = c(18, 23), expand = FALSE, datum = NA))         

(ratioAlaska <- (2500000 - 200000) / (1600000 - (-2400000)))

## [1] 0.575

(ratioHawaii  <- (23 - 18) / (-154 - (-161)))

## [1] 0.7142857

ggdraw(mainland) +
    draw_plot(alaska, width = 0.26, height = 0.26 * 10/6 * ratioAlaska, x = 0.05, y = 0.05) +
    draw_plot(hawaii, width = 0.15, height = 0.15 * 10/6 * ratioHawaii, x = 0.3, y = 0.05)     
```