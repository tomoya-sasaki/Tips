# Scraping
* With `httr` and `rvest`
* Useful links
	* [Dos and DON'Ts of Web Scraping](https://www.zenrows.com/blog/dos-and-donts-of-web-scraping#do-rotate-ips)
	* [List of User Agents For Scraping](https://www.proxyrack.com/blog/list-of-user-agents-for-scraping/)
	* [List of user agents 2](https://github.com/tamimibrahim17/List-of-user-agents)
	* [List of user agents 3](https://www.whatismybrowser.com/guides/the-latest-user-agent/)
	* [Cheat sheet](https://github.com/yusuzech/r-web-scraping-cheat-sheet)

## Workflow

### Query webpage
* Use custom user-agent
* Rotate IPs if possible (not free)


```
ua <- "..." # custom user-agent
url <- "www.bbc.com"
obj <- httr::GET(url, httr::user_agent(ua))

obj$request$options$useragent # check user agent
```

### Collect information

```
# extract content 
obj %>% content()

# find html tags and obtain texts
obj %>% content() %>% html_nodes("tg") %>% html_text()

# find html tags and obtain attributes
obj %>% content() %>% html_nodes("tg") %>% html_attr()
```