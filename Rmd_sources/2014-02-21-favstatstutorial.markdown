---
layout: post
title: "Tutorial on mosaic's favstats()"
date: 2014-02-21 20:00:00
comments: true
categories: [Student-Focused Tutorials]
pulished:  false
status: publish
---
 
* will be replaced by TOC
{:toc}
 
## Preliminaries
 
`favstats()` comes from the `mosaic` package and we will use some data from the `tigerstats` package, so make sure that both are loaded:
 

    require(mosaic)
    require(tigerstats)

 
**Note:**  If you are not working with the R Studio server hosted by Georgetown College, then you will need install `tigerstats` on your own machine.  You can get the current version from [Github](http://github.com) by first installing the `devtools` package from the CRAN repository, and then running the following commands in a fresh R session:
 

    require(devtools)
    install_github(repo = "homerhanumat/tigerstats")

 
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

 
 
## Studying One Numerical Variable
 
"favstats" is short for "favorite statistics":  it will give you the some of the most popular summary statistics for numerical variables.
 
Suppose, for example, that you want to know how fast people in the `m111survey` sample tend to drive, when they drive their fastest. The you want to study the numerical variable **fastest**:  the fastest speed each person claims to have ever driven, measured in miles per hour.  Just try `favstats()` with the usual formula-data input:
 

    favstats(~fastest, data = m111survey)

    ##  min   Q1 median    Q3 max  mean    sd  n missing
    ##   60 90.5    102 119.5 190 105.9 20.88 71       0

 
Remember what each of the statistics tells you:
 
* The minimum fastest speed drive by anyone in the survery was 60 mph.
* The maximum fastest speed was 190 mph.
* About 25% of the survey participants drove less than 90.5 mph (the First Quartile)
* About 75% percent of the survey participants drove less than 119.5 mph (the Third Quartile)
* About 50% of the participants drove less than 102 mph (the median)
* The mean speed for this sample of students was about 105.9 mph ...
* ... give or take about 20.9 mph or so (the standard deviation).
 
We also see that
 
* 71 people answered the question about fastest speed;
* Nobody did not answer (missing = 0).
 
 
## Studying the Relationship Between a Numerical Variable and a Factor Variable
 
Studying the relationship between a numerical variable and factor variable involves what is popularly known as "breaking the data into groups" based on the values of the factor variable.  More formally, we obtain the conditional distributions of the numerical variable given the various possible values of the factor variable, and look for difference between these distributions.  If we see large differences. then we know that the factor variable "makes a difference" in the likely values of the numerical variable, i.e., the two variable are related.
 
For example we might want to know if the fastest speed one drives might be related to one's sex.  The relevant variables in `m111survey` are then the numerical **fastest** and the factor variable **sex**.
 
In formula-data input for `favstats()` the formula always follows the format:
 
$$numerical \sim factor.$$
 
So we run the following command:
 

    favstats(fastest ~ sex, data = m111survey)

    ##   .group min Q1 median    Q3 max  mean    sd  n missing
    ## 1 female  60 90     95 110.0 145 100.0 17.61 40       0
    ## 2   male  85 99    110 122.5 190 113.5 22.57 31       0

 
The first row of the output gives a summary of the conditional distribution of **fastest**, given that **sex** is female.
 
The second row summarizes the conditional distribution of **fastest**, given that **sex** is male.
 
The two conditional distribution are not the same.  For example, we see that on average females drove about 100 mph, whereas the guys drove about 113.4 mph.  The guys appear to drive faster than the gals:  for this sample of students, fastest speed drive does indeed appear to be related to sex.
 
 
## Limiting the Output
 
Sometimes you want just a few of the numbers from `favstats()`.  If you would like to display only those numbers you can do so using brackets "[" and "]", along with a list of the names of the columns you want to see.  For example, to display only the means and the standard deviations for **fastest**, ask for:
 

    favstats(fastest, data = m111survey)[c("mean", "sd")]

    ##   mean    sd
    ##  105.9 20.88

 
The brackets are R's way of locating particular parts of an object.  If you want to display more than one column, make sure to combine their names (in quotes) in a list with the `c()` function, as shown above.
 
When you are breaking a numerical variable into groups, you will probably also want to see the group names:  this requires the addition of the column named `.group`.  Therefore, to see just the mean and the standard deviation for **fastest** broken down by **sex**, ask for:
 
 

    favstats(fastest ~ sex, data = m111survey)[c(".group", "mean", "sd")]

    ##   .group  mean    sd
    ## 1 female 100.0 17.61
    ## 2   male 113.5 22.57

 
 
 
## Warning
 
`favstats()` specializes in numerical variables:  it won't help you to study a factor variable by itself.  Look what happens when you try to use it to study the factor variable **sex**:
 

    favstats(~sex, data = m111survey)

    ## Error: non-numeric argument to binary operator

 
 
