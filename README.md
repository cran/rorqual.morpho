
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rorqual.morpho

<!-- badges: start -->

<!-- badges: end -->

## Overview

rorqual.morpho is an implementation of the allometric equations in
Kahane-Rapport and Goldbogen (2018), allowing users to predict
morphological parameters of rorquals from body length measurements.

## Installation

You can install rorqual.morpho from
[GitHub](https://github.com/FlukeAndFeather/rorqual.morpho) with:

``` r
# install.packages("devtools")
devtools::install_github("FlukeAndFeather/rorqual.morpho")
```

Note: uncomment and run the first line if you don’t have devtools
installed.

## Usage

You can use the rorq\_\*() family of functions to predict morphological
parameters. Note: rorq\_\*() functions will return *Balaenoptera
acutorostrata* (species code ba) parameters for *B. bonaerensis*
(species code bb).

``` r
library(rorqual.morpho)
# Predict the body mass and engulfment capacities of three blue whales of different sizes.
rorq_mass(c("bw", "bw", "bw"), c(18, 20, 22))
#> [1] 31530.56 44803.78 61566.25
rorq_engulf(c("bw", "bw", "bw"), c(18, 20, 22))
#> [1] 37.90082 55.77590 79.11127

# Use dplyr to predict fluke and flipper lengths for a tibble of humpback and minke whales
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following object is masked from 'package:testthat':
#> 
#>     matches
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
tribble(
  ~ species, ~ length,
  "mn",      8,
  "mn",      11.5,
  "mn",      15,
  "ba",      4.5,
  "ba",      6.75,
  "bb",      9
) %>% 
  mutate(fluke = rorq_fluke(species, length),
         flipper = rorq_flipper(species, length))
#> # A tibble: 6 x 4
#>   species length fluke flipper
#>   <chr>    <dbl> <dbl>   <dbl>
#> 1 mn        8     2.48   2.51 
#> 2 mn       11.5   3.73   3.54 
#> 3 mn       15     5.02   4.56 
#> 4 ba        4.5   1.20   0.537
#> 5 ba        6.75  1.88   0.889
#> 6 bb        9     2.59   1.27
```
