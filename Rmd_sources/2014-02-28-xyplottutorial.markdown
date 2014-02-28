---
layout: post
title: "Tutorial on lattice's xyplot()"
date: 2014-02-28 22:30:00
comments: true
categories: [Student-Focused Tutorials]
published: true
status: publish
---
 
* will be replaced by TOB
{:toc}
 


 
## Preliminaries
 
The function `xyplot()` makes scatterplots to indicate the relationship between two numerical variables.  It comes from the `lattice` package for statistical graphics, which is pre-installed with every distribution of R.  Also, package `tigerstats` depends on lattice, so if you load `tigerstats`:
 

    require(tigerstats)

 
then `lattice` will be loaded as well.  If you don't plan to use `tigerstats` but you want to use the function `xyplot()`, then make sure you load lattice:
 

    require(lattice)

 
 
**Note:**  If you are not working with the R Studio server hosted by Georgetown College, then you will need to install `tigerstats` on your own machine.  You can get the current version from [Github](http://github.com) by first installing the `devtools` package from the CRAN repository, and then running the following commands in a fresh R session:
 

    require(devtools)
    install_github(repo="homerhanumat/tigerstats")

 
## Basic Scatterplot
 
Suppose you want to know:
 
  >*Do students with higher GPA's tend to drive more slowly than students with lower GPA's?*
  
If so, then you might check to see if numerical variable **fastest** (in the `m111survey` data frame from the `tigerstats` package) is realted to the numerical variable `GPA`.  Then you can make a scatterplot as follows:
 

    xyplot(fastest~GPA,data=m111survey,
           xlab="grade point average",
           ylab="speed (mph)",
           main="Fastest Speed Ever Driven,\nby Grade Point Average")

![plot of chunk xytutfastestgpa](/images/figure/xytutfastestgpa.png) 

 
Note the use of:
 
* the `xlab` argument to label the horizontal axis;
* the `ylab` argument to label the vertical axis, complete with units (miles per hour);
* the `main` argument to provide a brief but descriptive title for the graph;
* the "\n" to make two lines in the title (useful if you have a long title).
 
When we think of one variable as explanatory and the other as the response, it is common to put the explanatory on the horizontal axis and the response on the vertical axis.  This is accomplished by the formula
 
$$response \sim explanatory$$
 
## Including a Regression Line
 
If you want desire a regression line along with your scatterplot, use the argument `type`, as follows:
 

    xyplot(fastest~GPA,data=m111survey,
           xlab="grade point average",
           ylab="speed (mph)",
           main="Fastest Speed Ever Driven,\nby Grade Point Average",
           type=c("p","r"))

![plot of chunk xytutfastestgpareg](/images/figure/xytutfastestgpareg.png) 

 
The list given by `c("p","r")` tells `xyplot()` that we want both the points ("p") and a regression line ("r").
 
## Playing With Points
 
You can vary the type of point using the `pch` argument, and the color of the points with the `col` argument.  For example:
 

    xyplot(fastest~GPA,data=m111survey,
           xlab="grade point average",
           ylab="speed (mph)",
           main="Fastest Speed Ever Driven,\nby Grade Point Average",
           pch=19,col="blue")

![plot of chunk xytutfastestgpapoints](/images/figure/xytutfastestgpapoints.png) 

 
There are 25 different values for `pch`:  the integers 1 through 25.
 
There are many, many values for `col`.  You can explore 657 of them with the command:
 

    colors()

