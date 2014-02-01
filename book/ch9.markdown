---
layout: page
title: Confidence Intervals
published: true
status: publish
---
 
 
 
# Confidence Intervals
 


 
 


 
## Introduction
 
One of the main goals in statistics is **inference**.  We are interested in using the knowledge we obtain from a *sample* to infer, or predict, something about the *population* at large.  Numbers that describe a particular aspect of the sample are called **statistics** and numbers that describe an aspect of the population are called **parameters**.  Since we typically do not know the value of a parameter, a statistic is our *single best guess* at it.
 
In Chapter 8, you learned about the Big Five Parameters and the statistics that estimate them, the Big Five Estimators.  Due to the randomness involved in selecting a sample, a statistic has variation associated with it.  This means that if we take a large number of samples from the same population, the value of the statistic computed from each sample won't always be the same value. 
 
The variation in the value of a statistic is what gives us a *distribution* for the statistic.  Each of the Big Five Estimators have an associated distribution with a center, spread, and shape.  
 
The center of the distribution is what we call the *expected value, EV*, - the number that we expect the statistic to be.  The spread of the distribution is what we call the *standard deviation, SD*, -  how far off we think our statistic might be from the actual value of the parameter.  You can think of the standard deviation as the "give or take".  We saw that, at large sample sizes, the shape of each of the distributions for the Big Five Estimators was approximately normal (bell-shaped).
 
Let's look again at the summary from Chapter 8.
 
### Summary of Formulas
 
* For one mean $\mu$:
    - Estimator is $\bar{x}$
    - EV is $\mu$
    - SD is $\frac{\sigma}{\sqrt{n}}$
    - SE is $\frac{s}{\sqrt{n}}$
* For the difference of two means $\mu_1-\mu_2$:
    - Estimator is $\bar{x}_1-\bar{x}_2$
    - EV is $\mu_1-\mu_2$
    - SD is $\sqrt{\frac{\sigma_1^2}{n_1}+\frac{\sigma_2^2}{n_2}}$
    - SE is $\sqrt{\frac{s_1^2}{n_1}+\frac{s_2^2}{n_2}}$
* For one proportion $p$:
    - Estimator is $\hat{p}$
    - EV is $p$
    - SD is $\sqrt{\frac{p(1-p)}{n}}$
    - SE is $\sqrt{\frac{\hat{p}(1-\hat{p})}{n}}$
* For the difference of two proportions $p_1-p_2$:
    - Estimator is $\hat{p}_1-\hat{p}_2$
    - EV is $p_1-p_2$
    - SD is $\sqrt{\frac{p_1(1-p_1)}{n_1}+\frac{p_2(1-p_2)}{n_2}}$
    - SE is $\sqrt{\frac{\hat{p}_1(1-\hat{p}_1)}{n_1}+\frac{\hat{p}_2(1-\hat{p}_2)}{n_2}}$
* For the mean of differences $\mu_d$:
    - Estimator is $\bar{d}$
    - EV is $\mu_d$
    - SD is $\frac{\sigma_d}{\sqrt{n}}$
    - SE is $\frac{s_d}{\sqrt{n}}$
 
 
A statistic is our *single best guess* at the value of a parameter.  Since we know that the value of a statistic varies depending on the sample, this leads to the question, "How **sure** are we that the value of the statistic that we've calculated is actually close to the value of the parameter?".  Instead of reporting a single number for our estimate, even if it is our *best guess*, perhaps we would be better off giving a range of values such that we have some degree of confidence that it contains the true value of the parameter.  Let's explore this idea through an example.
 
  >**Research Question**:  What is the average annual household income for the folks from ``imagpop``? 
 
This is a research question about one population mean, $\mu$.  Let's estimate $\mu$ by drawing a SRS of size 50 from ``imagpop``.
 


 


 

    srs.income<-popsamp(50,imagpop)
    mean(~income,data=srs.income)

    ## [1] 40888

 
Since we took a SRS, we can be fairly sure that this estimate, $\bar{x}=$ $ 40888 is *close* to the true parameter value.  However, if we re-run the code above, we will get a different value.
 


 


 
 

    srs.income<-popsamp(50,imagpop)
    mean(~income,data=srs.income)

    ## [1] 40888

 
Because of this variation, we can also be reasonably certain that our statistic is *not exactly equal* to the true parameter value.  However, this gives us a good idea of a range into which our parameter value likely falls.  Look at the $\bar{x}$'s from 15 different samples:
 

    ##    result
    ## 1   42030
    ## 2   46514
    ## 3   45850
    ## 4   39992
    ## 5   33184
    ## 6   32244
    ## 7   44100
    ## 8   40842
    ## 9   42218
    ## 10  40296
    ## 11  42022
    ## 12  40028
    ## 13  40710
    ## 14  49124
    ## 15  39200

 
Based on these samples, it seems likely that the true average annual income (the parameter value) probably falls somewhere in between $32244$ and $49124.$  
 
[How *likely* is it that the parameter falls in this range, though?  In other words, how *confident* are we that the true parameter value falls between $32244$ and $49124$?  When we start trying to think of this in terms of likelihood or probability, we need a more mathematical way to compute such an interval.  The method we used above is very rudimentary.  We'll get to a better method of construction momentarily!]  
 
Reporting a range of reasonable values for the parameter is a better approach to giving an estimate of a population parameter than giving one single best guess.  Reporting a single value as our estimate is like throwing all of our eggs into one basket - "This is our best guess and that's it!".  We, as researchers, would be failing to recognize the chance variation that is an essential part of our process of estimation.  People reading the results of such a study also need to be made aware of the "give or take" that is associated with any estimate.
 
**Warning:**  Although confidence intervals take into account the error, or variability, associated with the estimation of a parameter, they do not account for all sources of error.  For example, errors from an incorrect experiment design or sampling bias can creep into a statistical analysis and are not accounted for in a confidence interval.  Refer to Chapters 5 & 6 for these types of errors.
 
 
## Conceptual Understanding of Confidence Intervals 
 
The "range of values" that we have been discussing is called a **confidence interval**.  A confidence interval answers the question, "Given the data at hand, within what range of values does the parameter of interest *probably* lie?"
 
  >*Definition:*  A **confidence interval** is an interval of values for the population parameter that could be considered reasonable, based on the data at hand.  
 
A confidence interval is calculated using the general equation
$$\mbox{Sample Estimate }\pm\mbox{ Margin of Error}$$
where $$\mbox{Margin of Error }=\mbox{ Multiplier }*\mbox{ Standard Error.}$$ 
 
The *sample estimate*, *multiplier*, and *standard error* depend on the parameter being estimated, but the **interpretation of the confidence interval** for any parameter is the same.  
 
* The $\mbox{Sample Estimate}$ is our single best guess at the value of the population parameter.  It is the center of the confidence interval.
 
* The $\mbox{Standard Error}$ is the estimate of the standard deviation of the population parameter.  It is affected by the sample size, $n$.  Recall from Chapter 8 that larger sample sizes yield smaller standard deviations.  The same holds true for standard error, since the formulas for SE have the same structure as the formulas for SD.  (Look at the formulas in the summary shown above.)  **Larger sample sizes produce smaller standard errors**.
 
* The $\mbox{Multiplier}$ is determined by the desired **confidence level**.  The **confidence level** gives the probability that the *method* of constructing confidence intervals will produce an interval that contains the parameter value.  Commonly used **confidence levels** include
      * 90%
      * 95% (most common)
      * 98%
      * 99%.
  
The confidence level aids in the interpretation of a confidence interval.  For example, suppose you want to construct a 95% confidence interval for the estimation of a population parameter.  
 
A correct interpretation of the confidence interval is:  **If the study were repeated many times, and on each occasion a 95% confidence interval were calculated, then about 95% of these intervals would contain the true parameter value and about 5% would not**. 
 
**Warning:**  One incorrect statement that is often made about a 95% confidence interval is: "There is a 95% chance (probability) that the confidence interval contains the true parameter value."  The reason that this is an incorrect interpretation is quite subtle.  Once a confidence interval is constructed, it either contains the parameter value or it does not.  The probability associated with a confidence interval refers only to the *method* that is used to construct it, not the interval itself.
 
Let's put these ideas together.  The *sample estimate* determines the center and the *margin of error* determines the width of the confidence interval. Since the *margin of error* is determined by the *multiplier* and the *standard error*, we can see the role that **sample size** and **confidence level** play in the width of the confidence interval.
 
* The larger the sample size, $n$, the smaller the SE.  So, ***larger* sample sizes produce more *narrow* confidence intervals**.
 
* The higher level of confidence we have that an interval contains the true parameter value, the wider the interval is.  So, ***larger* confidence levels produce *wider* confidence intervals**.
 
 
## Chapter Outline
 
The next two chapters will follow the same format.  We will go through each of the Big Five parameters, one by one, doing the following:
 
* State a Research Question that involves the parameter of interest.
 
* Write out a series of steps - using a "packaged" R-function to do most of the computations that we will need.
 
* Look "under the hood" of the test to see how the packaged R-function is computing certain values.
 
* Work a couple of examples involving the same parameter.
 
As we work through the confidence interval construction for each of the Big Five parameters, we will continue to push the conceptual understanding of a confidence interval.
 
 
## One Population Mean, $\mu$
 
Let's start looking at the confidence interval for the example from `imagpop` we looked at above.  We will go through the Four Steps for this first example, using the "packaged" R function to compute the interval for us.  Then, we will go through the construction of the confidence interval step by step in detail.
 
Let's continue to consider the research question posed at the beginning of this chapter.  The `imagpop` dataset is a nice one to use for purposes of demonstration because it represents an entire population, so we can have values for parameters and statistics.  
 
  >**Research Question**:  What is the average annual income for the folks from the `imagpop` population?
 
### The Four Steps
 
**Step One:**  *Definition of Parameter(s)*
 
Let $\mu=$ mean annual income for the `imagpop` population.
 
For this example, we will go back to pretending that we are a very powerful being and we know the true value of $\mu$.  We are going to watch as a statistician, who does not know $\mu$, constructs a 95% confidence interval to estimate $\mu$.  
 
Our goal with this example is to understand how a confidence interval is constructed and how it produces a range of believable values for the population parameter.  
 
Let's start by having our statistician draw a simple random sample of size 50 from this population and calculate the sample mean from it, as we did above.
 
 

    mysample<-popsamp(50,imagpop)
    xbar<-mean(~income,data=mysample)

    ## Error: object 'mysample' not found

    xbar

    ## Error: object 'xbar' not found

 
So, $\bar{x}=$ \$

    
    Error in format(xbar, scientific = FALSE) : object 'xbar' not found
    

 is the sample estimate of the population mean, $\mu$.   
 
However, since we are a powerful all-knowing being, we know the population mean.  
 

    mu<-mean(~income,data=imagpop)
    mu

    ## [1] 40317

 
So the population mean is $\mu=$ \$40317.  
 
*Important Note*:  In reality, if you actually knew the population parameter, there would be no point in drawing a sample to estimate it, much less computing a confidence interval for it.  For this reason, the rest of the construction of the confidence interval will deal only with the sample.  We are using the `imagpop` dataset for this example in order to compare the population parameter to the confidence interval.
 
**Step Two:**  *Safety Check and Calculation of the Confidence Interval*
 
In Chapter 9, we learned that the sampling distribution of $\bar{x}$ looks normal if two conditions hold.
 
* Condition 1:  **The population is roughly normal in shape or the sample size, $n$, is at least 30.**  Since our sample is size 50, it is big enough.  (However, if $n<30$, it would be necessary to take a look at the distribution of the incomes from our sample.  You could do this by plotting a histogram or a boxplot.  Check for outliers or extreme skewness.)
 
* Condition 2:  **The sample is like a SRS from the population, at least in regard to the variables of interest.**  Since our sample was drawn using the `popsamp` function, we know that it was a simple random sample.  This assures us that the sample is representative of the population at large and probably does not have any underlying bias.
 
Since the safety check is passed, let's go ahead and compute a 95% confidence interval using the R function `t.testGC`. (The rationale behind this function will be explained when we look *under the hood*.)
 


 



    t.testGC(~income,data=mysample)

    ## 
    ## 
    ## Inferential Procedures for One Mean mu:
    ## 
    ## 
    ## Descriptive Results:
    ## 
    ##  variable  mean    sd  n
    ##    income 40926 23123 50
    ## 
    ## 
    ## Inferential Results:
    ## 
    ## Estimate of mu:	 40926 
    ## SE(x.bar):	 3270 
    ## 
    ## 95% Confidence Interval for mu:
    ## 
    ##           lower.bound         upper.bound          
    ##           34354.607303        47497.392697

 
 
 
So, our 95% confidence interval for the estimation of the population mean, $\mu$, is ($34355,$47497).
 
 
**Step Three:**  *Interpretation of the Confidence Interval*
 
We are 95% confident that if the true population mean were known, the interval ($34355,$47497) would contain it.  In other words, this interval gives the most believable values for $\mu$.
 
We are lucky in this case because we are a powerful being and we actually do know the value of $\mu$.  So, we can check to see if $\mu$ is, in fact, contained in the interval we computed.  The population mean, $\mu=$ $40317, so it is contained in the 95% confidence interval that was computed in Step 2.
 
Once the confidence interval is computed, it either contains $\mu$ or it does not.  There is no probability associated with any *specific* interval.  The probability is associated with the **method** that was used to create such an interval (which we will talk about shortly).  For example, if we re-computed this 95% confidence interval for many different samples, say 20, we could expect that about 95% of those intervals would contain $\mu$ and about 5% would not.  Let's do this!
 

    ##    lower upper included
    ## 1  32560 46916      Yes
    ## 2  27952 42192      Yes
    ## 3  35364 46812      Yes
    ## 4  29621 44939      Yes
    ## 5  31280 48580      Yes
    ## 6  38426 55778      Yes
    ## 7  27975 39473       No
    ## 8  31776 48700      Yes
    ## 9  35713 51959      Yes
    ## 10 34833 51315      Yes
    ## 11 29483 47961      Yes
    ## 12 31691 45989      Yes
    ## 13 35735 53581      Yes
    ## 14 27303 44509      Yes
    ## 15 30764 44580      Yes
    ## 16 36233 51815      Yes
    ## 17 29142 46102      Yes
    ## 18 39002 54974      Yes
    ## 19 36136 50456      Yes
    ## 20 27583 45265      Yes

 
You should notice that *about* 95% of the 100 intervals contain $\mu=$ $40317.  In other words, *about* $0.95\cdot 20=$ 19 intervals should contain $\mu$ and *about* $0.05\cdot 20=$ 1 does not.  
 
The following app will help you to explore this idea visually:
 

    require(manipulate)
    CIMean(~income,data=imagpop)

 
Experiment with changing the sample size and confidence level in the app.  Take note of what happens to the yellow confidence interval.  
 
* In general, what happens to the width of the yellow confidence interval as the sample size gets bigger?
* In general, what happens to the width of the yellow confidence interval as the confidence level increases?
 
 
 
 
*Warning*:  Another common misinterpretation of the 95% confidence interval computed above would be to say that about 95% of the people in the `imagpop` population make an annual salary between $34355 and $47497.  Don't fall into this trap!  The confidence interval only gives us an interval of believable values for the population mean.  It does not give us any information about the range of individual's incomes.
 
**Step Four:**  *Write a Conclusion.*
 
The conclusion should be a non-technical statement about what the confidence interval tells us about the population parameter.
 
We can be reasonably sure that the average annual income of the folks from the `imagpop` population  is between $34355 and $47497.
 
 
### Under the Hood
 
Understanding the construction of the confidence interval explains a couple of things.  
 
* It explains the 95% confidence level.
* It explains why we use a $t$-test.
 
Once the safety check is passed in Step Two, we can assume that $\bar{x}$ approximately follows a normal distribution.  This allows us to think of the center and spread of the distribution using the expected value, $EV(\bar{x})$, and the standard deviation, $SD(\bar{x})$. See Figure[Xbar Distribution].
 
* $EV(\bar{x})=\mu$
 
* $SD(\bar{x})=\dfrac{\sigma}{\sqrt{n}}$
 
 
![Xbar Distribution:  The distribution of the sample means approximately follows a normal distribution centered at the EV(xbar) with spread given by SD(xbar).](/images/figure/distxbar.png) 

 
Since the 68-95 Rule (Empirical) Rule) applies to normal curves, we know that 
 
* $\approx 68\%$ of the $\bar{x}$'s fall within one standard deviation of $EV(\bar{x})=\mu$,
* $\approx 95\%$ of the $\bar{x}$'s fall within two standard deviations of $EV(\bar{x})=\mu$, and
* $\approx 99.7\%$ of the $\bar{x}$'s fall within three standard deviations of $EV(\bar{x})=\mu$.
 
Let's dig deeper into the second part of the 68-95 Rule.  It can be visualized below in Figure[68-95 Rule 2].
 
![68-95 Rule 2:  This graph is the visualization of the second part of the 68-95 Rule for the distribution of the sample means.](/images/figure/empruletwo.png) 

 
In approximately 95% of all samples of size 50, the sample mean, $\bar{x}$, will fall within 2 standard deviations of $\mu$, the population parameter.  
 
So, for approximately 95% of all samples, 
$$\mu-2 \cdot SD\leq \bar{x} \leq \mu+2\cdot SD.$$
 
Rearranging this:
$$\bar{x}-2\cdot SD\leq \mu \leq \bar{x}+2\cdot SD.$$
 
In other words, approximately 95% of the time, the population parameter, $\mu$, is in the interval $(\bar{x}-2\cdot SD,\mbox{ } \bar{x}+2\cdot SD)$.  This sounds like a confidence interval!
 
We do have one problem, however:  a statistician with no knowledge of the population has no way of knowing $SD(\bar{x})$ because it requires knowing the standard deviation of the population, $\sigma$.  Hence we must use our best estimate of the standard deviation---the standard error---in its place.
 
So, an approximate 95% confidence interval for the population mean can be given by $$(\bar{x}-2\cdot SE,\mbox{  } \bar{x}+2\cdot SE).$$
 
Let's compute this numerically for our example.  We will find the needed values by looking at `favstats` for the sample.
 

    ## Error: object 'mysample' not found

 

    favstats(~income,data=mysample)

    ## Error: object 'mysample' not found

 
 
We are now equipped with all the information we need to compute the approximate 95% confidence interval for the population mean.
 
* $\bar{x}=$ 

    
    Error in format(stats.income[6], scientific = FALSE) : 
      object 'stats.income' not found
    


 
* $s=$ 

    
    Error in format(stats.income[7], scientific = FALSE) : 
      object 'stats.income' not found
    

   *Note* that $s$ is the standard deviation of the sample.
  
* $n=$ 

    
    Error in format(stats.income[8], scientific = FALSE) : 
      object 'stats.income' not found
    


 
* $SE=\dfrac{s}{\sqrt{n}}=\dfrac{

    
    Error in format(stats.income[7], scientific = FALSE) : 
      object 'stats.income' not found
    

 }{\sqrt{

    
    Error in format(stats.income[8], scientific = FALSE) : 
      object 'stats.income' not found
    

}}=

    
    Error in eval(expr, envir, enclos) : object 'stats.income' not found
    

$  
 
* $\mbox{CI}=(\bar{x}-2\cdot SE,\mbox{  } \bar{x}+2\cdot SE)=$(

    
    Error in format(stats.income[6], scientific = FALSE) : 
      object 'stats.income' not found
    

 $-2\cdot$ 

    
    Error in format(stats.income[7], scientific = FALSE) : 
      object 'stats.income' not found
    

, 

    
    Error in format(stats.income[6], scientific = FALSE) : 
      object 'stats.income' not found
    

 $+2\cdot$ 

    
    Error in format(stats.income[7], scientific = FALSE) : 
      object 'stats.income' not found
    

) = (

    
    Error in format(stats.income[6] - 2 * (stats.income[7]/sqrt(stats.income[8])),  : 
      object 'stats.income' not found
    

, 

    
    Error in format(stats.income[6] + 2 * (stats.income[7]/sqrt(stats.income[8])),  : 
      object 'stats.income' not found
    

)
  * *Note:* The $2\cdot SE$ is the *margin of error*.
 
Based on the 68-95 Rule, we can say that we are *about* 95% confident that the  population mean income for the folks in `imagpop` falls somewhere in the interval ($

    
    Error in format(stats.income[6] - 2 * (stats.income[7]/sqrt(stats.income[8])),  : 
      object 'stats.income' not found
    

, $

    
    Error in format(stats.income[6] + 2 * (stats.income[7]/sqrt(stats.income[8])),  : 
      object 'stats.income' not found
    

). 
This seems to make sense, but this is not the confidence interval that the `t.testGC` function gave us originally.  The interval from `t.testGC` was ($34355,$47497).  We seem to be off by a little bit.    
 
There are a couple of important details related to the *multiplier* that account for this difference.  The second part of the 68-95 Rule prompted us to use the multiplier 2 when we calculated the 95% confidence interval.  This is a good approximation of the multiplier, but it's not the best we can do.  
 
Let's take a look at a **standard normal curve** to see if we can find a better multiplier.  A standard normal curve has $\mu=0$ and $\sigma=1$.  The 68-95 Rule suggests that the shaded area of the curve between $z=-2$ and $-z=2$ will be approximately 0.95.  See Figure[Two SD].
 
![Two SD:  This graph shows the true area under the curve within two standard deviations of the mean.](/images/figure/twosd.png) 

 
The shaded region is actually 0.9545.  This is because 68-95 Rule is just an approximation.  Since we are looking for a 95% confidence interval, we would like our multiplier, or $z$-score, to be such that the shaded region is exactly 0.95, not 0.9545.
 
We can find the appropriate $z$ and $-z$ by making use of the quantiles of the normal curve via the ``qnorm`` function that we saw in Chapter 7.  If we want 0.95 in the middle, then the shaded area to the left of $z$ is 0.975 - the 0.95 for the middle and the 0.025 for the left tail. 
 


 

    qnorm(0.975,mean=0,sd=1)

    ## [1] 1.96

 
Likewise, the shaded area to the left of $-z$ is 0.025.  
 


 

    qnorm(0.025,mean=0,sd=1)

    ## [1] -1.96

 
Let's check that we have the correct values by looking at the shaded region between these two $z$-scores.  The graph appears in Figure [Better 95% Multiplier].
 

    pnormGC(c(-1.96,1.96),region="between"
            ,mean=0,sd=1,graph=TRUE)

 
![Better 95% Multiplier.  1.96 works out a bit better than 2.](/images/figure/better95mult.png) 

 
That's better!  Let's adjust our formula for our 95% confidence interval.
 
$$(\bar{x}-1.96 \cdot SE, \mbox{ } \bar{x}+ 1.96\cdot SE)$$
 
We can now re-compute our 95% confidence interval using this new formula:  $\mbox{CI}=(\bar{x}-1.96\cdot SE,\mbox{  } \bar{x}+1.96\cdot SE)=$ (

    
    Error in format(stats.income[6] - 1.96 * (stats.income[7]/sqrt(stats.income[8])),  : 
      object 'stats.income' not found
    

, 

    
    Error in format(stats.income[6] + 1.96 * (stats.income[7]/sqrt(stats.income[8])),  : 
      object 'stats.income' not found
    

).
 
Summarizing what we've done so far:
 
* Using R's `t.test` function, $CI=$ ($34355, $47497).
 
* Using the multiplier 2 from the 68-95 Rule, $CI=$ ($

    
    Error in format(stats.income[6] - 2 * (stats.income[7]/sqrt(stats.income[8])),  : 
      object 'stats.income' not found
    

, $

    
    Error in format(stats.income[6] + 2 * (stats.income[7]/sqrt(stats.income[8])),  : 
      object 'stats.income' not found
    

)
 
* Now, using the multiplier $z=1.96$, $CI=$ ($

    
    Error in format(stats.income[6] - 1.96 * (stats.income[7]/sqrt(stats.income[8])),  : 
      object 'stats.income' not found
    

, $

    
    Error in format(stats.income[6] + 1.96 * (stats.income[7]/sqrt(stats.income[8])),  : 
      object 'stats.income' not found
    

)
 
We still don't have the multiplier quite right.  Our problem stems from us, as statisticians, not knowing the population standard deviation, $\sigma$. Not knowing $\sigma$ means that we don't know $SD(\bar{x})$.  $SD(\bar{x})$ has crept up in a couple of different places.  First, $SD(\bar{x})$ was replaced with $SE(\bar{x})$ in the formula for the confidence interval.  Also, $SD(\bar{x})$ is the denominator in the formula for $z$-score, which is what we are using as our multiplier.  Using $SE(\bar{x})$ as an approximation for $SD(\bar{x})$ in both of these situations is okay if we are dealing with large sample sizes.  However, for smaller sample sizes, this approximation is often off the mark.
 
Recall that the formula for the $z$-score is
 
$$z=\dfrac{\bar{x}-\mu}{SD(\bar{x})}=\dfrac{\bar{x}-\mu}{\frac{\sigma}{\sqrt{n}}}.$$
 
When we replace the denominator in the formula for the $z$-score with $SE(\bar{x})$, we call it a $t$-statistic.  The formula for the $t$-statistic is
 
$$t=\dfrac{\bar{x}-\mu}{SE(\bar{x})}=\dfrac{\bar{x}-\mu}{\frac{s}{\sqrt{n}}}.$$
 
Just as the $z$-score told us how many standard deviations a value was from the mean, the $t$-statistic tells us how many **standard errors** a value is from the mean.  Also, just like the $z$-score is associated with the normal distribution, the $t$-statistic is associated with the $t$-distribution.  The $t$-distribution is a distribution that we have not discussed yet, but it is very similar to the normal distribution.
 
 
* The $t$-distribution, like the normal distribution, is symmetric and bell-shaped.
 
* The $t$-distribution looks slightly different for different sample sizes.  For this reason, the $t$-distribution depends on something we call *degrees of freedom* $= df= n-1$.
 
* The larger the sample size, $n$, the more the $t$-distribution looks like the normal distribution.
 
You can investigate the shape of the $t$-distribution and compare it to the normal curve using the following app.
 

    require(manipulate)
    tExplore()

 
You may have noticed that when the sample size is small, the $t$-distribution is more spread out - it carries more weight in its tails.  This is a result of $SE(\bar{x})$ doing a poor job approximating $SD(\bar{x})$ for small sample sizes.  Since $t$ actually relies on the standard error, it is better to use a $t$-multiplier instead of a $z$-multiplier for small sample sizes.  
 
For large samples, it would be okay to use the $z$-multiplier in the construction of confidence intervals.  However, as $n$ increases, the $t$-distribution starts looking more and more like the normal curve.  (This is because $SE(\bar{x})$ is a better approximation of $SD(\bar{x})$ for large $n$.)  Since the $t$-statistic is a good approximation for the $z$-score when the sample size is large, we will remain consistent and **always** use the $t$-distribution to calculate confidence intervals for population means, regardless of the sample size.  If you are interested in learning more about the distinction between $t$ and $z$, consult the GeekNotes. 
 
We can find the $t$-multiplier just as we found $z=1.96$ before, except we will be dealing with the $t$-distribution instead of the normal distribution.  For our example, the $df=n-1=50-1=49$.
 


 

    qt(0.975, df=49)

    ## [1] 2.01

    qt(0.025,df=49)

    ## [1] -2.01

 
 
Similar to the function `pnormGC`, the function `ptGC` allows us to look at the shaded region between these two $t$-statistics:
 

    ptGC(c(-2.01,2.01),region="between",df=49,graph=TRUE)

 
The graph appears in Figure [t-Multiplier].
 
![t-Multiplier.   The multiplier for sample size 50 is about 2.01.](/images/figure/unnamed-chunk-22.png) 

 
Since $t=2.01$ is the correct multiplier, let's recompute the confidence interval with it and compare to our previous calculations:  $\mbox{CI}=(\bar{x}-2.01\cdot SE,\mbox{  } \bar{x}+2.01\cdot SE)=$ (

    
    Error in format(stats.income[6] - t.upper * (stats.income[7]/sqrt(stats.income[8])),  : 
      object 'stats.income' not found
    

, 

    
    Error in format(stats.income[6] + t.upper * (stats.income[7]/sqrt(stats.income[8])),  : 
      object 'stats.income' not found
    

)
 
* Using R's `t.testGC` function, $CI=$ ($34355, $47497).
 
* Using the multiplier 2 from the 68-95 Rule, $CI=$ ($

    
    Error in format(stats.income[6] - 2 * (stats.income[7]/sqrt(stats.income[8])),  : 
      object 'stats.income' not found
    

, $

    
    Error in format(stats.income[6] + 2 * (stats.income[7]/sqrt(stats.income[8])),  : 
      object 'stats.income' not found
    

)
 
* Using the multiplier $z=1.96$, $CI=$ ($

    
    Error in format(stats.income[6] - 1.96 * (stats.income[7]/sqrt(stats.income[8])),  : 
      object 'stats.income' not found
    

, $

    
    Error in format(stats.income[6] + 1.96 * (stats.income[7]/sqrt(stats.income[8])),  : 
      object 'stats.income' not found
    

)
 
* Now, using the multiplier $t=2.01$, $CI=$ ($

    
    Error in format(stats.income[6] - t.upper * (stats.income[7]/sqrt(stats.income[8])),  : 
      object 'stats.income' not found
    

, $

    
    Error in format(stats.income[6] + t.upper * (stats.income[7]/sqrt(stats.income[8])),  : 
      object 'stats.income' not found
    

)
 
**Summary**: In general, the formula to compute a 95% confidence interval to estimate a population mean is $$\mbox{CI}=(\bar{x}-t \cdot SE,\mbox{  } \bar{x}+t \cdot SE),$$
where $t$ is calculated from the $t$-distribution based on the appropriate degress of freedom.  Keep in mind that the packaged function, `t.testGC`, in R does all of this work for you. 
 
Since the construction of confidence intervals for means depends on the $t$-distribution, *Condition 1* of the safety check should really be a condition that verifies that the sampling distribution of the $t$-statistic approximately follows a $t$-distribution.  Above (and in Chapter 7) we said that $n\geq 30$ ensured us that $\bar{x}$ was approximately  normal.  It turns out that $n\geq 30$ also ensures us that the $t$-statistic approximately follow a $t$-curve.  (So what we actually check in *condition 1* is the same.)  You can investigate this idea with the following app.
 

    require(manipulate)
    tSampler(~income,data=imagpop)

 
For small sample sizes, you can see how the distribution of the t-statistic differs substantially from the $t$-distribution.  However, for sample sizes around 30 you can't really tell the difference.  This is why we require that $n\geq 30$.
 
### Additional Example, and Further Ideas
 
  >**Research Question**:  What is the average height of **all** GC students?
 
**Step One:**  *Definition of parameter.*
 
Let $\mu=$ mean height of GC student population.
 
**Step Two:**  *Safety Check and Calculation of the Confidence Interval*
 
For this problem, we are using the observations in our `m111survey` dataset as our sample.  The population is **all** GC students.  
 
Let's check the two conditions of the safety check.
 
* Condition 1:  **The population is roughly normal in shape or the sample size, $n$, is at least 30.**  To check this, take a look at `favstats`.
 

    ##  min Q1 median    Q3 max  mean    sd  n missing
    ##   51 65     68 71.75  79 67.99 5.296 71       0

 
There are 71 people in the survey data, so our sample size $n=71$ is large enough that we don't need to investigate the shape of the sample data.
 
* Condition 2:  **The sample is like a SRS from the population, at least in regard to the variables of interest.**  
 
Our sample of students in this survey consists of all students enrolled in MAT 111 in a particular semester.  You might question if this constitutes a SRS of all GC students. Students certainly decide to enroll in MAT 111 for specific reasons such as it being a requirement for their major.  However, their decision probably has nothing to do with their height.  In other words, one's height and the decision to enroll in MAT 111 are unrelated.  So, in regards to the variable `height`, the students in the survey constitute a sample that is representative of the population (at least as much so as any simple random sample would).
 
Since the safety check is passed, let's compute a 95% confidence interval.
 


 

    ## 
    ## 
    ## Inferential Procedures for One Mean mu:
    ## 
    ## 
    ## Descriptive Results:
    ## 
    ##  variable  mean    sd  n
    ##    height 67.99 5.296 71
    ## 
    ## 
    ## Inferential Results:
    ## 
    ## Estimate of mu:	 67.99 
    ## SE(x.bar):	 0.6286 
    ## 
    ## 95% Confidence Interval for mu:
    ## 
    ##           lower.bound         upper.bound          
    ##           66.732979           69.240260

 
Our 95% confidence interval for the estimation of the population mean, $\mu$, is (66.73,69.24) inches.
 
**Step Three:**  *Interpretation of the Confidence Interval*
 
We are 95% confident that if the average height of the GC student population were known, the interval (66.73,69.24) would contain it.  Put another way, (66.73,69.24) gives the most believable values for the average height of the GC student population.
 
**Step Four:**  *Write a Conclusion.*
 
We can be reasonably sure that the average height of the GC student population is between 66.73 inches and 69.24 inches.
 
**Additional Note:**  A confidence interval with any other confidence level can be calculated easily by just adding an extra argument, `conf.level`, into the `t.testGC` function.  We could calculate a 99% confidence interval as follows.
 


 

    t.testGC(~height,data=m111survey,conf.level=0.99)

    ## 
    ## 
    ## Inferential Procedures for One Mean mu:
    ## 
    ## 
    ## Descriptive Results:
    ## 
    ##  variable  mean    sd  n
    ##    height 67.99 5.296 71
    ## 
    ## 
    ## Inferential Results:
    ## 
    ## Estimate of mu:	 67.99 
    ## SE(x.bar):	 0.6286 
    ## 
    ## 99% Confidence Interval for mu:
    ## 
    ##           lower.bound         upper.bound          
    ##           66.322230           69.651010

 
 
We are 99% confident that if the average height of the GC student population were known, the interval (66.32,69.65) would contain it.
 
Check out a 68% confidence interval:
 


 

    t.testGC(~height,data=m111survey,conf.level=0.68)

    ## 
    ## 
    ## Inferential Procedures for One Mean mu:
    ## 
    ## 
    ## Descriptive Results:
    ## 
    ##  variable  mean    sd  n
    ##    height 67.99 5.296 71
    ## 
    ## 
    ## Inferential Results:
    ## 
    ## Estimate of mu:	 67.99 
    ## SE(x.bar):	 0.6286 
    ## 
    ## 68% Confidence Interval for mu:
    ## 
    ##           lower.bound         upper.bound          
    ##           67.357063           68.616177

 
 
Let's compare the widths of these three confidence intervals - 68%, 95%, and 99%.  For the mean height of the GC student population,
 
* (67.36,68.62) is a 68% CI and has width  1.2591.
 
* (66.73,69.24) is a 95% CI and has width 2.5073.
 
* (66.32,69.65) is a 99% CI and has width 3.3288.
 
You can see that higher confidence levels produce wider intervals.  Wider intervals cover a broader range of numbers so you're more confident that the population parameter is in that interval.  There are two things that affect the width of a confidence interval:
 
* multiplier
* sample size  
 
In this case, the sample size is the same, so the multiplier is responsible for the width of the interval.  Recall that the multiplier is the number from the $t$ distribution that captures a specified percentage of the area between the multiplier and the multiplier's negative.   As we move more standard errors away from the center, the value of $t$ increases.  We also capture more of the area under the curve, which corresponds to a higher confidence level.  Thus, when the sample size is held constant, higher confidence levels produce wider confidence intervals.  This can be visualized in the three $t$-distributions with $df=70$ shown below.  See Figure[68% t-Distribution], Figure[95% t-Distribution], and Figure[99% t-Distribution].
 


 
![68% t-Distribution:  Visualization of the t-multiplier used in the construction of a 68% confidence interval for one population mean.](/images/figure/t68.png) 

 
![95% t-Distribution:  Visualization of the t-multiplier used in the construction of a 95% confidence interval for one population mean.](/images/figure/t95.png) 

 
![99% t-Distribution:  Visualization of the t-multiplier used in the construction of a 99% confidence interval for one population mean.](/images/figure/t99.png) 

 
 
 
 
 
 
 
## Difference of Two Population Means, $\mu_1-\mu_2$
 
 
  >**Research Question**:  Do GC males sleep more at night, on average, than GC females?
 
### The Four Steps
 
**Step One:**  *Definition of Parameter(s)*
 
For this problem, we are dealing with two populations - all GC males and all GC females - for which we don't know the mean hours of sleep per night of either one.
 
  >Let $\mu_1=$ the mean hours of sleep per night for all GC females.
 
  >Let $\mu_2=$ the mean hours of sleep per night for all GC males.
  
We sre interested in the difference, $\mu_1-\mu_2$.
 
**Step Two:**  *Safety Check and Calculation of the Confidence Interval*
 
For this parameter, we also have two conditions for our safety check.  However, the conditions are slightly different.
 
* Condition 1: **Both populations are roughly normal in shape or the sample sizes, $n_1$ and $n_2$, are both at least 30.**  To check this condition, let's take a look at `favstats`. 
 

    ##        min Q1 median    Q3 max  mean    sd  n missing
    ## female   2  5   6.75 7.125   9 6.325 1.619 40       0
    ## male     4  5   7.00 7.000  10 6.484 1.557 31       0

 
 
 
 
The sample size for females is $n_1=$ 40 and the sample size for males is $n_2=$ 31, so both samples are large enough.
 
Since our sample of males was barely 'large enough', perhaps it's a good idea to take a look at the distribution of the samples just to make sure we aren't dealing with outliers or extreme skewness.  See Figure[Sleep Histograms].
 
![Sleep Histograms:  The histogram on the left shows the hours of sleep that females in the sample get.  The histogram on the right shows the hours of sleep that males in the sample get.](/images/figure/histsleepbysex.png) 

 
There do not seem to be any outliers and neither histogram looks extremely skewed.  Couple that with the fact that both sample sizes were, in fact, large enough, this part of the safety check is okay.
 
* Condition 2:  One of two things is true:
 
    * **We did a completely randomized experiment and the two samples are the two treatment groups in the experiment.**  
 
    * **We took two independent random samples from two populations.  This means that the samples have nothing to do with one another.**
  
Since this research question is a result of an observational study (the explanatory variable was simply observed, not assigned), then we need to verify the second part of this condition.  Since the hours of sleep per night that an individual gets is not related to their being enrolled in MAT 111, we can say that with regard to the variable `sleep`, the sample is representative of the population of GC students.  We could extend this statement to say that the sample of males and the sample of females are like simple random samples from their respective populations, at least in terms of the variable `sleep`.
 
We will now compute the confidence interval.  We could choose to compute a confidence interval for any desired confidence level, but let's just stick to the typical 95%.  
 
We will use the same ``t.testGC`` as we did for one population mean.  The argument ``first`` should indicate which group is being considered for the first mean.  In our assignment of the parameter, we let $\mu_1$ represent the means of the female, so we need to set ``first="female"`` in the function.
 
 


 

    t.testGC(sleep~sex,data=m111survey,first="female")

    ## 
    ## 
    ## Inferential Procedures for the Difference of Two Means mu1-mu2:
    ## 	(Welch's Approximation Used for Degrees of Freedom)
    ## 	 sleep grouped by sex 
    ## 
    ## 
    ## Descriptive Results:
    ## 
    ##   group  mean    sd  n
    ##  female 6.325 1.619 40
    ##    male 6.484 1.557 31
    ## 
    ## 
    ## Inferential Results:
    ## 
    ## Estimate of mu1-mu2:	 -0.1589 
    ## SE(mu1.hat - mu2.hat):	 0.3792 
    ## 
    ## 95% Confidence Interval for mu1-mu2:
    ## 
    ##           lower.bound         upper.bound          
    ##           -0.915971           0.598229

 
Our 95% confidence interval for the estimation of the population difference in the average number of hours a GC female sleeps and the average number of hours a GC male sleeps at night, $\mu_1-\mu_2$, is (-0.916,0.5982) hours.
 
**Step Three:**  *Interpretation of the Confidence Interval*
 
We are 95% confident that if the average difference in hours of sleep per night between GC females and GC males were known, the interval (-0.916,0.5982) would contain it.  Put another way, (-0.916,0.5982) gives the most believable values for this difference.
 
**Step Four:**  *Write a Conclusion.*
 
We are reasonably sure that the difference in the average hours of sleep per night of GC females and GC males is between -0.916 and 0.5982.
 
The original Research Question asked whether GC males sleep more, on average, than GC females do.  If this were so, then $\mu_1-\mu_2$ would be negative.  Observe, however, that the confidence interval for $\mu_1-\mu_2$ contains zero and some positive values, as well as negative ones:  hence we cannot rule out the view that females sleep as much as males do ($\mu_1-\mu_2=0$) or even more than males do ($\mu_1-\mu_2 > 0$).
 
### Under the Hood
 
#### Calculation of CI
 
Let's check out the actual calculation of this interval.  The formula follows the same ideas as what we discussed for one population mean.   
 
$$\bigg((\bar{x_1}-\bar{x_2}) \mbox{ }\pm \mbox{ }t\cdot SE(\bar{x_1}-\bar{x_2})\bigg)$$
 
where $SE(\bar{x_1}-\bar{x_2})=\sqrt{\dfrac{s_1^2}{n_1}+\dfrac{s_2^2}{n_2}}$.
 
All of these values, except for $t$ can be found from `favstats`:
 

    ##        min Q1 median    Q3 max  mean    sd  n missing
    ## female   2  5   6.75 7.125   9 6.325 1.619 40       0
    ## male     4  5   7.00 7.000  10 6.484 1.557 31       0

 
* $\bar{x_1}=$ sample mean hours of sleep per night for females = 6.325
* $\bar{x_2}=$ sample mean hours of sleep per night for males = 6.4839
* $s_1=$ sample standard deviation for females = 1.6194
* $s_2=$ sample standard deviation for males = 1.5572
* $n_1=$ sample size of females = 40
* $n_2=$ sample size for males = 31
 
To find the multiplier $t$, recall that the $t$-distribution relies on $df=n-1$.  In this case, we have two sample sizes, $n_1$ and $n_2$. There are various methods for finding $df$ for this case, but we won't go into detail here. (If you want to learn more, consult GeekNotes.) To construct this interval by hand, we can look to see what `t.test` used for $df$ and perform the calculation from there.  From the test results above, $df=$ 65.81.  So, $t$ can be found as we did before.
 


 

    qt(0.975,df=65.81)

    ## [1] 1.997

 
 
Our 95% confidence interval for the difference of means can be computed as follows:
 
$$\bigg((\bar{x_1}-\bar{x_2}) \mbox{ }\pm \mbox{ }t\cdot SE(\bar{x_1}-\bar{x_2})\bigg),$$
 
which becomes
 
$$\bigg((6.325-6.4839) \pm 1.997 \cdot \sqrt{\dfrac{1.6194^2}{40}+\dfrac{1.5572}{31}}  \bigg),$$
 
which in turn reduces to
 
$$\bigg( -0.9161, 0.5984 \bigg).$$
 
 
 
#### Order of Groups
 
 
Our original interpretation stated that (-0.916,0.5982) gives the most believable values for the difference between the average amount of sleep a GC female and a GC male get per night.  We can actually say more than that.  
 
Notice how the interval covers 0.  In other words, zero is a plausible value for the population parameter.  If the true mean difference in hours of sleep between females and males were 0, this would tell us that GC females and males get the same amount of sleep per night, on average.  
 
Negative numbers are also included in the interval.  If $\mu_1-\mu_2$ (females - males) were a negative value, this would mean that males get more sleep on average than females.  
 
Positive numbers are included in our confidence interval, as well.  If $\mu_1-\mu_2$ were a positive number, this would mean that females get more sleep on average than males.  
 
Since our confidence interval contains the most believable values for $\mu_1-\mu_2$, all of these values are reasonable.  In other words, because our confidence interval spans 0, it does not give us a good idea which sex actually gets more sleep on average.  When you are examining the difference of means, it is important to know which mean you are treating as $\mu_1$ and which you are treating as $\mu_2$, so that you can correctly interpret positive and negative numbers.
 
 
### Additional Example
 
Let's consider a research question that depends on summary data rather than a built-in dataset in R.
 
  >**Research Question**:  For a randomly selected sample of 36 men from a certain population, the mean head circumference is 57.5 cm with a standard deviation equal to 2.4 cm.  For a randomly selected sample of 36 women from the population, the mean head circumference is 55.3 cm with a standard deviation equal to 1.8 cm.  What is the average difference in head circumference between men and women for this population?
 
**Step One**: *Definition of Parameter(s)*
 
Since we are dealing with two populations - men and women - the parameter of interest is the difference of means. 
 
  >Let $\mu_1=$ the mean head circumference of the females in the population.
 
  >Let $\mu_2=$ the mean head circumference of the males in the population.
 
**Step Two**: *Safety Check and Calculation of the Confidence Interval*
 
* Condition 1: **Both populations are roughly normal in shape or the sample sizes, $n_1$ and $n_2$, are both at least 30.**  
 
Since we are dealing with summary data for this example, we are not able to plot histograms or look at `favstats`.  We will have to rely only on the information given in the problem.  Since we are told that both samples are at least of size 30, this is good enough to satisfy this condition.
 
* Condition 2:  **One of two things is true**:
      * We did a completely randomized experiment and the two samples are the two treatment groups in the experiment.  
      * We took two independent random samples from two populations.  This means that the samples have nothing to do with one another.
  
Again, in this example we are dealing with an observational study, not an experiment.  We can also assume that since the samples were drawn randomly from a population of men and a population of women, they have nothing to do with one another.  This condition is satisfied as well.
 
Let's compute a 95% confidence interval. We will have to input our summary data.  Be sure to input the summary consistent with the order that the parameters were assigned in Step 1.
 
 


 

    t.testGC(mean=c(55.3,57.5),sd=c(1.8,2.4),n=c(36,36))

    ## 
    ## 
    ## Inferential Procedures for the Difference of Two Means mu1-mu2:
    ## 	(Welch's Approximation Used for Degrees of Freedom)
    ## 	Results from summary data.
    ## 
    ## 
    ## Descriptive Results:
    ## 
    ##    group mean  sd  n
    ##  Group 1 55.3 1.8 36
    ##  Group 2 57.5 2.4 36
    ## 
    ## 
    ## Inferential Results:
    ## 
    ## Estimate of mu1-mu2:	 -2.2 
    ## SE(mu1.hat - mu2.hat):	 0.5 
    ## 
    ## 95% Confidence Interval for mu1-mu2:
    ## 
    ##           lower.bound         upper.bound          
    ##           -3.198595           -1.201405

 
The 95% confidence interval for the population mean difference in head circumference (females - males) is (-3.1986, -1.2014) centimeters.
 
**Step Three**: *Interpretation of the Confidence Interval*
 
We are 95% confident that if the population mean difference in head circumference (females - males) were known, it would lie in the interval (-3.1986, -1.2014).
 
Since all of the numbers in this interval are negative, we can say with 95% confidence that the average head circumference for males in this population is larger than the average head circumference for females.  We could go even further to say that males are likely to have at least a 1.2 cm larger head circumference, on average, than females.
 
**Step Four**:  *Write a Conclusion*
 
We are reasonably sure that the average head circumference for males in this population is larger than the average head circumference for females.  The difference between the average head circumferences for females and males is likely to be a number in the range (-3.1986, -1.2014) centimeters.
 
 
## Mean of Differences, $\mu_d$
 
 
  >**Research Question**: Does the ideal height of GC students differ, on average, than their actual height?
  
We will use the ``m111survey`` dataset to answer this research question.
 
### The Four Steps
 
**Step One:**  *Definition of Parameter(s)*
 
This was a *repeated-design* study - we are comparing the answers that each individual gave to two questions.  You cannot think of this as two populations---actual height and ideal height---because these two populations are not independent.  The actual height and ideal height are coming from the same person!  Thus, this is not a difference of means, but it is a **mean of differences**.
 
Let $\mu_d=$ the mean of the difference between the ideal height and actual height of all students in the GC population.
 
**Step Two:**  *Safety Check and Calculation of the Confidence Interval*
 
Since we are again dealing with one mean from one population, the safety check will be the same as it was for the *one population mean* case that we studied above.
 
* Condition 1:  **The population is roughly normal in shape or the sample size, $n$, is at least 30.**  
 
Let's look again at `favstats` for this sample.  
 

    ##  min Q1 median Q3 max  mean    sd  n missing
    ##   -4  0      2  3  18 1.946 3.206 69       2

 
The sample size for this variable is 69 which is larger than 30, so it's big enough.
 
* Condition 2:  **The sample is like a simple random sample from the population, at least in regard to the variables of interest.**  
 
As we've said before, the variable `height` is unrelated to an individual's decision to enroll in MAT 111.  For this reason, our sample from MAT 111 students can be regarded as a simple random sample of all GC students.
 
Since the safety check is passed, let's go ahead and compute a 95% confidence interval.
 


 

    t.testGC(~ideal_ht-height,data=m111survey) 

    ## 
    ## 
    ## Inferential Procedures for the Difference of Means mu-d:
    ## 	 height minus ideal_ht 
    ## 
    ## 
    ## Descriptive Results:
    ## 
    ##         Difference mean.difference sd.difference  n
    ##  ideal_ht - height           1.946         3.206 69
    ## 
    ## 
    ## Inferential Results:
    ## 
    ## Estimate of mu-d:	 1.946 
    ## SE(d.bar):	 0.3859 
    ## 
    ## 95% Confidence Interval for mu-d:
    ## 
    ##           lower.bound         upper.bound          
    ##           1.175528            2.715776

 
 
Our 95% confidence interval for the estimation of the GC mean difference between ideal and actual heights, $\mu_d$, is (1.176,2.716) inches.
 
 
**Step Three:**  *Interpretation of the Confidence Interval*
 
We are 95% confident that if the true population mean difference in ideal and actual heights were known, the interval (1.176,2.716) would contain it.  In other words, this interval gives the most believable values for $\mu_d$.
 
Since this entire interval lies above 0, the reasonable values for $\mu_d$ are all positive.  Since we took `ideal height` - `actual height`, this indicates that an individual's ideal height is likely to be greater than their actual height.  
 
**Step Four:**  *Write a Conclusion.*
 
In the GC population, it is likely that the mean difference between a student's ideal height and their actual height is between 1.176 inches and 2.716 inches.  Since the interval lies entirely above the number 0, we are pretty sure that GC students wish that they were taller than they are, on average.
 
### Under the Hood
 
The calculation of a confidence interval for the **mean of differences** works exactly like it did for **one population mean**.
 
### Additional Example
 
Let's do an example with summary data.  A simple random sample of 30 college women was taken.  Each woman was asked to provide her own height, in inches, and her mother's height, in inches.  The difference in heights was computed for each woman.  Check out favstats for the data.
 

    ##    min     Q1 median    Q3  max  mean    sd  n missing
    ##  -1.99 -0.105   1.61 3.885 7.56 1.853 2.508 30       0

 
  >**Research Question**:  Are college women taller, on average, than their mothers?
 
 
**Step One**  *Define the Parameter(s)*
 
It might seem that you are dealing with two populations in this case - mothers' heights and daughters' heights.  However, these two groups are not independent.  An individual's height is very much dependent on the heights of their parents.  
 
For this situation, we are dealing with *matched pairs*, so we are interested in a **mean of differences**.  Each mother and daughter pair constitute one matched pair.  T
 
Let $\mu_d=$ the mean difference in heights of college women and their mothers.
 
**Step Two:** *Safety Check and Construction of the Confidence Interval*
 
* Condition 1:  **The population is roughly normal in shape or the sample size, $n$, is at least 30.**  
 
Since we have 30 mother/daughter pairs, our sample size is $n=30$.  Since this is right on the borderline of 'big enough', let's take a look at the distribution of these differences.  We want to be aware of extreme skewness and/or the presence of outliers.  Let's look at this with a boxplot.  See Figure[Boxplot of Differences].
 
![Boxplot of Differences:  The distribution of the differences of college women's heights and their mother's heights.](/images/figure/boxplotheights.png) 

 
The distribution looks fairly symmetric without any outliers. 
 
* Condition 2:  **The sample is like a simple random sample from the population, at least in regard to the variables of interest.** 
 
We are told that a simple random sample was taken, so we will accept that and continue on to the construction of the confidence interval.
 


 

    t.testGC(mean=1.852667,sd=2.507909,n=30)

    ## 
    ## 
    ## Inferential Procedures for One Mean mu:
    ## 
    ## 
    ## Descriptive Results:
    ## 
    ##   mean    sd  n
    ##  1.853 2.508 30
    ## 
    ## 
    ## Inferential Results:
    ## 
    ## Estimate of mu:	 1.853 
    ## SE(x.bar):	 0.4579 
    ## 
    ## 95% Confidence Interval for mu:
    ## 
    ##           lower.bound         upper.bound          
    ##           0.916198            2.789136

 
The 95% confidence interval for the mean difference in heights of college women and their mothers is (0.9162,2.789) inches.
 
**Step Three**  *Interpretation of the Confidence Interval*
 
We are 95% confident that if the true population mean of differences of heights between college women and their mothers were known, it would fall in the interval (0.9162,2.789).  Since this is an interval of all positive numbers, we can say with 95% confidence that college women are taller than their mothers, on average.
 
**Step Four**  *Write a Conclusion*
 
A reasonable difference for the average difference in height between a college woman and her mother is any number between 0.9162 inches and 2.789 inches.  On average, college women are taller than their mothers. 
 
 
 
## One Population Proportion, $p$
 
  >**Research Question**:   What is the proportion of GC students that believe in love at first sight?
  
Let's use the ``m111survey`` dataset to answer this research question.
 
### The Four Steps
 
Here, the parameter of interest is a single population proportion. 
 
**Step One:**  *Definition of Parameter(s)*
 
  >Let $p=$ the proportion of all GC students that believe in love at first sight.
 
**Step Two:**  *Safety Check and Calculation of the Confidence Interval*
 
The statistic we will be using the estimate the population proportion is:
 
$$\hat{p}=\dfrac{X}{n},$$
 
where:
 
* $X=$ number of students in the sample that believe in love at first sight, and
* $n=$ the total number of students in the sample.  
 
Notice that $X$ is a binomial random variable.  A "success" is defined as believing in love at first sight.  
 
We know from Chapter 8 that when the number of trials, $n$, is large enough, then the distribution of a binomial random variable looks very much like a normal curve.  We saw that our sample was "big enough" if there are least 10 successes and at least 10 failures.  
 
Therefore, the safety check for proportions is only slightly different than the safety checks that we have been doing for means.  Again, we want to check that the distribution for the statistic, $\hat{p}$, is approximately normal.  This is important because, as you may recall, our beginning discussions of the construction of a confidence interval depended on the normal curve and the 68-95 Rule.  
 
 
**Condition 1**:  **The sample size is large enough if there are at least 10 successes and at least 10 failures in the sample.**  
 
Let's take a look at the table of counts and table of percents:
 

    ## love_first
    ##  no yes 
    ##  45  26

 
So, there are 26 successes (students in the sample that believe in love at first sight) and there are 45 failures (students in the sample that do not believe in love at first sight).
 
Let's check the second condition.
 
**Condition 2**: **The sample is like a simple random sample from the population, at least in regard to the variables of interest.**
 
Again, this is debatable since we are dealing with a sample of only those students enrolled in MAT 111 in a given semester.  However, believing in love at first sight seems to be totally unrelated to an individual enrolling in MAT 111.  For this reason, our sample can be regarded as a SRS from the population of GC students, in regards to the variable `love_first`.
 
Let's construct the confidence interval.  The function that we will use for this parameter is `binom.testGC`.  It works similarly to  ``t.testGC`` that we used for means.  The main difference is that we need to input what a "success" is defined to be.
 
 

    binom.testGC(~love_first,data=m111survey,success="yes")

    ## 
    ## Exact Binomial Procedures for a Single Proportion p:
    ## 	Variable under study is love_first 
    ## 
    ## 
    ## Descriptive Results:  26 successes in 71 trials
    ## 
    ## Inferential Results:
    ## 
    ## Estimate of p:	 0.3662 
    ## SE(p.hat):	 0.05717 
    ## 
    ## 95% Confidence Interval for p:
    ## 
    ##           lower.bound         upper.bound          
    ##           0.254958            0.488976

 
 
The 95% confidence interval for the population proportion is (0.254958 , 0.488976).  
 
**Step Three:**  *Interpretation of the Confidence Interval*
 
If we knew the true proportion of GC students who believe in love at first sight, it would likely fall between 0.254958 and 0.488976.
 
Let's put this another way.  If we computed a large number of these 95% confidence intervals to estimate the population proportion, we would expect that about 95% of the intervals would contain the true population proportion and about 5% would not.  You can investigate this idea further with the following app.
 

    require(manipulate)
    CIProp()

 
As you use this app, consider the following question:
 
* Leaving the value of $p$ and confidence level the same, what happens when you increase the number of trials?
* Leaving the value of $p$ and the number of trials the same, what happens when you increase the confidence level?  
 
**Step Four:**  *Write a Conclusion.*
 
It is likely that the true proportion of GC students that believe in love at first sight is between 0.254958 and 0.488976.  We are reasonably sure that the percentage of GC students that believe in love at first sight is somewhere in the range (25.4958%,  48.8976%).
 
 
### Under the Hood
 
 
#### How the Test Works
 
The concept of a confidence interval is the same with proportions as it was with means.  The construction is similar, as well.  We won't bore you with the details again, but we should point out a couple of things about our test.
 
The `binom.testGC` finds the multiplier for construction of the confidence interval from the **binomial distribution**.  When the sample size, $n$, is large enough, we know that the binomial distribution can be well approximated using the normal curve.  If we did not have access to R and our sample size was large enough, we could compute an approximate 95% confidence interval using a multiplier from the normal curve. It would look like
 
$$\bigg(\hat{p} \pm z\cdot \sqrt{n\cdot \hat{p}\cdot (1-\hat{p})}\bigg),$$ 
 
where $z$ would be found using the normal curve.
 
 
However, this is not the calculation that R's `binom.testGC` does!  The multiplier for the confidence interval output from `binom.testGC` is found using the binomial distribution.  This is nice because it does not rely on having large sample sizes so that we have a good approximation to the normal curve.  In other words, we don't have the sample size restriction when we use `binom.testGC`.  When you use `binom.testGC`, you do not need to worry about Condition 1 of the safety check.
 
There is a function, ``prop.testGC``, that computes this confidence interval based on the normal approximation to the binomial distribution.  You will see this function again in Chapters 10, so we will mention it here so you are not alarmed when the confidence interval from ``prop.testGC`` is different than the confidence interval in ``binom.testGC``.
 

    prop.testGC(~love_first,data=m111survey,success="yes")

    ## 
    ## 
    ## Inferential Procedures for a Single Proportion p:
    ## 	Variable under study is love_first 
    ## 	Continuity Correction Applied to Test Statistic
    ## 
    ## 
    ## Descriptive Results:
    ## 
    ##  yes  n estimated.prop
    ##   26 71         0.3662
    ## 
    ## 
    ## Inferential Results:
    ## 
    ## Estimate of p:	 0.3662 
    ## SE(p.hat):	 0.05717 
    ## 
    ## 95% Confidence Interval for p:
    ## 
    ##           lower.bound         upper.bound          
    ##           0.254136            0.478258

 
 
Notice that this interval is different than the one computed by ``binom.testGC``. The ``prop.testGC`` function constructs the confidence interval using the normal approximation which is only good if the sample size is “big enough”. For this reason, we suggest that you stick to ``binom.testGC`` when you are looking for a confidence interval for one proportion.
 
We will not go into any more detail about this now. The important thing is knowing how to interpret the confidence interval.
 
 
#### Values in the Confidence Interval
 
As you compute more confidence intervals for one population proportion, you will notice that you will never see values less than 0 or greater than 1 included in the interval.  This is because a proportion is always a number between 0 and 1.  Always keep in mind that a confidence interval reports the most believable values for a parameter, so the interval *should* only include legitimate values for that parameter.  
 
### Additional Example
 
  >**Research Question**:  In a simple random sample of 1000 American adults, a researcher reported that 59% of the people surveyed said that they believe the world will come to an end.  What is the proportion of all American adults that believe the world will come to an end?
 
**Step One:**  *Definition of Parameter(s)*
 
  >Let $p=$ the proportion of all American adults that believe the world will come to an end.
 
**Step Two:** *Safety Check and Calculation of the Confidence Interval*
 
Since we plan to use `binom.testGC`, we do not need to worry about the sample size since this test calculates the confidence interval from the binomial distribution.  Thus, the only condition we need to verify for the safety check is Condition 2.
 
**Condition 2:** **The sample is like a simple random sample from the population, at least in regard to the variables of interest.**
For this problem, we are told that the sample was a SRS, so let's proceed with the calculation of the confidence interval.  
 
We first need to find the number of successes.  Let's define "success" as believing that the world will come to an end.  Out of the 1000 people surveyed, 59% said they believe that the world will come to an end.  This means that the number of successes is 590 because $\dfrac{590}{1000}=0.59$.
 

    binom.testGC(x=590, n=1000)

    ## 
    ## Exact Binomial Procedures for a Single Proportion p:
    ## 	Results based on Summary Data
    ## 
    ## 
    ## Descriptive Results:  590 successes in 1000 trials
    ## 
    ## Inferential Results:
    ## 
    ## Estimate of p:	 0.59 
    ## SE(p.hat):	 0.01555 
    ## 
    ## 95% Confidence Interval for p:
    ## 
    ##           lower.bound         upper.bound          
    ##           0.558788            0.620680

 
Our 95% confidence interval for the population proportion is (0.558788, 0.62068).
 
**Step Three:**  *Interpretation of the Confidence Interval*
 
We are 95% confident that if the true proportion of American adults who believe the world is going to end was known, it would fall between 0.5588 and 0.6207.
 
**Step Four:**  *Write a Conclusion*
 
We are reasonably sure that the percentage of American adults who believe the world is going to end is in the range ( 55.8788%,  62.068%).
 
 
## Difference of Two Population Proportions, $p_1-p_2$
 
 
  >**Research Question**: In the GC population, are females more likely than males to believe in extra-terrestrial life?
  
We will use ``m111survey`` to answer this question.
 
### The Four Steps
 
**Step One:**  *Definition of Parameter(s)*
 
We are dealing with two independent populations - the population of all GC females and the population of all GC males.  We are interested in computing the proportion that believe in extra-terrestrial life for each of these populations and then finding the difference.  Thus, the parameter is the difference of proportions, $p_1-p_2$.
 
Let $p_1=$ proportion of all GC females that believe in extra-terrestrial life.
 
Let $p_2=$ proportion of all GC males that believe in extra-terrestrial life.
 
For both populations, a "success" is believing in extra-terrestrial life.
 
**Step Two:**  *Safety Check and Calculation of the Confidence Interval*
 
We will use the function ``prop.testGC`` to compute the confidence interval for the difference between two population proportions.  Since this function relies on the normal approximation to the binomial distribution, we will need to verify both conditions of the safety check.
 
**Condition 1:** **The sample size is large enough if $n\cdot \hat{p_1}\geq 10$,  $n\cdot (1-\hat{p_1})\geq 10$, $n\cdot \hat{p_2}\geq 10$ and $n\cdot (1-\hat{p_2})\geq 10$.**
 
Since a success is believing in extra-terrestrial life, we can verify that we have at least 10 successes and at least 10 failures for each of the samples.
 

    ##         extra_life
    ## sex      no yes
    ##   female 30  10
    ##   male   11  20

 
For the females, ther are 10 successes and 30 failures.  For the males, there are 20 successes and 11 failures.  Our sample size is big enough that we can use the normal approximation to the binomial, i.e. we can use the ``prop.testGC`` function to compute the confidence interval.
 
**Condition 2:** **The sample is like a simple random sample from the population, at least in regard to the variables of interest.**  
 
We've talked about using the ``m111survey`` data as a sample of the population of all GC students before.  We need to be sure that one's belief about extra-terrestrial life is independent of their being enrolled in MAT 111.  If these two things were related, this would introduce bias into our study.  For example, if there was some connection between believing in extra-terrestrial life and needing to take MAT 111, then our sample would not be representative of the entire population of GC students.  
 
Since it seems reasonable to believe that these two things are not related, we can think of our MAT 111 survey data to be like a simple random sample.  
 
 

    prop.testGC(~sex+extra_life,data=m111survey,success="yes")

    ## 
    ## 
    ## Inferential Procedures for the Difference of Two Proportions p1-p2:
    ## 	 extra_life grouped by sex 
    ## 
    ## 
    ## Descriptive Results:
    ## 
    ##        yes  n estimated.prop
    ## female  10 40         0.2500
    ## male    20 31         0.6452
    ## 
    ## 
    ## Inferential Results:
    ## 
    ## Estimate of p1-p2:	 -0.3952 
    ## SE(p1.hat - p2.hat):	 0.1099 
    ## 
    ## 95% Confidence Interval for p1-p2:
    ## 
    ##           lower.bound         upper.bound          
    ##           -0.610510           -0.179812

     

 
The 95% confidence interval for the difference in two population proportions is (-0.6105, -0.1798).
 
**Step Three:**  *Interpretation of the Confidence Interval*
 
We are 95% confident that if the true difference in proportions of GC females and GC males that believe in extra-terrestrial life were known, it would be included in the interval (-0.6105,-0.1798). 
 
Notice that all of the values in this interval are negative.  This means that we are 95% confident that the difference in population proportions, $p_1-p_2$, is negative.  This difference will be negative if $p_2>p_1$.  This means that we are pretty confident, based on the data we have collected, that the population proportion of GC males that believe in extra-terrestrial life is GREATER than the proportion of GC females that believe in extra-terrestrial life.
 
**Step Four:**  *Write a Conclusion.*
 
We are reasonably sure that the proportion of GC males that believe in extra-terrestrial life is greater than the proportion of GC females that believe in extra -terrestrial life.  Moreover, it is likely that about 0% to 17.9812%  more males believe in extra-terrestrial life than females. 
 
### Under the Hood
 
In a confidence interval for one population proportion, we said that you should only get values between 0 and 1.  Do not be alarmed that you may get negative values in a confidence interval for the **difference** in two population proportions.  Always keep in mind what parameter you are estimating and what values are legitimate for that parameter!
 
### Additional Example
 
  >**Research Question**: A study was done to determine whether there is a relationship between snoring and the risk of heart disease.  A simple random sample selected a total of 2484 American adults.  Among 1105 snorers in the study, 85 had heart disease, while only 24 of the non-snorers had heart disease.  In this population, are snorers more likely than non-snorers to have heart disease?
 
**Step One:**  *Definition of Parameter(s)*
 
  >Let $p_1=$ population proportion of snorers that have heart disease.
 
  >Let $p_2=$ population proportion of non-snorers that have heart disease.
 
We are interested in estimating $p_1-p_2$.
 
**Step Two:**  *Safety Check and Calculation of Confidence Interval*
 
Since we are dealing with the difference of proportions, we will have to use the `prop.testGC`, so both conditions of the safety check need to hold.
 
**Condition 1:**  **The sample size is large enough if we have at least 10 successes from the sample of snorers,  at least 10 failures from the sample of snorers, at least 10 successes from the sample of non-snorers, and at least 10 failures from the sample of non-snorers.**
 
For the sample of 1105 snorers, there are 85 successes (snorers with heart disease) and $1105-85=1020$ failures (snoreres without heart disease).
 
For the sample of 1379 non-snorers, there are 24 successes (non-snorers with heart disease) and $1379-24=1355$ failures (non-snorers without heart disease).
 
**Condition 2:**  **The sample is like a simple random sample from the population, at least in regard to the variables of interest.**
We can assume that since the study participants were selected via a simple random sample, they constitute a representative sample of the population.
 
Let's compute a 99% confidence interval.
 


 

    prop.testGC(x=c(85,24), n=c(1105,1379), conf.level=0.99)

    ## 
    ## 
    ## Inferential Procedures for the Difference of Two Proportions p1-p2:
    ## 	Results taken from summary data.
    ## 
    ## 
    ## Descriptive Results:
    ## 
    ##         successes    n estimated.prop
    ## Group 1        85 1105        0.07692
    ## Group 2        24 1379        0.01740
    ## 
    ## 
    ## Inferential Results:
    ## 
    ## Estimate of p1-p2:	 0.05952 
    ## SE(p1.hat - p2.hat):	 0.008756 
    ## 
    ## 99% Confidence Interval for p1-p2:
    ## 
    ##           lower.bound         upper.bound          
    ##           0.036966            0.082072

 
The 99% confidence interval for the difference in the two population proportions is (0.037, 0.0821).
 
**Step Three:**  *Interpretation of the Confidence Interval*
 
We are 95% confident that if the true difference in proportions of American adult snorers and non-snorers that have heart disease  were known, it would be included in the interval (0.037, 0.0821). 
 
Notice that all of the values in this interval are positive.  This means that we are 99% confident that the difference in population proportions, $p_1-p_2$, is positive.  This difference will be positive if $p_1>p_2$, which means that the population proportion of snorers with heart disease is greater than the population proportion of non-snorers with heart disease. 
 
**Step Four:**  *Write a Conclusion.*
 
We are reasonably sure that the proportion of American adult snorers with heart disease is greater than the proportion of non-snorers with heart disease.  Moreover, it is likely that about 3.6966% to 8.2072% more snorers have heart disease than non-snorers.
 
 
 
## Thoughts on R
 
 
### New R Functions
 
Know how to use this functions:
 
* `t.testGC` 
* `binom.testGC`
* `prop.testGC`
 
 
 
 
 
