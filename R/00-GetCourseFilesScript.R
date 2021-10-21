install.packages("usethis")
# choose location for files by setting your working directory
# to a folder you create with your OS ... like c:\analytics
# use menus of RStudio:
# Session --> Set Working Directory --> Choose Directory(i.e. analytics)
courseURL = "https://github.com/flyaflya/buad621-2021/archive/refs/heads/master.zip"

usethis::use_course(url = courseURL, destdir = getwd())