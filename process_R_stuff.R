#This shows how I process octopress website involving R code:

#in home directory:
source("~/octopress/rmarkdown.r")

#for posts, change wd to _posts, then:
convertRMarkdown()
system("cp -r figure ../images")
#If there is a cache file, do the same for it.
#Note that one should name all code chunks for graphs, as all R posts pis in the same figure pot.

#I can keep the .Rmd file in the _posts