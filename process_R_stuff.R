#This shows how I process octopress website post involving R code:

#in home directory:
source("~/octopress/rmarkdown.r")

#for posts, change wd to RMD_sources, then:
convertRMarkdown()
system("cp -r figure ../source/images")
#If there is a cache file, do the same for it.

system("cp convertedfile.md ../source/_posts")


#Note that one should name all code chunks for graphs, as all R posts pis in the same figure pot.
