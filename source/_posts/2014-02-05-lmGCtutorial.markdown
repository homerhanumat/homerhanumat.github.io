---
layout: post
title: "lmGC() Tutorial"
date: 2014-02-15 20:00:00
comments: true
categories: [Student-Focused Tutorials]
pulished:  false
status: publish
---
 
* will be replaced by TOC
{:toc}
 
## Preliminaries
 
The `lmGC()` is a starter-tool for simple linear regression, when you are studying the relationship between two numerical variables, one of which you consider to be an explanatory or predictor variable and the other of which you think of as the response.  It's only a starter-tool:  by the end of the course, or in later statistics courses, you will move on to R's function `lm()`, which allows you to work with more than one explanatory variable and which provides additional useful information in its output.  Also, in `lm()` the explanatory variable(s) can even be factors!
 
The function (and some of the data) that we will use comes from the `tigerstats` package, so make sure that it is loaded:
 

    require(tigerstats)

 
**Note:**  If you are not working with the R Studio server hosted by Georgetown College, then you will need install `tigerstats` on your own machine.  You can get the current version from [Github](http://github.com) by first installing the `devtools` package from the CRAN repository, and then running the following commands in a fresh R session:
 

    require(devtools)
    install_github(repo = "homerhanumat/tigerstats")

 
In this tutorial we will work with a couple of data sets:  `mtcars` from the `data` package that comes with the basic R installation, and `fuel` from the `tigerstats` package, so make sure you become familiar with them.  The following commands may be helpful in this regard:
 

    data(mtcars)
    View(mtcars)
    help(mtcars)

 
For `fuel`:
 

    data(fuel)
    View(fuel)
    help(fuel)

 
 
## Formula-Data Input
 
Like many R functions, `lmGC()` accepts formula-data input.  The general command looks like:
 

    lmGC(response ~ explanatory, data = DataFrame)

 
 
If you are interested in studying the relationship between the fuel efficiency of a car (**mpg** in the `mtcars` data frame, measured in miles per gallon) and its weight (**wt** in `mtcars`, measure din thousands of pounds), then you  can run:
 

    lmGC(mpg ~ wt, data = mtcars)

    ## 
    ## 			Simple Linear Regression
    ## 
    ## Correlation coefficient r =  -0.8677 
    ## 
    ## Equation of Regression Line:
    ## 
    ## 	 mpg = 37.29 + -5.345 * wt 
    ## 
    ## Residual Standard Error:	s   = 3.046 
    ## R^2 (unadjusted):		R^2 = 0.7528

 
The output to the console is rather minimal.  You get:
 
* the correlation coefficient $r$.  We need to look at a scatter plot to be really sure about it (for plots, see below), but at this point the value $r = -0.87$ indicates a fairly strong negative linear relationship between fuel efficiency and weight.
* the equation of the regression line.  From the slope of -5.34, we see that for every thousand pound increase in the weight of a car, we predict a 5.34 mpg decrease in the fuel efficiency.
* the residual standard error $s$.  As a rough rule of thumb, we figure that when we use the regression equation to predict the fuel efficiency of a car from its weight, that prediction is liable to be off by about $s$ miles per gallon, or so.
* the unadjusted $R^2$.  We see here that about 75% of the variation in the fuel efficiency of the cars in the data set is accounted for by the variation in their weights.  since $R^2$ is fairly high, it seems that weight is a fairly decent predictor of fuel efficiency.
 
## Prediction
 
When the value of the explanatory variable for an individual is known and you wish to predict the value of the response variable for that individual, you can use the `predict()` function.  Its arguments are the linear model that is created by `lmGC()`, and the value `x` of the explanatory variable.
 
If you think that you might want to use `predict()`, you may first want to store the model in a variable, for example:
 

    WeightEff <- lmGC(mpg ~ wt, data = mtcars)

 
Then if you want to predict the fuel efficiency of a car that weights 3000 pounds, run this command:
 

    predict(WeightEff, x = 3)

    ## [1] 21.25

 
We predict that a 3000 pound car (from the time of the Motor Trend study that produced this data) would have a fuel efficiency of 21.25 mpg, give or take about 3.046 mpg or so.  (Note how we used $s$ as a rough give-or-take figure.)
 
## Plotting
 
But we are getting ahead of ourselves!  In order to use linear models at all, we need to make sure that our data really do show a linear relationship.  The single best way to check this is to look at a scatterplot, so `lmGC()` comes equipped with a option to produce one:  just set the argument `graph` to `TRUE`, as follows:
 

    lmGC(mpg ~ wt, data = mtcars, graph = TRUE)

    ## 
    ## 			Simple Linear Regression
    ## 
    ## Correlation coefficient r =  -0.8677 
    ## 
    ## Equation of Regression Line:
    ## 
    ## 	 mpg = 37.29 + -5.345 * wt 
    ## 
    ## Residual Standard Error:	s   = 3.046 
    ## R^2 (unadjusted):		R^2 = 0.7528

![Speed and fuel efficiency in the Motor Trends study](/images/figure/mtcarsscatter.png) 

 
The scatterplot includes the regression line. Indeed, the cloud of point seems to follow a line fairly well.  The relationship may be thought of as linear, so using `lmGC()` for tasks like prediction does make sense, for this data.
 
You can also perform some simple diagnostics, by setting the argument `diag` to `TRUE`:
 

    lmGC(mpg ~ wt, data = mtcars, diag = TRUE)

    ## 
    ## 			Simple Linear Regression
    ## 
    ## Correlation coefficient r =  -0.8677 
    ## 
    ## Equation of Regression Line:
    ## 
    ## 	 mpg = 37.29 + -5.345 * wt 
    ## 
    ## Residual Standard Error:	s   = 3.046 
    ## R^2 (unadjusted):		R^2 = 0.7528

![Diagnostic plots for the Motor Trends study](/images/figure/mtcarsdiag.png) 

 
You get two graphs:
 
* a density plot of the residuals.  If the distribution of the residuals is roughly bell-shaped, then you can actually employ a ``regression'' version of the 68-95 Rule:  when you make a prediction using the regression line, there is a about a 68% chance that your predcition will be wtthin one $s$ of the actual $y$-value, and about a 95% chance that ti will be within $2s$ of the actual $y$-value.  *Neat!*
* A plot of the residuals vs, the ``fitted`` $y$-values (the $y$-coordinates of the points on the original scatterplot).  If the points exhibit a linear relationship with about the same amount of scatter all the way along the regression line, then this plot should look like a random cloud of points.  In this case, it confirms that our linear model is appropriate to the data.
 
On the other hand, consider `fuel` data frame, which shows the results of a study where a British Ford Escort was driven at various speed along a standard course, and the fuel efficiency (in kilometers traveled per liter of fuel consumed) was recorded at each speed.  Let's try a linear model with **speed** as explanatory and **efficiency** as the response, with some diagnostic plots attached:
 

    lmGC(efficiency ~ speed, data = fuel, diag = TRUE)

    ## 
    ## 			Simple Linear Regression
    ## 
    ## Correlation coefficient r =  -0.1716 
    ## 
    ## Equation of Regression Line:
    ## 
    ## 	 efficiency = 11.06 + -0.0147 * speed 
    ## 
    ## Residual Standard Error:	s   = 3.905 
    ## R^2 (unadjusted):		R^2 = 0.0295

![Diagnostic Plots for British Ford Escort Study](/images/figure/fordescortsdiag.png) 

 
The residuals have a roughly-bell-shaped distribution, but the residual plot is clearly patterned.  Something is amiss!  Let's look at a scatterplot of the data:
 

    xyplot(efficiency~speed,data=fuel,
           xlab="speed (kilometers/hour",
           ylab="fuel effiency (liters/100km",
           pch=19,col="blue",type=c("p","r"),
           main="Speed and Fuel Efficiency\nfor a British Ford Escort")

![Speed and Fuel Efficiency for a British Ford Escort](/images/figure/fordescortscatter.png) 

 
The relationship is strongly curvilinear:  it makes no sense to use the regression line (shown in the plot above) to study the relationship between these two variables!
