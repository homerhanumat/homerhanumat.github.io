#This shows how I process octopress website post involving R code:

#If a toc is desired, place this in document:

# * list element with functor item
# {:toc}

# styling for toc is in sass/custom/_styles.scss

#in home directory:
source("~/octopress/rmarkdown.r")

#for posts, change wd to RMD_sources, then:
convertRMarkdown()
system("cp figure/* ../source/images/figure")
#If there is a cache file, do the same for it.

system("cp 2014-05-05-reasons-to-teach-with-R-3.markdown ../source/_posts")


#Note that one should name all code chunks for graphs, as all R posts piss in the same figure pot.
