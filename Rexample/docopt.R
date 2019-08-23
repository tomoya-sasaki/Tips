
"
Usage: docopt.R --i --method 

Options:
	--i iterations
	--method method to run [default: tot]
" -> doc


library(docopt) 
my_opts <- docopt(doc)

print(my_opts)
as.integer(my_opts[["i"]]) - 5

# 'Naval Fate.

# Usage:
#   naval_fate.R ship new <name>...
#   naval_fate.R ship <name> move <x> <y> [--speed=<kn>]
#   naval_fate.R ship shoot <x> <y>
#   naval_fate.R mine (set|remove) <x> <y> [--moored | --drifting]
#   naval_fate.R (-h | --help)
#   naval_fate.R --version

# Options:
#   -h --help     Show this screen.
#   --version     Show version.
#   --speed=<kn>  Speed in knots [default: 10].
#   --moored      Moored (anchored) mine.
#   --drifting    Drifting mine.

# ' -> doc

# library(docopt)
# arguments <- docopt(doc, version = 'Naval Fate 2.0')
# print(arguments)