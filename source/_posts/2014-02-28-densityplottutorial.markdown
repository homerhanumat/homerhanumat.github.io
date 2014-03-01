---
layout: post
title: "Tutorial on lattice's densityplot()"
date: 2014-02-28 22:45:00
comments: true
categories: [Student-Focused Tutorials]
published: true
status: publish
---
 
* will be replaced by TOB
{:toc}
 


 
## Preliminaries
 
The function `densityplot()` is used to study the distribution of a numerical variable.  It comes from the `lattice` package for statistical graphics, which is pre-installed with every distribution of R.  Also, package `tigerstats` depends on lattice, so if you load `tigerstats`:
 

    require(tigerstats)

 
then `lattice` will be loaded as well.  If you don't plan to use `tigerstats` but you want to use the function `densityplot()`, then make sure you load lattice:
 

    require(lattice)

 
 
**Note:**  If you are not working with the R Studio server hosted by Georgetown College, then you will need to install `tigerstats` on your own machine.  You can get the current version from [Github](http://github.com) by first installing the `devtools` package from the CRAN repository, and then running the following commands in a fresh R session:
 

    require(devtools)
    install_github(repo="homerhanumat/tigerstats")

 
## One Numerical Variable
 
In the `m11survey` data frame from the `tigerstats` package, suppose that you want to study the distribution of **fastest**, the fastest speed one has ever driven.  You can do so with the following command:
 
 
 

    densityplot(~fastest,data=m111survey,
           xlab="speed (mph)",
           main="Fastest Speed Ever Driven")

![plot of chunk dentutfastest](/images/figure/dentutfastest.png) 

 
Note the use of:
 
* the `xlab` argument to label the horizontal axis, complete with units (miles per hour);
* the `main` argument to provide a brief but descriptive title for the graph.
 
If you do not want to see the "rug" of individual data values at the bottom of the plot, set the argument `plot.points` to `FALSE`:
 

    densityplot(~fastest,data=m111survey,
           xlab="speed (mph)",
           main="Fastest Speed Ever Driven",
           plot.points=FALSE)

![plot of chunk dentutfastestnorug](/images/figure/dentutfastestnorug.png) 

 
## Numerical and Factor Variable
 
Suppose you want to know:
 
  >*Who tends to drive faster:  guys or gals?*
  
Then you might wish to study the relationship between the numerical variable **fastest** and the factor variable **sex**.  You can use density plots in two ways in order to perform such a study.
 
### Side-by-Side Plots
 

    densityplot(~fastest|sex,data=m111survey,
           xlab="speed (mph)",
           main="Fastest Speed Ever Driven,\nby Sex")

![plot of chunk dentutfastestsexcond](/images/figure/dentutfastestsexcond.png) 

 
Note that to produce side-by-side plots, you "condition" on the factor variable with the formula:
 
$$\sim numerical \vert factor$$
 
Note also the use of "\n" to split the title into two lines:  this is a useful trick when the title is long.
 
### Plots in the Same Panel
 
You can get a density plot for each value of the factor variable and have all of the plots appear in the same panel.  This is accomplished with the `groups` argument:
 

    densityplot(~fastest,data=m111survey,
           groups=sex,
           xlab="speed (mph)",
           main="Fastest Speed Ever Driven,\nby Sex",
           plot.points=FALSE,
           auto.key=TRUE)

![plot of chunk dentutfastestsexgroups](/images/figure/dentutfastestsexgroups.png) 

 
Note the use of the `auto,key` argument to produce the legend at the top, so that the reader can tell which plot goes with which sex.
 
Many people think that grouped density plots allow for easier comparison than side-by-side plots do---at least if the number of groups is small.
 
## From and To
 
In the `imagpop` data frame, the variable **kkardashtemp** records the rating given, by each individual in the data frame, for the celebrity Kim Kardashian.  The possible ratings range from 0 to 100.
 
Let's make a density plot of this variable:
 

    densityplot(~kkardashtemp,data=imagpop,
                plot.points=FALSE)

![plot of chunk dentutkkard](/images/figure/dentutkkard.png) 

 
The function `densityplot()` has no way of knowing that **kkardashtemp** must lie between 0 and 100, so from the available data it infers that there is some possibility for a rating to be below 0 or above 100.  If you want to inform `denistyplot()` of the known limits, then use the `from` and `to` arguments, as follows:
 

    densityplot(~kkardashtemp,data=imagpop,
                plot.points=FALSE,
                from=0,to=100)

![plot of chunk dentutkkardfromto](/images/figure/dentutkkardfromto.png) 

 
