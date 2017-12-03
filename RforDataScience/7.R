library(tidyverse)


# 7.3
diamonds %>% count(cut) # count 
ggplot(diamonds) + geom_bar(aes(x = count))

diamonds %>%
	count(cut_width(carat, .5))
ggplot(diamonds) + geom_histogram(aes(x = carat), binwidth = .5)


# 7.3.2
diamonds %>% 
	filter(carat < 3) %>% 
	ggplot() + 
		geom_histogram(aes(x = carat), binwidth = .01)
# the plot shows that diamonds whose carat is immidiately below 1 or 2 is very small. this implies that integer is important cutpoints for diamond carat


# 7.3,3
ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50)) # zoom in y 0:50

diamonds %>%
	filter(y < 3 | y > 20) %>%
	dplyr::select(price, x, y, z) %>%
	arrange(y)


# 7.3.4
# 1:2
ggplot(diamonds, aes(x = x)) +
	geom_histogram(binwidth = .05)

# price around 1500 does not exist

# 3
diamonds %>%
	filter(carat == .99)

diamonds %>%
	filter(carat == 1)

diamonds %>%
	mutate(id = row_number()) %>%
	dplyr::select(x, y, z, id) %>%
	gather(variable, value, -id) # melt with `x,y,z` without `id` while remaining it as `id`
  # the first argument(`variable`) take the colnames and the second argument (`value`) takes the values of the argument for each row

diamonds %>%
	mutate(id = row_number()) %>%
	dplyr::select(x, y, z, id) %>%
	gather(variable, value, -id) %>%
	ggplot(aes(x = value)) + geom_density() + facet_grid(variable ~ .) + geom_rug()
	#`geom_rug()` gives you the each case, marginal distibutions
	# `facet_grid` display for each `variable`, you can use `facet_grid(~variable)` instead too


# 4
ggplot(diamonds) + 
	geom_histogram(mapping = aes(x = price)) +
	coord_cartesian(xlim = c(100, 5000), ylim = c(0, 3000))
ggplot(diamonds) + 
	geom_histogram(mapping = aes(x = price)) +
	xlim(100, 5000) + ylim(0, 3000)

# `coord_cartesian` simply zoom while ` xlim ` and ` ylim ` drop the values  exceed the given limits and draw the graph



##########################################
# 7.4