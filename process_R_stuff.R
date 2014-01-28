#This shows how I process octopress website involving R code:

#in home directory:
source("~/octopress/rmarkdown.r")

#for posts, change wd to _posts, then:
convertRMarkdown()
system("cp -r figure ../images")
#I can keep the .Rmd file in the _posts

#for some reason, I cannot keep .Rmd in the book directory (rake tries to process them)
#so I process them in bookstage and then store them in bookstore
#for book, change wd to bookstage, then:
convertRMarkdown()
system("cp figure/* ../source/images/figure")

#Then move delete figure directory and move everything where it needs to go
#I guess caches go to public/book

#perhaps I should move my R project to octopress level??