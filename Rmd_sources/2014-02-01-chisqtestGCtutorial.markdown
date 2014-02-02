---
layout: post
title: "chisq.testGC() Tutorial"
date: 2014-02-01 20:00:00
comments: true
categories: [Student-Focused Tutorials]
pulished:  false
status: publish
---
 
{ :toc }
 
## Preliminaries
 
You use the $\chi^2$-test when you are addressing the inferential aspect of a research question about the relationship between two factor variables.  That is, you want to know whether any relationship between the two variables that you might have observed in your data is real or could reasonably be explained as chance variation in the process that resulted in the data.
 
The function (and some of the data) that we will use comes from the `tigerstats` package, so make sure that it is loaded:
 

    require(tigerstats)

 
 
## Formula-Data Input
 
When your data are in raw form, straight from a data frame, you can perform the test using "formula-data input".  For example, in the `mat111survey` data, we might wonder whether sex and seating preference are related, in the population from which the sample was (allegedly randomly) drawn.  The function call and the output are as follows:
 

    chisq.testGC(~sex + seat, data = m111survey)

    ## Pearson's Chi-squared test 
    ## 
    ## Observed Counts:
    ##         seat
    ## sex      1_front 2_middle 3_back
    ##   female      19       16      5
    ##   male         8       16      7
    ## 
    ## Counts Expected by Null:
    ##         seat
    ## sex      1_front 2_middle 3_back
    ##   female   15.21    18.03   6.76
    ##   male     11.79    13.97   5.24
    ## 
    ## Contributions to the chi-square statistic:
    ##         seat
    ## sex      1_front 2_middle 3_back
    ##   female    0.94     0.23   0.46
    ##   male      1.22     0.29   0.59
    ## 
    ## 
    ## Chi-Square Statistic = 3.734 
    ## Degrees of Freedom of the table = 2 
    ## P-Value = 0.1546

 
 
## Two-Way Table Input
 
Sometimes you already have a two-way table on hand:
 

    SexSeat <- xtabs(~sex + seat, data = m111survey)
    SexSeat

    ##         seat
    ## sex      1_front 2_middle 3_back
    ##   female      19       16      5
    ##   male         8       16      7

 
In that case you can save yourself some typing by entering the table in place of the formula and the `data` arguments:
 

    chisq.testGC(SexSeat)

 
 
## Constructing a Two-Way table From Summary Data
 
Remember:  if you are given summary data, only, then you can construct a nice two-way table and enter it into `chisquare.testGC()`.  Suppose that you want this two-way table on :
 
|   |Front|Middle|Back|
|:---------|:----------:|:----------:|:-----------:|
|Female|19|16|5|
|Male|8|16|7|
 
You can get it as follows:
 

    MySexSeat <- rbind(female = c(19, 16, 5), male = c(8, 16, 7))
    colnames(MySexSeat) <- c("front", "middle", "back")

 
Let's just check to see that this worked:
 

    MySexSeat

    ##        front middle back
    ## female    19     16    5
    ## male       8     16    7

 
Then you can enter `MySexSeat` into the function:
 

    chisq.testGC(MySexSeat)

 
 
## Simulation
 
When the Null's expected counts are low, `chisq.testGC()` delivers a warning and suggest the use of simulation to compute the $P$-value.  You do this by way of the argument `simulate.p.value`, and you have three options:
 
* `simulate.p.value = "fixed"`
* `simulate.p.value = "random"`
* `simulate.p.value = "TRUE"`
 
### Explanatory Tallies Fixed
 
Suppose that the objects under study are not a random sample from some larger population, and that the way chance comes into the production of the data is through random variation in all of the other factors---besides the explanatory variable--- that might be associated with the response variable.  Then since the items being observed are fixed, the tally of values for the explanatory variable are fixed.  The response values for these items are the product of chance, but only through random variation in those other factors.
 
The study from the `ledgejump` data frame was an example of this.  The 21 incidents were fixed, so there were nine cold-weather incidents and 12 warm-weather incidents, no matter what.  The crowd behavior at each incident, however is still a matter of chance.
 
In such a case you might want to resample under the restriction that in all of your resamples, the tally for the explanatory variable stays just the same as it was in the data you observed.  Then your function call looks like:
 


 
 

    chisq.testGC(~weather + crowd.behavior, data = ledgejump, simulate.p.value = "fixed", 
        B = 2500)

    ## Pearson's chi-squared test with simulated p-value, fixed effects
    ## 	 (based on 2500 resamples)
    ## 
    ## Observed Counts:
    ##        crowd.behavior
    ## weather baiting polite
    ##    cool       2      7
    ##    warm       8      4
    ## 
    ## Counts Expected by Null:
    ##        crowd.behavior
    ## weather baiting polite
    ##    cool    4.29   4.71
    ##    warm    5.71   6.29
    ## 
    ## Contributions to the chi-square statistic:
    ##        crowd.behavior
    ## weather baiting polite
    ##    cool    1.22   1.11
    ##    warm    0.91   0.83
    ## 
    ## 
    ## Chi-Square Statistic = 4.073 
    ## Degrees of Freedom of the table = 1 
    ## P-Value = 0.0496

 
You can set `B`, the number of resamples, as you wish, but it should be at least a few thousand.  Of course the $P$-value, having been determined by random resampling, will vary from one run of the function to another.
 
 
### Explanatory Tallies Random
 
In the `m111survey` study on sex and seating preference, the subjects are a random sample from a larger population.  In that case the tallies for both the explanatory and the response variables depend upon chance. If you simulate in such a case, then you set `simulate.p.value` to "random":
 

    chisq.testGC(~sex + seat, data = m111survey, simulate.p.value = "random", B = 2500)

    ## Pearson's chi-squared test with simulated p-value, random effects
    ## 	 (based on 2500 resamples)
    ## 
    ## Observed Counts:
    ##         seat
    ## sex      1_front 2_middle 3_back
    ##   female      19       16      5
    ##   male         8       16      7
    ## 
    ## Counts Expected by Null:
    ##         seat
    ## sex      1_front 2_middle 3_back
    ##   female   15.21    18.03   6.76
    ##   male     11.79    13.97   5.24
    ## 
    ## Contributions to the chi-square statistic:
    ##         seat
    ## sex      1_front 2_middle 3_back
    ##   female    0.94     0.23   0.46
    ##   male      1.22     0.29   0.59
    ## 
    ## 
    ## Chi-Square Statistic = 3.734 
    ## Degrees of Freedom of the table = 2 
    ## P-Value = 0.1684

 
 
 
### Both Tallies Fixed
 
If you want to resample in such a way that the tallies for BOTH the explanatory and response variables stay exactly the same as they were in the actual data, then you set `simulate.p.value` to "TRUE".  This invokes R's standard method for resampling:
 

    chisq.testGC(~sex + seat, data = m111survey, simulate.p.value = TRUE, B = 2500)

    ## Pearson's Chi-squared test with simulated p-value
    ## 	 (based on 2500 replicates) 
    ## 
    ## Observed Counts:
    ##         seat
    ## sex      1_front 2_middle 3_back
    ##   female      19       16      5
    ##   male         8       16      7
    ## 
    ## Counts Expected by Null:
    ##         seat
    ## sex      1_front 2_middle 3_back
    ##   female   15.21    18.03   6.76
    ##   male     11.79    13.97   5.24
    ## 
    ## Contributions to the chi-square statistic:
    ##         seat
    ## sex      1_front 2_middle 3_back
    ##   female    0.94     0.23   0.46
    ##   male      1.22     0.29   0.59
    ## 
    ## 
    ## Chi-Square Statistic = 3.734 
    ## Degrees of Freedom of the table = 2 
    ## P-Value = 0.1703

 
It's not easy to understand why R would adopt such a method, but it does have a long and honored history.  If you are ever in doubt about how to simulate, just use this third option.
 
## Graphs of the P-Value
 
 
You can get a graph of the $P$-value in the plot window by setting the argument `graph` to TRUE.  When you did not simulate, the graph shows a density curve for the $\chi^2$ random variable with the relevant degrees of freedom.  When you simulate, the graph is a histogram of the resampled $\chi^2$-statistics.
 
Here is a case with no simulation:
 

    chisq.testGC(~sex + seat, data = m111survey, graph = TRUE)

    ## Pearson's Chi-squared test 
    ## 
    ## Observed Counts:
    ##         seat
    ## sex      1_front 2_middle 3_back
    ##   female      19       16      5
    ##   male         8       16      7
    ## 
    ## Counts Expected by Null:
    ##         seat
    ## sex      1_front 2_middle 3_back
    ##   female   15.21    18.03   6.76
    ##   male     11.79    13.97   5.24
    ## 
    ## Contributions to the chi-square statistic:
    ##         seat
    ## sex      1_front 2_middle 3_back
    ##   female    0.94     0.23   0.46
    ##   male      1.22     0.29   0.59
    ## 
    ## 
    ## Chi-Square Statistic = 3.734 
    ## Degrees of Freedom of the table = 2 
    ## P-Value = 0.1546

![Graph of P-value, no simulation](/images/figure/chisqtutnosim.png) 

 
 
Here is a case with simulation:
 
 

    chisq.testGC(~sex + seat, data = m111survey, simulate.p.value = "random", B = 2500, 
        graph = TRUE)

    ## Pearson's chi-squared test with simulated p-value, random effects
    ## 	 (based on 2500 resamples)
    ## 
    ## Observed Counts:
    ##         seat
    ## sex      1_front 2_middle 3_back
    ##   female      19       16      5
    ##   male         8       16      7
    ## 
    ## Counts Expected by Null:
    ##         seat
    ## sex      1_front 2_middle 3_back
    ##   female   15.21    18.03   6.76
    ##   male     11.79    13.97   5.24
    ## 
    ## Contributions to the chi-square statistic:
    ##         seat
    ## sex      1_front 2_middle 3_back
    ##   female    0.94     0.23   0.46
    ##   male      1.22     0.29   0.59
    ## 
    ## 
    ## Chi-Square Statistic = 3.734 
    ## Degrees of Freedom of the table = 2 
    ## P-Value = 0.1572

![Graph of P-value, with simulation](/images/figure/chisqtutsim.png) 

 
