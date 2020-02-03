Lab 04
================
Robert Han
02/02/2020

## Loading Libraries

Use the following syntax to load any libraries that you need. This code
will prevent errors that will interfere with knitting of the Rmd file.
Also note that the `include=FALSE` option will prevent this code chunk
from appearing in the markdown file.

First we will load the “conflicted” library. This will help us identify
any problems with packages that we use.

We will then load the entire tidyverse library, which includes *dplyr*,
*ggplot2*, *readr*, and other packages.

## Objectives for Lab 4

1.  Introduction to *dplyr* grammar and functions
2.  Exploratory data analysis using *dplyr*

## Exploratory Data Analysis with R

This lab is adapted from Roger Peng’s *Exploratory Data Analysis with
R*, Chapter 4. <https://leanpub.com/exdata/read_full>

## Verbs in dplyr

One of the main parts of the *dplyr* data grammar is the use of verbs to
manipulate data frames. There are six main verbs in *dplyr*:

  - `filter()` to select cases based on their values.
  - `arrange()` to reorder the cases.
  - `select()` and `rename()` to select variables based on their names.
  - `mutate()` and `transmute()` to add new variables that are functions
    of existing variables.
  - `summarise()` to condense multiple values to a single value.
  - `sample_n()` and `sample_frac()` to take random samples.

The preferred syntax of *dplyr* will use a data frame first, followed by
a verb. The output will be another (altered) data frame. However, these
verbs can also be used like traditional R functions where you have the
verb(subject) syntax. We will use this traditional syntax to learn what
these functions do, and then introduce the preferred (pipeline) syntax.

## Loading data

For this exercise we will be using data from Prof. Reeder’s fieldwork in
Uganda. Epauletted fruit bats were collected at two different times of
the year for this study and a variety of health metrics were measured.

Note that this data should not be shared outside this class without
permission.

``` r
BatData <- read_csv("UgandaBatsFilteredMetrics.csv", 
    col_types = cols(`Collection date` = col_date(format = "%m/%d/%y")))
# The col_date format was used to make sure that the Collection date was interpretted properly.
# See ?as.Date for more information and examples.

# Below is a very handy way to eliminate those annoying spaces in the column names!
names(BatData) <- make.names(names(BatData))
```

After you load the data, check that it has loaded correctly by checking
the structure of the data frame. The `str()` function is very useful for
getting to know the structure of your
    data.

``` r
str(BatData)
```

    ## Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame': 103 obs. of  12 variables:
    ##  $ Field.number       : chr  "DMR976" "DMR957" "DMR910" "DMR955" ...
    ##  $ Collection.date    : Date, format: "2017-03-11" "2017-03-10" ...
    ##  $ Season             : chr  "DRY" "DRY" "DRY" "DRY" ...
    ##  $ Sex                : chr  "Female" "Female" "Female" "Female" ...
    ##  $ Class              : chr  "FEMALE NONPREGNANT ADULT" "FEMALE NONPREGNANT ADULT" "FEMALE NONPREGNANT ADULT" "FEMALE NONPREGNANT ADULT" ...
    ##  $ Elevation          : num  1027 971 1030 971 1027 ...
    ##  $ Habitat.description: chr  "mixed rural agricultural/grasslands area, multiple tukals" "mixed rural agricultural/grasslands area, multiple tukals" "mixed rural agricultural/grasslands area" "mixed rural agricultural/grasslands area, multiple tukals" ...
    ##  $ Total.Length       : num  130 133 125 133 128 124 134 125 NA 136 ...
    ##  $ Hind.Foot          : num  18 19 16 18 18 20 17 18 NA 20 ...
    ##  $ Ear                : num  20 20 22 20 21 21 19 23 NA 19 ...
    ##  $ FA.length          : num  76.3 72.2 74.7 75.7 76 ...
    ##  $ Mass               : num  58 58.5 59.1 62.1 61.5 ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   `Field number` = col_character(),
    ##   ..   `Collection date` = col_date(format = "%m/%d/%y"),
    ##   ..   Season = col_character(),
    ##   ..   Sex = col_character(),
    ##   ..   Class = col_character(),
    ##   ..   Elevation = col_double(),
    ##   ..   `Habitat description` = col_character(),
    ##   ..   `Total Length` = col_double(),
    ##   ..   `Hind Foot` = col_double(),
    ##   ..   Ear = col_double(),
    ##   ..   `FA length` = col_double(),
    ##   ..   Mass = col_double()
    ##   .. )

## select()

The select() function can be used to select **columns** of a data frame
that you want to focus on. Often you’ll have a large data frame
containing “all” of the data, but any given analysis might only use a
subset of variables or observations. The select() function allows you to
get the few columns you might need.

Suppose we wanted to take the first 3 columns only. There are a few ways
to do this. We could for example use numerical indices. But we can also
use the names
directly.

``` r
names(BatData)[1:3]
```

    ## [1] "Field.number"    "Collection.date" "Season"

``` r
BatData.subset <- dplyr::select(BatData, Field.number:Season) #show only field number to season (range of variable names)
BatData1.subset <- dplyr::select(BatData, -(Collection.date:Season)) #show all except collection date to season
head(BatData.subset)
```

    ## # A tibble: 6 x 3
    ##   Field.number Collection.date Season
    ##   <chr>        <date>          <chr> 
    ## 1 DMR976       2017-03-11      DRY   
    ## 2 DMR957       2017-03-10      DRY   
    ## 3 DMR910       2017-03-05      DRY   
    ## 4 DMR955       2017-03-10      DRY   
    ## 5 DMR966       2017-03-11      DRY   
    ## 6 DMR959       2017-03-10      DRY

``` r
head(BatData1.subset)
```

    ## # A tibble: 6 x 10
    ##   Field.number Sex   Class Elevation Habitat.descrip… Total.Length Hind.Foot
    ##   <chr>        <chr> <chr>     <dbl> <chr>                   <dbl>     <dbl>
    ## 1 DMR976       Fema… FEMA…      1027 mixed rural agr…          130        18
    ## 2 DMR957       Fema… FEMA…       971 mixed rural agr…          133        19
    ## 3 DMR910       Fema… FEMA…      1030 mixed rural agr…          125        16
    ## 4 DMR955       Fema… FEMA…       971 mixed rural agr…          133        18
    ## 5 DMR966       Fema… FEMA…      1027 mixed rural agr…          128        18
    ## 6 DMR959       Fema… FEMA…       971 mixed rural agr…          124        20
    ## # … with 3 more variables: Ear <dbl>, FA.length <dbl>, Mass <dbl>

Note that the : normally cannot be used with names or strings, but
inside the select() function you can use it to specify a range of
variable names. You can also omit variables using the select() function
by using the negative sign. With select() you can do `select(BatData,
-(Collection.date:Season))`

If you don’t specify which select function to use and you have more than
one package with a select function, then you will generate an error.
Thanks to the “conflicted” package, that error is informative and tells
you how to fix it. You can see that we specified the package to use by
‘dplyr::select’. \<————————————Specify package to use when multiple
with same name exist

The select() function also allows a special syntax that allows you to
specify variable names based on patterns. So, for example, if you wanted
to keep every variable that ends with a “2”, we could use `subset <-
select(chicago, ends_with("2"))`

Use select() to make a new BatData.subset that only contains the Field
number, Season, Class, Forearm length (FA length), and Mass for each
bat.

``` r
BatData.subset <- dplyr::select(BatData, Field.number:Season)
BatData2.subset <- dplyr::select(BatData, Field.number:Mass, -(Collection.date), -(Sex), -(Elevation:Ear), (FA.length:Mass))
head(BatData2.subset)
```

    ## # A tibble: 6 x 5
    ##   Field.number Season Class                    FA.length  Mass
    ##   <chr>        <chr>  <chr>                        <dbl> <dbl>
    ## 1 DMR976       DRY    FEMALE NONPREGNANT ADULT      76.3  58  
    ## 2 DMR957       DRY    FEMALE NONPREGNANT ADULT      72.2  58.5
    ## 3 DMR910       DRY    FEMALE NONPREGNANT ADULT      74.6  59.1
    ## 4 DMR955       DRY    FEMALE NONPREGNANT ADULT      75.7  62.1
    ## 5 DMR966       DRY    FEMALE NONPREGNANT ADULT      76.0  61.4
    ## 6 DMR959       DRY    FEMALE NONPREGNANT ADULT      76.1  63.3

## filter()

The filter() function is used to extract subsets of **rows** from a data
frame. This function is similar to the existing subset() function in R
but is quite a bit faster.

Suppose we wanted to extract the rows where the Mass of the bat was less
than 55 g, which may indicate that the bat is a juvenile or subadult.

``` r
BatData.filter <- dplyr::filter(BatData, Mass < 55)
str(BatData.filter)
```

    ## Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame': 41 obs. of  12 variables:
    ##  $ Field.number       : chr  "DMR973" "DMR929" "DMR972" "DMR937" ...
    ##  $ Collection.date    : Date, format: "2017-03-11" "2017-03-07" ...
    ##  $ Season             : chr  "DRY" "DRY" "DRY" "DRY" ...
    ##  $ Sex                : chr  "Female" "Female" "Female" "Female" ...
    ##  $ Class              : chr  "FEMALE SUBADULT" "FEMALE SUBADULT" "FEMALE SUBADULT" "FEMALE SUBADULT" ...
    ##  $ Elevation          : num  1027 1027 1027 1030 1027 ...
    ##  $ Habitat.description: chr  "mixed rural agricultural/grasslands area, multiple tukals" "mixed rural agricultural/grasslands area, some tukals" "mixed rural agricultural/grasslands area, multiple tukals" "mixed rural agricultural/grasslands area" ...
    ##  $ Total.Length       : num  114 110 114 114 112 114 120 115 NA 121 ...
    ##  $ Hind.Foot          : num  18 18 18 19 19 18 18 19 NA 18 ...
    ##  $ Ear                : num  21 15 21 21 20 19 22 21 NA 22 ...
    ##  $ FA.length          : num  65.8 68.2 68.3 68.5 68.6 ...
    ##  $ Mass               : num  38.7 45.1 40.4 43.6 43.6 ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   `Field number` = col_character(),
    ##   ..   `Collection date` = col_date(format = "%m/%d/%y"),
    ##   ..   Season = col_character(),
    ##   ..   Sex = col_character(),
    ##   ..   Class = col_character(),
    ##   ..   Elevation = col_double(),
    ##   ..   `Habitat description` = col_character(),
    ##   ..   `Total Length` = col_double(),
    ##   ..   `Hind Foot` = col_double(),
    ##   ..   Ear = col_double(),
    ##   ..   `FA length` = col_double(),
    ##   ..   Mass = col_double()
    ##   .. )

There are only 41 bats in this filtered list. Use summary() to compare
the Masses of this group of bats to those of the entire
    set.

``` r
summary(BatData.filter)
```

    ##  Field.number       Collection.date         Season              Sex           
    ##  Length:41          Min.   :2017-03-06   Length:41          Length:41         
    ##  Class :character   1st Qu.:2017-03-08   Class :character   Class :character  
    ##  Mode  :character   Median :2017-03-11   Mode  :character   Mode  :character  
    ##                     Mean   :2017-05-11                                        
    ##                     3rd Qu.:2017-07-17                                        
    ##                     Max.   :2017-07-20                                        
    ##                                                                               
    ##     Class             Elevation    Habitat.description  Total.Length  
    ##  Length:41          Min.   : 957   Length:41           Min.   :105.0  
    ##  Class :character   1st Qu.:1023   Class :character    1st Qu.:113.8  
    ##  Mode  :character   Median :1027   Mode  :character    Median :115.5  
    ##                     Mean   :1018                       Mean   :116.0  
    ##                     3rd Qu.:1030                       3rd Qu.:119.2  
    ##                     Max.   :1053                       Max.   :127.0  
    ##                                                        NA's   :1      
    ##    Hind.Foot         Ear          FA.length          Mass      
    ##  Min.   :16.0   Min.   :15.00   Min.   :65.00   Min.   :38.72  
    ##  1st Qu.:18.0   1st Qu.:20.00   1st Qu.:67.50   1st Qu.:43.58  
    ##  Median :18.0   Median :20.75   Median :68.70   Median :45.56  
    ##  Mean   :18.4   Mean   :20.40   Mean   :68.96   Mean   :46.03  
    ##  3rd Qu.:19.0   3rd Qu.:21.00   3rd Qu.:70.50   3rd Qu.:48.75  
    ##  Max.   :21.0   Max.   :23.00   Max.   :77.08   Max.   :53.71  
    ##  NA's   :1      NA's   :1

You could also use filter to select based on more complex logical
sequences using the & operator (or other logical operators). Compare the
number of male bats that are under 55 g to the number of female bats
that are under 55 g using the filter()
function.

``` r
BatData.filter.male.U55 <- dplyr::filter(BatData, Mass < 55, Sex == "Male")
BatData.filter.female.U55 <- dplyr::filter(BatData, Mass < 55, Sex == "Female")
summary(BatData.filter.male.U55)
```

    ##  Field.number       Collection.date         Season              Sex           
    ##  Length:21          Min.   :2017-03-06   Length:21          Length:21         
    ##  Class :character   1st Qu.:2017-03-08   Class :character   Class :character  
    ##  Mode  :character   Median :2017-03-10   Mode  :character   Mode  :character  
    ##                     Mean   :2017-05-09                                        
    ##                     3rd Qu.:2017-07-17                                        
    ##                     Max.   :2017-07-19                                        
    ##     Class             Elevation    Habitat.description  Total.Length
    ##  Length:21          Min.   : 957   Length:21           Min.   :109  
    ##  Class :character   1st Qu.: 974   Class :character    1st Qu.:115  
    ##  Mode  :character   Median :1030   Mode  :character    Median :118  
    ##                     Mean   :1017                       Mean   :118  
    ##                     3rd Qu.:1030                       3rd Qu.:122  
    ##                     Max.   :1053                       Max.   :127  
    ##    Hind.Foot          Ear          FA.length          Mass      
    ##  Min.   :16.00   Min.   :19.00   Min.   :65.66   Min.   :40.85  
    ##  1st Qu.:18.00   1st Qu.:20.00   1st Qu.:68.00   1st Qu.:44.91  
    ##  Median :18.00   Median :21.00   Median :68.91   Median :48.18  
    ##  Mean   :18.33   Mean   :20.69   Mean   :69.40   Mean   :47.73  
    ##  3rd Qu.:19.00   3rd Qu.:21.00   3rd Qu.:70.62   3rd Qu.:50.26  
    ##  Max.   :21.00   Max.   :23.00   Max.   :77.08   Max.   :53.71

``` r
summary(BatData.filter.female.U55)
```

    ##  Field.number       Collection.date         Season              Sex           
    ##  Length:20          Min.   :2017-03-06   Length:20          Length:20         
    ##  Class :character   1st Qu.:2017-03-08   Class :character   Class :character  
    ##  Mode  :character   Median :2017-05-12   Mode  :character   Mode  :character  
    ##                     Mean   :2017-05-13                                        
    ##                     3rd Qu.:2017-07-18                                        
    ##                     Max.   :2017-07-20                                        
    ##                                                                               
    ##     Class             Elevation    Habitat.description  Total.Length  
    ##  Length:20          Min.   : 957   Length:20           Min.   :105.0  
    ##  Class :character   1st Qu.:1026   Class :character    1st Qu.:110.0  
    ##  Mode  :character   Median :1027   Mode  :character    Median :114.0  
    ##                     Mean   :1019                       Mean   :113.7  
    ##                     3rd Qu.:1030                       3rd Qu.:115.5  
    ##                     Max.   :1053                       Max.   :121.0  
    ##                                                        NA's   :1      
    ##    Hind.Foot          Ear          FA.length          Mass      
    ##  Min.   :17.00   Min.   :15.00   Min.   :65.00   Min.   :38.72  
    ##  1st Qu.:18.00   1st Qu.:19.00   1st Qu.:67.00   1st Qu.:43.19  
    ##  Median :18.00   Median :20.00   Median :68.54   Median :44.60  
    ##  Mean   :18.47   Mean   :20.08   Mean   :68.50   Mean   :44.24  
    ##  3rd Qu.:19.00   3rd Qu.:21.00   3rd Qu.:69.68   3rd Qu.:45.78  
    ##  Max.   :20.00   Max.   :23.00   Max.   :72.25   Max.   :49.39  
    ##  NA's   :1       NA's   :1

## arrange()

The arrange() function is used to reorder rows of a data frame according
to one of the variables/columns. Reordering rows of a data frame (while
preserving corresponding order of other columns) is normally a pain to
do in R. The arrange() function simplifies the process quite a bit.

Here we can order the rows of the data frame by date, so that the first
row is the earliest (oldest) observation and the last row is the latest
(most recent) observation.

``` r
BatData <- dplyr::arrange(BatData, Collection.date)
head(dplyr::select(BatData, Field.number:Class))
```

    ## # A tibble: 6 x 5
    ##   Field.number Collection.date Season Sex    Class                   
    ##   <chr>        <date>          <chr>  <chr>  <chr>                   
    ## 1 DMR910       2017-03-05      DRY    Female FEMALE NONPREGNANT ADULT
    ## 2 DMR915       2017-03-06      DRY    Female FEMALE PREGNANT ADULT   
    ## 3 DMR916       2017-03-06      DRY    Female FEMALE SUBADULT         
    ## 4 DMR921       2017-03-06      DRY    Male   MALE SCROTAL ADULT      
    ## 5 DMR919       2017-03-06      DRY    Male   MALE JUVENILE           
    ## 6 DMR918       2017-03-06      DRY    Male   MALE JUVENILE

``` r
tail(dplyr::select(BatData, Field.number:Class))
```

    ## # A tibble: 6 x 5
    ##   Field.number Collection.date Season Sex    Class             
    ##   <chr>        <date>          <chr>  <chr>  <chr>             
    ## 1 DMR1021      2017-07-19      RAINY  Male   MALE SCROTAL ADULT
    ## 2 DMR1024      2017-07-19      RAINY  Male   MALE JUVENILE     
    ## 3 DMR1030      2017-07-20      RAINY  Female FEMALE SUBADULT   
    ## 4 DMR1031      2017-07-20      RAINY  Female FEMALE SUBADULT   
    ## 5 DMR1032      2017-07-20      RAINY  Female FEMALE SUBADULT   
    ## 6 DMR1029      2017-07-20      RAINY  Male   MALE SCROTAL ADULT

Columns could also be arranged in descending order: `arrange(BatData,
desc(Collection.date))`

## rename()

Renaming a variable in a data frame in R is surprisingly hard to do\!
The rename() function is designed to make this process easier. The first
column of our data frame is the Id number that was given to each bat in
the field. The syntax inside the rename() function is to have the new
name on the left-hand side of the = sign and the old name on the
right-hand side.

``` r
BatData <- rename(BatData, Id = Field.number)
head(dplyr::select(BatData, Id:Class))
```

    ## # A tibble: 6 x 5
    ##   Id     Collection.date Season Sex    Class                   
    ##   <chr>  <date>          <chr>  <chr>  <chr>                   
    ## 1 DMR910 2017-03-05      DRY    Female FEMALE NONPREGNANT ADULT
    ## 2 DMR915 2017-03-06      DRY    Female FEMALE PREGNANT ADULT   
    ## 3 DMR916 2017-03-06      DRY    Female FEMALE SUBADULT         
    ## 4 DMR921 2017-03-06      DRY    Male   MALE SCROTAL ADULT      
    ## 5 DMR919 2017-03-06      DRY    Male   MALE JUVENILE           
    ## 6 DMR918 2017-03-06      DRY    Male   MALE JUVENILE

That’s nicer\!

## mutate()

The mutate() function exists to compute transformations of variables in
a data frame. Often, you want to create new variables that are derived
from existing variables and mutate() provides a clean interface for
doing that.

For example, we can use Forearm length and Mass to calculate a body
condition index (BCI) that will help us measure if a bat has a lower
than usual Mass for its size.

``` r
BatData <- mutate(BatData, BCI = Mass / FA.length)
summary(BatData$BCI)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
    ##  0.5839  0.6773  0.8388  0.8185  0.9398  1.0702       1

Use the other two lengths that were measured (total body length and hind
foot length) to calculate alternative
BCIs.

``` r
BatData <- mutate(BatData, BCI2 = Total.Length / Hind.Foot) #(BCI2 = body length/hind foot length)
summary(BatData$BCI2)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
    ##   5.190   6.333   6.771   6.797   7.113   8.824       3

There is also the related transmute() function, which does the same
thing as mutate() but then drops all non-transformed variables.

## group\_by()

The group\_by() function is used to generate summary statistics from the
data frame within strata defined by a variable. For this dataset, the
column *class* can be used to segregate the bats by sex, age, and
reproductive status. In conjunction with the group\_by() function we
often use the summarize() function. The group\_by() is VERY valuable for
making statistical comparisons or visual comparisons between groups.

``` r
BatClasses <- group_by(BatData, Class)
dplyr::summarize(BatClasses, Mass=mean(Mass, na.rm = TRUE), BCI=mean(BCI, na.rm = TRUE))
```

    ## # A tibble: 6 x 3
    ##   Class                     Mass   BCI
    ##   <chr>                    <dbl> <dbl>
    ## 1 FEMALE NONPREGNANT ADULT  60.4 0.804
    ## 2 FEMALE PREGNANT ADULT     69.0 0.926
    ## 3 FEMALE SUBADULT           44.8 0.651
    ## 4 MALE JUVENILE             47.6 0.689
    ## 5 MALE SCROTAL ADULT        75.2 0.991
    ## 6 MALE SUBADULT             65.6 0.870

## Pipelines

The output of one verb can be used by another verb in a **pipeline**.
The pipeline is indicated by the pipe operator: `%>%`. Pipelines can be
used even if only a single verb is needed. For example, the code
`filter(BatData, Mass < 55)` can be rewritten as: `BatData %>%
filter(Mass < 55)`

The pipeline operater %\>% is very handy for stringing together multiple
dplyr functions in a sequence of operations. Notice above that every
time we wanted to apply more than one function, the sequence gets buried
in a sequence of nested function calls that is difficult to read:
`third(second(first(x)))` This nesting is not a natural way to think
about a sequence of operations. The %\>% operator allows you to string
operations in a left-to-right fashion: `first(x) %>% second %>% third`
or even: `x %>% first %>% second %>% third`

The example from the previous code chunk can be expressed more clearly
using a pipeline:

``` r
BatData %>% 
  group_by(Class) %>%
  dplyr::summarize(Mass=mean(Mass, na.rm = TRUE), BCI=mean(BCI, na.rm = TRUE))
```

    ## # A tibble: 6 x 3
    ##   Class                     Mass   BCI
    ##   <chr>                    <dbl> <dbl>
    ## 1 FEMALE NONPREGNANT ADULT  60.4 0.804
    ## 2 FEMALE PREGNANT ADULT     69.0 0.926
    ## 3 FEMALE SUBADULT           44.8 0.651
    ## 4 MALE JUVENILE             47.6 0.689
    ## 5 MALE SCROTAL ADULT        75.2 0.991
    ## 6 MALE SUBADULT             65.6 0.870

This way we don’t have to create a set of temporary variables along the
way or create a massive nested sequence of function calls. Notice in the
above code that I pass the BatData data frame to the first call to
group\_by(), but then afterwards I do not have to pass the first
argument to summarize(). Once you travel down the pipeline with %\>%,
the first argument is taken to be the output of the previous element in
the pipeline.

Use a pipeline to compare Mass and BCI of each of the Classes of bat in
each Season. (Hint: group\_by can accept more than one Name)

``` r
BatData %>%
  group_by(Class, Season) %>%
  dplyr::summarize(Mass=mean(Mass, na.rm = TRUE), BCI=mean(BCI, na.rm = TRUE))
```

    ## # A tibble: 11 x 4
    ## # Groups:   Class [6]
    ##    Class                    Season  Mass   BCI
    ##    <chr>                    <chr>  <dbl> <dbl>
    ##  1 FEMALE NONPREGNANT ADULT DRY     60.4 0.804
    ##  2 FEMALE PREGNANT ADULT    DRY     73.2 0.988
    ##  3 FEMALE PREGNANT ADULT    RAINY   65.5 0.880
    ##  4 FEMALE SUBADULT          DRY     45.6 0.654
    ##  5 FEMALE SUBADULT          RAINY   43.8 0.647
    ##  6 MALE JUVENILE            DRY     49.3 0.708
    ##  7 MALE JUVENILE            RAINY   45.9 0.670
    ##  8 MALE SCROTAL ADULT       DRY     74.8 0.986
    ##  9 MALE SCROTAL ADULT       RAINY   75.6 0.997
    ## 10 MALE SUBADULT            DRY     65.1 0.858
    ## 11 MALE SUBADULT            RAINY   66.4 0.891

## Summary

The dplyr package provides a concise set of operations for managing data
frames. With these functions we can do a number of complex operations in
just a few lines of code. In particular, we can often conduct the
beginnings of an exploratory analysis with the powerful combination of
group\_by() and summarize(). Because it is also part of the tidyverse,
you can also use pipelines to feed data to *ggplot2*\!
