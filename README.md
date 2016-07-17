# E-Mail Spam Filtering


## Introduction

This repository contains our final project for the
[Developing Data Products](https://www.coursera.org/learn/data-products/)
online course, a part of 
[Data Science Specialization](https://www.coursera.org/specializations/jhu-data-science)
on Coursera.

The task was to develop an interactive web application using 
[Shiny](http://shiny.rstudio.com/), as well as an accompanying presentation using
[Slidify](http://slidify.org/).
The web application must support some sort of user input and perform an
arbitrary analysis interactively based on the input. The presentation must 
be limited to five slides and contain embedded R code.


## Solution

We chose to build a prediction model for classifying e-mail messages as spam or ham.
Full data analysis report that serves as a theoretical foundation for the web application is available at 
[http://www.milanfort.com/spam-filtering/](http://www.milanfort.com/spam-filtering/).
The web application is deployed through the [shinyapps.io](http://www.shinyapps.io/) PaaS and is available at
[http://www.shinyapps.io/app](http://www.shinyapps.io/app).
The accompaning presentation is available at 
[http://www.milanfort.com/spam-filtering/slides/](http://www.milanfort.com/spam-filtering/slides/).


## Repository Structure

This repository has the following structure:

* Directory _report_ contains the source code of the data analysis report
* Directory _app_ contains the source code of the Shiny web application
* Directory _slides_ contains the source code of the Slidify presentation
* Directory _data_ contains the email dataset from 
[OpenIntro Statistics Extras](https://www.openintro.org/stat/extras.php) website
