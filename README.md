
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cov20

<!-- badges: start -->

[![R build
status](https://github.com/etc5523-2020/r-package-assessment-jthoma48/workflows/R-CMD-check/badge.svg)](https://github.com/etc5523-2020/r-package-assessment-jthoma48/actions)
<!-- badges: end -->

The goal of *cov20* is to provide the user the opportunity to launch an
interactive shiny application and visualize the statistics related to
coronavirus from around the world. The package also contains a function
that will help the user launch the application. In order to launch the
application, 3 datasets have been included in this package.

## Installation

<!-- You can install the released version of cov20 from [CRAN](https://CRAN.R-project.org) with: -->

<!-- ``` r -->

<!-- install.packages("cov20") -->

<!-- ``` -->

A development version of the package can be installed from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("etc5523-2020/r-package-assessment-jthoma48")
```

## Example

This is a basic example which shows you how to launch the app:

``` r
library(cov20)
launch_app()
```

This is a basic example of how you can access a dataset and visualize it
however you want:

``` r
library(cov20)
data2
```

You can access these datasets: data2, data3 and data5

## Functions

Besides the `launch_app()` function, there are 2 more functions in this
package:

1.  `selectui01()`: creates a drop-down list and displays options for
    countries and states to select from in the application

<!-- end list -->

``` r
selectui01(inputId)
```

2.  `leafserv()`: generates a map of your desired country in the
    application

<!-- end list -->

``` r
leafserv(df$Long, df$Lat, df$State)
```
