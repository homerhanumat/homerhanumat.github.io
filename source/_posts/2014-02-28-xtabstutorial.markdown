---
layout: post
title: "xtabs() Tutorial"
date: 2014-02-28 23:00:00
comments: true
categories: [Student-Focused Tutorials]
published: true
status: publish
---
 
* will be replaced by TOB
{:toc}
 


 
## Preliminaries
 
`xtabs()` is the numerical version of `barchartGC()`.  You use it when you want to study
 
* the distribution of one factor variable;
* the relationship between two factor variables.
 
The function `xtabs()` comes with the `stats` package, which is always loaded in R.  However, some of the data and other functions that we will use come from the `tigerstats` package, so make sure that it is loaded:
 

    require(tigerstats)

 
**Note:**  If you are not working with the R Studio server hosted by Georgetown College, then you will need install `tigerstats` on your own machine.  You can get the current version from [Github](http://github.com) by first installing the `devtools` package from the CRAN repository, and then running the following commands in a fresh R session:
 

    require(devtools)
    install_github(repo="homerhanumat/tigerstats")

 
## One Factor Variable
 
To see a table of the tallies for the factor variable **seat** (from the `mat111survey` data frame in the `tigerstats` package):
 

    xtabs(~seat,data=m111survey)

    ## seat
    ##  1_front 2_middle   3_back 
    ##       27       32       12

 
In order to get the actual distribution of **seat**, you want percents rather than counts, so apply the function `rowPerc()` from `tigerstats`:
 

    rowPerc(xtabs(~seat,data=m111survey))

    ##  1_front 2_middle 3_back  Total
    ##    38.03    45.07  16.90 100.00

 
If you have a table of the counts for a variable, then you can enter it directly.  For example, suppose you have already made:
 

    Seat <- xtabs(~seat,data=m111survey)
    Seat

    ## seat
    ##  1_front 2_middle   3_back 
    ##       27       32       12

 
Then you can just enter the table into `rowPerc()`:

    rowPerc(Seat)

    ##  1_front 2_middle 3_back  Total
    ##    38.03    45.07  16.90 100.00

 
 
## Two Factor Variables
 
You can also use `xtabs()` to study the relationship between two factor variables.  For example, if you want to see whether males and females differ in their seating preferences, then you might try formula-data input as follows:
 

    xtabs(~sex+seat,data=m111survey)

    ##         seat
    ## sex      1_front 2_middle 3_back
    ##   female      19       16      5
    ##   male         8       16      7

 
Of course, row percents are the way to actually study the relationship:
 

    rowPerc(xtabs(~sex+seat,data=m111survey))

    ##        1_front 2_middle 3_back Total
    ## female   47.50    40.00  12.50   100
    ## male     25.81    51.61  22.58   100

 
Note the type of formula used to study the relationship between two factor variables:
 
$$\sim ExplanatoryFactor + ResponseFactor$$
