R & RStudio Overview
========================================================
author: Jamie Bono
date: July 11, 2018
autosize: true

Agenda
========================================================

* Check that everyone has R, RStudio, and Git installed
* Setting up RStudio Integrated Development Environment ([IDE](https://en.wikipedia.org/wiki/Integrated_development_environment))
* Navigating the RStudio IDE
* Installing R packages

**Break**

* Working with data
  * The "Tidy Data Workflow"
  * Importing data
  * Exporting data
  * Tranforming data
  * Exploratory data analysis
  * Data viusalization

Topics We Will Not be Covering
========================================================

* This workshop focuses on teaching the fundamentals of R and does not teach statistical analysis.

* Anything other than "rectangular" data structures

* Python, SQL, Excel, SAS, SPSS, Stata (although we will talk about them)

R and RStudio are not the same thing
========================================================

* "R is a language and environment for statistical computing and graphics." - [R Project for Statistical Computing](https://www.r-project.org/about.html) 

* "RStudio is an integrated development environment (IDE) for R. It includes a console, syntax-highlighting editor that supports direct code execution, as well as tools for plotting, history, debugging and workspace management." - [RStudio](https://www.rstudio.com/products/rstudio/)

[demo]

Packages
=========================================================


```r
# install.packages("tidyverse")     # Metalibrary of tools for tidy data munging automatically loads:
#  install.packages("dplyr")         # Tools for data manipulation
#  install.packages("stringr")       # Tools for working with character variables
#  install.packages("purrr")         # Tools for functional programming
#  install.packages("tibble")        # Tools for managing "tibble" objects
#  install.packages("tidyr")         # Tools for reshaping data
#  install.packages("ggplot2")       # Grammar of Graphics plotting
#  install.packages("forcats")       # Tools for working with factors
```

Tidyverse
=========================================================
We call tidyverse a "metapackage" because when you load it into memory with the `library(tidyverse)` command, it loads all of the "tidyverse" packages, listed above.


```r
library(tidyverse)
```

```
── Attaching packages ──────── tidyverse 1.2.1 ──
```

```
✔ ggplot2 2.2.1     ✔ purrr   0.2.5
✔ tibble  1.4.2     ✔ dplyr   0.7.6
✔ tidyr   0.8.1     ✔ stringr 1.3.1
✔ readr   1.1.1     ✔ forcats 0.3.0
```

```
── Conflicts ─────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
```

Set working directory (if necessary)
=========================================================


```r
# getwd()
# setwd("R")
# getwd()
```

Load required packages
=========================================================


```r
library(tidyverse)  # Functions for data manipulation
library(gapminder)  # Gapminder data
```

Read data into global environment
=========================================================


```r
data("gapminder")
# View(gapminder)
```

Write data to csv file
=========================================================


```r
write_csv(gapminder, "data/gapminder.csv")
```

Read saved csv file for comparison
=========================================================

```r
gapminder_from_csv <- read_csv("data/gapminder.csv")
```

Examine the data structures - `str`
=========================================================

```r
str(gapminder)
```

```
Classes 'tbl_df', 'tbl' and 'data.frame':	1704 obs. of  6 variables:
 $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
 $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
 $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
 $ pop      : int  8425333 9240934 10267083 11537966 13079460 14880372 12881816 13867957 16317921 22227415 ...
 $ gdpPercap: num  779 821 853 836 740 ...
```

```r
str(gapminder_from_csv)
```

```
Classes 'tbl_df', 'tbl' and 'data.frame':	1704 obs. of  6 variables:
 $ country  : chr  "Afghanistan" "Afghanistan" "Afghanistan" "Afghanistan" ...
 $ continent: chr  "Asia" "Asia" "Asia" "Asia" ...
 $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
 $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
 $ pop      : int  8425333 9240934 10267083 11537966 13079460 14880372 12881816 13867957 16317921 22227415 ...
 $ gdpPercap: num  779 821 853 836 740 ...
 - attr(*, "spec")=List of 2
  ..$ cols   :List of 6
  .. ..$ country  : list()
  .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
  .. ..$ continent: list()
  .. .. ..- attr(*, "class")= chr  "collector_character" "collector"
  .. ..$ year     : list()
  .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
  .. ..$ lifeExp  : list()
  .. .. ..- attr(*, "class")= chr  "collector_double" "collector"
  .. ..$ pop      : list()
  .. .. ..- attr(*, "class")= chr  "collector_integer" "collector"
  .. ..$ gdpPercap: list()
  .. .. ..- attr(*, "class")= chr  "collector_double" "collector"
  ..$ default: list()
  .. ..- attr(*, "class")= chr  "collector_guess" "collector"
  ..- attr(*, "class")= chr "col_spec"
```

Examine the data structures - `summary`
=========================================================

```r
summary(gapminder)
```

```
        country        continent        year         lifeExp     
 Afghanistan:  12   Africa  :624   Min.   :1952   Min.   :23.60  
 Albania    :  12   Americas:300   1st Qu.:1966   1st Qu.:48.20  
 Algeria    :  12   Asia    :396   Median :1980   Median :60.71  
 Angola     :  12   Europe  :360   Mean   :1980   Mean   :59.47  
 Argentina  :  12   Oceania : 24   3rd Qu.:1993   3rd Qu.:70.85  
 Australia  :  12                  Max.   :2007   Max.   :82.60  
 (Other)    :1632                                                
      pop              gdpPercap       
 Min.   :6.001e+04   Min.   :   241.2  
 1st Qu.:2.794e+06   1st Qu.:  1202.1  
 Median :7.024e+06   Median :  3531.8  
 Mean   :2.960e+07   Mean   :  7215.3  
 3rd Qu.:1.959e+07   3rd Qu.:  9325.5  
 Max.   :1.319e+09   Max.   :113523.1  
                                       
```

```r
summary(gapminder_from_csv)
```

```
   country           continent              year         lifeExp     
 Length:1704        Length:1704        Min.   :1952   Min.   :23.60  
 Class :character   Class :character   1st Qu.:1966   1st Qu.:48.20  
 Mode  :character   Mode  :character   Median :1980   Median :60.71  
                                       Mean   :1980   Mean   :59.47  
                                       3rd Qu.:1993   3rd Qu.:70.85  
                                       Max.   :2007   Max.   :82.60  
      pop              gdpPercap       
 Min.   :6.001e+04   Min.   :   241.2  
 1st Qu.:2.794e+06   1st Qu.:  1202.1  
 Median :7.024e+06   Median :  3531.8  
 Mean   :2.960e+07   Mean   :  7215.3  
 3rd Qu.:1.959e+07   3rd Qu.:  9325.5  
 Max.   :1.319e+09   Max.   :113523.1  
```

Examine the data structures - `dplyr::glimpse`
=========================================================

```r
glimpse(gapminder)
```

```
Observations: 1,704
Variables: 6
$ country   <fct> Afghanistan, Afghanistan, Afghanistan, Afghanistan, ...
$ continent <fct> Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia...
$ year      <int> 1952, 1957, 1962, 1967, 1972, 1977, 1982, 1987, 1992...
$ lifeExp   <dbl> 28.801, 30.332, 31.997, 34.020, 36.088, 38.438, 39.8...
$ pop       <int> 8425333, 9240934, 10267083, 11537966, 13079460, 1488...
$ gdpPercap <dbl> 779.4453, 820.8530, 853.1007, 836.1971, 739.9811, 78...
```

```r
glimpse(gapminder_from_csv)
```

```
Observations: 1,704
Variables: 6
$ country   <chr> "Afghanistan", "Afghanistan", "Afghanistan", "Afghan...
$ continent <chr> "Asia", "Asia", "Asia", "Asia", "Asia", "Asia", "Asi...
$ year      <int> 1952, 1957, 1962, 1967, 1972, 1977, 1982, 1987, 1992...
$ lifeExp   <dbl> 28.801, 30.332, 31.997, 34.020, 36.088, 38.438, 39.8...
$ pop       <int> 8425333, 9240934, 10267083, 11537966, 13079460, 1488...
$ gdpPercap <dbl> 779.4453, 820.8530, 853.1007, 836.1971, 739.9811, 78...
```
