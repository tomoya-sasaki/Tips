# ggplot
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

## Whole Themes
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
	legend.title = element_blank(),
	legend.key.size = unit(1.5, "cm"))
```