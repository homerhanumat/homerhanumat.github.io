---
layout: post
title: "barchartGC() Tutorial"
date: 2014-02-21 21:00:00
comments: true
categories: [Student-Focused Tutorials]
pulished:  false
status: publish
---
 
* will be replaced by TOC
{:toc}
 


 
 
## Preliminaries
 
`barchartGC()` provides quick-and-easy bar charts for the graphical exploration of factor variables.  The function comes from the `tigerstats` package and we will use some data from the `tigerstats` as well, so make sure that `tigerstats` is loaded:
 

    require(tigerstats)

 
**Note:**  If you are not working with the R Studio server hosted by Georgetown College, then you will need install `tigerstats` on your own machine.  You can get the current version from [Github](http://github.com) by first installing the `devtools` package from the CRAN repository, and then running the following commands in a fresh R session:
 

    require(devtools)
    install_github(repo="homerhanumat/tigerstats")

 
In this tutorial we will work with the `m111survey` data frame from `tigerstats` package.  If you are not yet familiar with this data, then run:
 

    data(m111survey)
    View(m111survey)
    help(m111survey)

 
Remember that you can also learn about the types of each variable in the data frame with the `str()` function:
 

    str(m111survey)

    ## 'data.frame':	71 obs. of  12 variables:
    ##  $ height         : num  76 74 64 62 72 70.8 70 79 59 67 ...
    ##  $ ideal_ht       : num  78 76 NA 65 72 NA 72 76 61 67 ...
    ##  $ sleep          : num  9.5 7 9 7 8 10 4 6 7 7 ...
    ##  $ fastest        : int  119 110 85 100 95 100 85 160 90 90 ...
    ##  $ weight_feel    : Factor w/ 3 levels "1_underweight",..: 1 2 2 1 1 3 2 2 2 3 ...
    ##  $ love_first     : Factor w/ 2 levels "no","yes": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ extra_life     : Factor w/ 2 levels "no","yes": 2 2 1 1 2 1 2 2 2 1 ...
    ##  $ seat           : Factor w/ 3 levels "1_front","2_middle",..: 1 2 2 1 3 1 1 3 3 2 ...
    ##  $ GPA            : num  3.56 2.5 3.8 3.5 3.2 3.1 3.68 2.7 2.8 NA ...
    ##  $ enough_Sleep   : Factor w/ 2 levels "no","yes": 1 1 1 1 1 2 1 2 1 2 ...
    ##  $ sex            : Factor w/ 2 levels "female","male": 2 2 1 1 2 2 2 2 1 1 ...
    ##  $ diff.ideal.act.: num  2 2 NA 3 0 NA 2 -3 2 0 ...

 
 
## One Factor Variable
 
To look see a bar chart for the tallies of the factor variable **seat**:
 

    barchartGC(~seat,data=m111survey,type="frequency",
               main="Barchart of Seating Preference")

![plot of chunk barchartseatfreq](/images/figure/barchartseatfreq.png) 

 
In order to get the actual distribution of **seat**, you want percents rather than counts:
 

    barchartGC(~seat,data=m111survey,type="percent",
               main="Barchart of Seating Preference")

![plot of chunk barchartseatperc](/images/figure/barchartseatperc.png) 

 
If you have a table of the counts for a variable, then you can enter it directly.  For example, suppose you have already made:
 

    Seat <- xtabs(~seat,data=m111survey)
    Seat

    ## seat
    ##  1_front 2_middle   3_back 
    ##       27       32       12

 
Then you can just enter the table:

    barchartGC(Seat,type="percent",
               main="Barchart of Seating Preference")

![plot of chunk barchartseattab](/images/figure/barchartseattab.png) 

 
 
## Two Factor Variables
 
You can also use `barchartGC()` to study the relationship between two factor variables.  For example, if you want to see whether males and females differ in their seating preferences, then you might try formula-data input as follows:
 

    barchartGC(~sex+seat,data=m111survey,
               type="percent",
               main="Sex and Seating Preference\nat Georgetown")

![plot of chunk barchartsexseat](/images/figure/barchartsexseat.png) 

 
Again, if you happen to have already made a two-way table, then you can just enter it:
 

    SexSeat <- xtabs(~sex+seat,data=m111survey)
    SexSeat

    ##         seat
    ## sex      1_front 2_middle 3_back
    ##   female      19       16      5
    ##   male         8       16      7

 
Here is the bar chart from the two-way table:
 

    barchartGC(SexSeat,type="percent",
               main="Sex and Seating Preference\nat Georgetown")

![plot of chunk barchartsexseattab](/images/figure/barchartsexseattab.png) 

 
## Warning
 
Bar charts are for factor variables, not for numerical variables.  Look what happens when you ask for a bar chart of **fastest**:
 

    barchartGC(~fastest,data=m111survey,
               main="Fastest Speed Ever Driven")

![plot of chunk barchartfastest](/images/figure/barchartfastest.png) 

 
 
R tries to accommodate your request, but it ends up making something that resembles a very amateurish histogram.  R draws a separate bar for each speed that appears in the data, making for a very "busy" graph.  Worse yet, consecutive speeds are equally spaced from each other, even though the differences between consecutive speeds vary.  For example, the spacing between the 90 ans 91 mph bars is the same as the spacing between the 160 and 190 mph bars.  This is very misleading!
