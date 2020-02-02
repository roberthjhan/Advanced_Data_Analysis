Homework 02
================
Robert Han

## The Pick et al. Dataset

The dataset that you will be exploring will be found in the Homework02
folder. It was downloaded from the Dryad Data Repository at:
<https://doi.org/10.5061/dryad.40jp4> The paper describing the analysis
of this data can be found here: <https://doi.org/10.1086/688918>

**Disentangling Genetic and Prenatal Maternal Effects on Offspring Size
and Survival** Joel L. Pick, Christina Ebneter, Pascale Hutter, and
Barbara Tschirren *The American Naturalist* 2016 188:6, 628-639

Data of body mass, size and survival throughout development of Japanese
quail chicks originating from reciprocal crosses of divergent artificial
selection lines for prenatal maternal investment

``` r
quail <- read_csv("pick_et_al.csv", trim_ws = TRUE)
```

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   animal = col_character(),
    ##   mother = col_character(),
    ##   father = col_character(),
    ##   maternal.line = col_character(),
    ##   paternal.line = col_character(),
    ##   sex = col_character(),
    ##   hatch.env = col_character(),
    ##   week2.env = col_character(),
    ##   week4.env = col_character(),
    ##   exclude.surv = col_logical()
    ## )

    ## See spec(...) for full column specifications.

``` r
head(quail)
```

    ## # A tibble: 6 x 20
    ##   animal mother father hatch.mass week2.mass week2.tarsus week4.mass
    ##   <chr>  <chr>  <chr>       <dbl>      <dbl>        <dbl>      <dbl>
    ## 1 CY3334 A1487  A1608        8.13       61.1         31.5       158.
    ## 2 CY3362 A1493  A1555        8.73       54.3         29.9       146.
    ## 3 CR1374 A1515  A1596        9.09       66.1         31         166 
    ## 4 CY3323 A1604  A1599        8.07       55.3         30.1       152.
    ## 5 CY3332 A1487  A1608        8.06       71.1         33         171.
    ## 6 CG2717 A1625  A1549        7.24       53.2         28.8       132 
    ## # … with 13 more variables: week4.tarsus <dbl>, adult.tarsus <dbl>,
    ## #   egg.mass <dbl>, maternal.line <chr>, paternal.line <chr>, sex <chr>,
    ## #   replicate <dbl>, hatching.day <dbl>, hatch.env <chr>, week2.env <chr>,
    ## #   week4.env <chr>, survive <dbl>, exclude.surv <lgl>

The following description of the data was also provided: Column Name -
Description “animal” - offspring ID XXXXXXXXXXXXX “mother” - maternal ID
XXXXXXXXXXXXXX “father” - paternal ID XXXXXXXXXXXXXXX “hatch.mass” -
offspring hatchling mass (g) “week2.mass” - offspring week 2 mass (g)
“week2.tarsus” - offspring week 2 tarsus length (mm) “week4.mass” -
offspring week 4 mass (g) “week4.tarsus” - offspring week 4 tarsus
length (mm) “adult.tarsus” - offspring adult tarsus length (mm)
“egg.mass” - egg mass (g) that offspring originated from
“maternal.line” - selection line of the mother; H = high investment
line, L = low investment line “paternal.line” - selection line of the
father; H = high investment line, L = low investment line “sex” -
offspring sex “replicate” - selection line replicate “hatching.day” -
day of hatching (17 or 18) relative to start of incubation (day 0)
“hatch.env” - hatching environment (specific incubator) “week2.env” -
chick rearing environment (specific cage) from hatching to week 2
“week4.env” - juvenile rearing environment (specific cage) from week 2
to week 4 “survive” - survival to adulthood “exclude.surv” - whether
individual was excluded from survival analysis or not (TRUE = excluded);
see
    methods

``` r
summary(quail)
```

    ##     animal             mother             father            hatch.mass    
    ##  Length:911         Length:911         Length:911         Min.   : 5.230  
    ##  Class :character   Class :character   Class :character   1st Qu.: 7.680  
    ##  Mode  :character   Mode  :character   Mode  :character   Median : 8.330  
    ##                                                           Mean   : 8.369  
    ##                                                           3rd Qu.: 8.980  
    ##                                                           Max.   :11.240  
    ##                                                                           
    ##    week2.mass     week2.tarsus     week4.mass     week4.tarsus    adult.tarsus 
    ##  Min.   :19.80   Min.   :20.30   Min.   : 64.8   Min.   :31.60   Min.   :34.9  
    ##  1st Qu.:49.10   1st Qu.:28.70   1st Qu.:125.8   1st Qu.:37.50   1st Qu.:38.6  
    ##  Median :54.30   Median :29.70   Median :136.6   Median :38.40   Median :39.5  
    ##  Mean   :54.12   Mean   :29.62   Mean   :137.0   Mean   :38.43   Mean   :39.5  
    ##  3rd Qu.:59.10   3rd Qu.:30.60   3rd Qu.:146.7   3rd Qu.:39.30   3rd Qu.:40.3  
    ##  Max.   :81.70   Max.   :33.70   Max.   :210.0   Max.   :42.50   Max.   :43.4  
    ##  NA's   :58      NA's   :58      NA's   :60      NA's   :60      NA's   :146   
    ##     egg.mass     maternal.line      paternal.line          sex           
    ##  Min.   : 8.15   Length:911         Length:911         Length:911        
    ##  1st Qu.:11.16   Class :character   Class :character   Class :character  
    ##  Median :11.92   Mode  :character   Mode  :character   Mode  :character  
    ##  Mean   :12.01                                                           
    ##  3rd Qu.:12.81                                                           
    ##  Max.   :15.86                                                           
    ##                                                                          
    ##    replicate      hatching.day    hatch.env          week2.env        
    ##  Min.   :1.000   Min.   :17.00   Length:911         Length:911        
    ##  1st Qu.:1.000   1st Qu.:17.00   Class :character   Class :character  
    ##  Median :2.000   Median :17.00   Mode  :character   Mode  :character  
    ##  Mean   :1.509   Mean   :17.14                                        
    ##  3rd Qu.:2.000   3rd Qu.:17.00                                        
    ##  Max.   :2.000   Max.   :18.00                                        
    ##                                                                       
    ##   week4.env            survive       exclude.surv   
    ##  Length:911         Min.   :0.0000   Mode :logical  
    ##  Class :character   1st Qu.:1.0000   FALSE:905      
    ##  Mode  :character   Median :1.0000   TRUE :6        
    ##                     Mean   :0.9363                  
    ##                     3rd Qu.:1.0000                  
    ##                     Max.   :1.0000                  
    ## 

You can see that some of the data is categorical, but it is of the class
“character”. We should change that to ensure that it these variables are
handled properly during analysis. I have shown you how to do one of
these, but you will need to complete this process, referring to the
description of each variable.

``` r
library(dplyr)
quail$sex <- as.factor(quail$sex)
table(quail$sex)
```

    ## 
    ## Female   Male 
    ##    463    448

Next explore the data to determine if variables look like they will need
to be transformed or if they already have a normal distribution. Note
the importance of testing for normality for each population separately.

``` r
simple.eda(quail$hatch.mass)
```

![](Homework02_files/figure-gfm/Data%20Exploration-1.png)<!-- -->

``` r
shapiro.test(quail$hatch.mass)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  quail$hatch.mass
    ## W = 0.99633, p-value = 0.03131

``` r
shapiro.test(quail$hatch.mass[quail$sex=="Female"])
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  quail$hatch.mass[quail$sex == "Female"]
    ## W = 0.99449, p-value = 0.0948

``` r
shapiro.test(quail$hatch.mass[quail$sex=="Male"])
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  quail$hatch.mass[quail$sex == "Male"]
    ## W = 0.99642, p-value = 0.4186

``` r
t.test(hatch.mass ~ sex, data = quail)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  hatch.mass by sex
    ## t = 2.2923, df = 906.22, p-value = 0.02212
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  0.02139717 0.27614689
    ## sample estimates:
    ## mean in group Female   mean in group Male 
    ##             8.442009             8.293237

This shows us that hatch mass does depend on the sex of the chick.

After exploring the dataset, formulate some additional tentative
hypotheses that you wish to test. I have provided some examples of the
types of graphs that you could consider. You should alter these examples
for your own use (and fix any issues that find.)

``` r
ggplot(quail) +
  aes(x = hatch.mass) +
  geom_histogram(bins=100) +
  theme_cowplot()
```

![](Homework02_files/figure-gfm/Data%20Visualization-1.png)<!-- -->

``` r
ggplot(quail) +
  aes(x = hatch.mass, color = sex, fill = sex) +
  geom_histogram(binwidth = 0.5, position = "dodge") +
  theme_cowplot()
```

![](Homework02_files/figure-gfm/Data%20Visualization-2.png)<!-- -->

``` r
ggplot(quail) +
  aes(x = hatch.mass,  fill = sex) + 
  geom_density(alpha=.3) +
  theme_cowplot()
```

![](Homework02_files/figure-gfm/Data%20Visualization-3.png)<!-- -->

There appears to be some other factors influencing the hatch mass, in
addition to sex. Explore the data and determine how to test a hypothesis
about one of these other factors.

-----

New hypothesis: The investment of the parents influences chick mass.

The data I want to explore in more detail uses the quantitative
variables egg mass, hatch mass, and week2 mass.The hatch mass variable
has already been visualized so only egg mass and week2 mass are shown.
The simple eda shows both variables appear to be normal.

``` r
simple.eda(quail$`egg.mass`)
```

![](Homework02_files/figure-gfm/Data%20exploration-1.png)<!-- -->

``` r
summary(quail$`egg.mass`)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##    8.15   11.16   11.92   12.01   12.81   15.86

``` r
simple.eda(quail$week2.mass)
```

![](Homework02_files/figure-gfm/Data%20exploration-2.png)<!-- -->

``` r
summary(quail$week2.mass)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
    ##   19.80   49.10   54.30   54.12   59.10   81.70      58

Housekeeping for the categorical variables of interest. Recoded maternal
and paternal lines as well as created a new variable called “parents”
which identifies parental investment crosses. Changed hatching day to
factor.

There are some NA values in the data which are removed for later
visualizations.

<https://www.rdocumentation.org/packages/photobiology/versions/0.9.30/topics/na.omit>
Exploratory data analysis in R. Ch. 4.9 mutate()
<https://stackoverflow.com/questions/7201341/how-can-two-strings-be-concatenated>
<https://www.math.ucla.edu/~anderson/rw1001/library/base/html/paste.html>
<https://stackoverflow.com/questions/36615769/is-there-an-alternative-to-revalue-function-from-plyr-when-using-dplyr>

``` r
quail <- na.omit(quail) #remove NA

m_line <- recode(quail$maternal.line, "H" = "Maternal high", "L" = "Maternal low")
p_line <- recode(quail$paternal.line, "H" = "Paternal high", "L" = "Paternal low")
parental_line = data.frame(m_line, p_line)
summary(parental_line)
```

    ##            m_line              p_line   
    ##  Maternal high:394   Paternal high:390  
    ##  Maternal low :371   Paternal low :375

``` r
quail <- mutate(quail, parents = paste(m_line, p_line, sep=" x "))
table(quail$parents)
```

    ## 
    ## Maternal high x Paternal high  Maternal high x Paternal low 
    ##                           201                           193 
    ##  Maternal low x Paternal high   Maternal low x Paternal low 
    ##                           189                           182

``` r
quail$hatching.day <- as.factor(quail$hatching.day)
table(quail$hatching.day)
```

    ## 
    ##  17  18 
    ## 662 103

Perhaps staying in the egg for an additional day allows a chick to grow
more, or maybe it doesn’t. We can’t run a simple eda because the
variable is no longer numeric but the table from before tells us
hatching day is very much weighted towards day 17. Taking a quick peek
with a boxplot reveals suggests there wasn’t much difference in hatch
mass based on what day the chick was born. Visualizing the means also
doesn’t suggest a promising data exploration. So we’re gonna scrap that.

``` r
ggplot(quail) + 
  aes(x = hatching.day, y = hatch.mass) +
  geom_boxplot(outlier.shape = NA) +
  geom_point(alpha = 0.3, position = "jitter", colour = "blue") +
  guides(alpha=FALSE) +
  xlab("Hatch day") + 
  ylab("Hatch mass (g)") +
  theme_cowplot()
```

![](Homework02_files/figure-gfm/Quick%20look%20at%20hatch%20day%20and%20hatch%20mass-1.png)<!-- -->

``` r
plotmeans(hatch.mass ~ hatching.day, data = quail, xlab = "Hatch day", ylab = "Hatch mass (g)")
```

![](Homework02_files/figure-gfm/Quick%20look%20at%20hatch%20day%20and%20hatch%20mass-2.png)<!-- -->

To check the data that was selected shapiro tests were carried out. I
thought using logic and for loops would make the process easier but it
got so gross so fast.

Looking at the results of the shapiro tests we can see several variables
yielding p-values less than 0.05. The skew on these variables is for the
most part between -0.5 and 0.5 which allows us to say the distribution
is apporximately symmetrical. Looking at the distribution of data with
the simple eda we can see the data isn’t horrible. Both variables are
right skewed and between -0.5 and 0.5; therefore we say the two are
approximately symmetrical (according to Brownmath.com) so we can
probably ignore it. The greatest skew comes from looking at Maternal low
x Paternal high (hatch mass) which had p-value: 0.00607270038906764 and
skew: -0.523814340748249. Even so the skew is small enough that we can
almost say it is approximately symmetrical.

Distribution of the parental line data is well balanced

p-value report: hatch mass

Maternal high p-value: 0.017188649785972 Maternal low p-value:
0.124122738179463 Paternal high p-value: 0.122927108707938 Paternal low
p-value: 0.00172976930963811 Maternal high x Paternal low p-value:
0.22400832115948 Maternal low x Paternal high p-value:
0.00607270038906764 Maternal low x Paternal low p-value:
0.0730605593584457

egg mass

Maternal high p-value: 0.163379596841482 Maternal low p-value:
0.0591312769918625 Paternal high p-value: 0.141950593175119 Paternal low
p-value: 0.00316749563148435 Maternal high x Paternal high p-value:
0.24063069078182 Maternal high x Paternal low p-value: 0.190064322294475
Maternal low x Paternal high p-value: 0.0138178345042709 Maternal low x
Paternal low p-value: 0.200543219527835

<https://brownmath.com/stat/shape.htm>
<https://www.datamentor.io/r-programming/for-loop/>
<https://www.datamentor.io/r-programming/if-else-statement/>
<https://stackoverflow.com/questions/9317830/r-do-i-need-to-add-explicit-new-line-character-with-print/9317914>

``` r
m_p <- c("Maternal", "Paternal")
l_h <- c("high", "low")
parentz <- c("Maternal high x Paternal high", "Maternal high x Paternal low", "Maternal low x Paternal high", "Maternal low x Paternal low")

cat("hatch mass\n")
```

    ## hatch mass

``` r
for (a in m_p){
  for (b in l_h){
    name = paste(a, b)
    if (a == "Maternal") 
      {shap = shapiro.test(quail$hatch.mass[m_line==name])$p.value 
      cat(paste("\n", name, "p-value: ", shap))
      if (shap < 0.05) 
        {cat(paste("\n", "    ^^ skew: ", skewness(quail$hatch.mass[m_line==name])))}}
    else if (a == "Paternal") {shap = shapiro.test(quail$hatch.mass[p_line==name])$p.value
    cat(paste("\n", name, "p-value: ", shap))
      if (shap < 0.05) 
        {cat(paste("\n", "   ^^ skew: ", skewness(quail$hatch.mass[p_line==name])))}}
    }
  }
```

    ## 
    ##  Maternal high p-value:  0.017188649785972
    ##      ^^ skew:  0.138708780240053
    ##  Maternal low p-value:  0.124122738179463
    ##  Paternal high p-value:  0.122927108707938
    ##  Paternal low p-value:  0.00172976930963811
    ##     ^^ skew:  0.234003307977334

``` r
for (val in parentz){
  shap = shapiro.test(quail$hatch.mass[quail$parents==val])$p.value
  cat(paste("\n",val, "p-value: ", shap))
  if (shap < 0.05) 
    {cat(paste("\n    ^^ skew: ", skewness(quail$hatch.mass[quail$parents==val])))}
  }
```

    ## 
    ##  Maternal high x Paternal high p-value:  0.049097585544777
    ##     ^^ skew:  0.238054980100835
    ##  Maternal high x Paternal low p-value:  0.22400832115948
    ##  Maternal low x Paternal high p-value:  0.00607270038906764
    ##     ^^ skew:  -0.523814340748249
    ##  Maternal low x Paternal low p-value:  0.0730605593584457

``` r
cat("\n\negg mass\n")
```

    ## 
    ## 
    ## egg mass

``` r
for (a in m_p){
  for (b in l_h){
    name = paste(a, b)
    if (a == "Maternal") 
      {shap = shapiro.test(quail$egg.mass[m_line==name])$p.value 
      cat(paste("\n", name, "p-value: ", shap))
      if (shap < 0.05) 
        {cat(paste("\n", "    ^^ skew: ", skewness(quail$egg.mass[m_line==name])))}}
    else if (a == "Paternal") {shap = shapiro.test(quail$egg.mass[p_line==name])$p.value
    cat(paste("\n", name, "p-value: ", shap))
      if (shap < 0.05) 
        {cat(paste("\n", "   ^^ skew: ", skewness(quail$egg.mass[p_line==name])))}}
    }
  }
```

    ## 
    ##  Maternal high p-value:  0.163379596841482
    ##  Maternal low p-value:  0.0591312769918625
    ##  Paternal high p-value:  0.141950593175119
    ##  Paternal low p-value:  0.00316749563148435
    ##     ^^ skew:  0.314326848596973

``` r
for (val in parentz){
  shap = shapiro.test(quail$egg.mass[quail$parents==val])$p.value
  cat(paste("\n",val, "p-value: ", shap))
  if (shap < 0.05) 
  {cat(paste("\n    ^^ skew: ", skewness(quail$egg.mass[quail$parents==val])))}
    }
```

    ## 
    ##  Maternal high x Paternal high p-value:  0.24063069078182
    ##  Maternal high x Paternal low p-value:  0.190064322294475
    ##  Maternal low x Paternal high p-value:  0.0138178345042709
    ##     ^^ skew:  -0.378970807745604
    ##  Maternal low x Paternal low p-value:  0.200543219527835

``` r
cat("\n\n")
```

``` r
table(m_line)
```

    ## m_line
    ## Maternal high  Maternal low 
    ##           394           371

``` r
table(p_line)
```

    ## p_line
    ## Paternal high  Paternal low 
    ##           390           375

``` r
table(quail$parents)
```

    ## 
    ## Maternal high x Paternal high  Maternal high x Paternal low 
    ##                           201                           193 
    ##  Maternal low x Paternal high   Maternal low x Paternal low 
    ##                           189                           182

Boxplots were created to better see the individual effects of parental
lines on hatch mass. We can see from the boxplots and plotted means that
maternal investment appears to contribute the most to hatch mass. The
difference in mean hatch mass is negligible when we look at the paternal
line. Similar observations were made for the egg mass.

``` r
ggplot(quail) + 
  aes(x = m_line, y = hatch.mass) +
  geom_boxplot(outlier.shape = NA) +
  geom_point(alpha = 0.3, position = "jitter", colour = "red") +
  guides(alpha=FALSE) +
  xlab("Maternal line") + 
  ylab("Hatch mass (g)") +
  theme_cowplot()
```

![](Homework02_files/figure-gfm/Boxplots%20and%20mean%20comparison%20of%20hatch%20mass%20by%20parental%20line-1.png)<!-- -->

``` r
ggplot(quail) + 
  aes(x = p_line, y = hatch.mass) +
  geom_boxplot(outlier.shape = NA) +
  geom_point(alpha = 0.3, position = "jitter", colour = "blue") +
  guides(alpha=FALSE) +
  xlab("Paternal line") + 
  ylab("Hatch mass (g)") +
  theme_cowplot()
```

![](Homework02_files/figure-gfm/Boxplots%20and%20mean%20comparison%20of%20hatch%20mass%20by%20parental%20line-2.png)<!-- -->

``` r
plotmeans(hatch.mass ~ m_line, data = quail, xlab = "Maternal line", ylab = "Hatch mass (g)")
```

![](Homework02_files/figure-gfm/Boxplots%20and%20mean%20comparison%20of%20hatch%20mass%20by%20parental%20line-3.png)<!-- -->

``` r
plotmeans(hatch.mass ~ p_line, data = quail, xlab = "Paternal line", ylab = "Hatch mass (g)")
```

![](Homework02_files/figure-gfm/Boxplots%20and%20mean%20comparison%20of%20hatch%20mass%20by%20parental%20line-4.png)<!-- -->

``` r
ggplot(quail) + 
  aes(x = m_line, y = egg.mass) +
  geom_boxplot(outlier.shape = NA) +
  geom_point(alpha = 0.3, position = "jitter", colour = "red") +
  guides(alpha=FALSE) +
  xlab("Maternal line") + 
  ylab("Egg mass (g)") +
  theme_cowplot()
```

![](Homework02_files/figure-gfm/Boxplots%20and%20mean%20comparison%20of%20hatch%20mass%20by%20parental%20line-5.png)<!-- -->

``` r
ggplot(quail) + 
  aes(x = p_line, y = egg.mass) +
  geom_boxplot(outlier.shape = NA) +
  geom_point(alpha = 0.3, position = "jitter", colour = "blue") +
  guides(alpha=FALSE) +
  xlab("Paternal line") + 
  ylab("Egg mass (g)") +
  theme_cowplot()
```

![](Homework02_files/figure-gfm/Boxplots%20and%20mean%20comparison%20of%20hatch%20mass%20by%20parental%20line-6.png)<!-- -->

``` r
plotmeans(egg.mass ~ m_line, data = quail, xlab = "Maternal line", ylab = "Egg mass (g)")
```

![](Homework02_files/figure-gfm/Boxplots%20and%20mean%20comparison%20of%20hatch%20mass%20by%20parental%20line-7.png)<!-- -->

``` r
plotmeans(egg.mass ~ p_line, data = quail, xlab = "Paternal line", ylab = "Egg mass (g)")
```

![](Homework02_files/figure-gfm/Boxplots%20and%20mean%20comparison%20of%20hatch%20mass%20by%20parental%20line-8.png)<!-- -->

T-tests were used to test the significance of the difference in means
between high and low parental investments. Unsurprisingly the the
difference between high and low investment in the maternal lines was
significant for both hatch mass and egg mass (p = 2.2e-16 and 2.2e-16
respectively). The difference between paternal lines was not significant
for both hatch mass and egg mass (p = 0.3083 and 0.229 respectively).

``` r
t.test(hatch.mass ~ m_line, data = quail)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  hatch.mass by m_line
    ## t = 22.116, df = 761.53, p-value < 2.2e-16
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  1.095073 1.308410
    ## sample estimates:
    ## mean in group Maternal high  mean in group Maternal low 
    ##                    9.008426                    7.806685

``` r
t.test(hatch.mass ~ p_line, data = quail)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  hatch.mass by p_line
    ## t = -1.0195, df = 757.27, p-value = 0.3083
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  -0.20800590  0.06581103
    ## sample estimates:
    ## mean in group Paternal high  mean in group Paternal low 
    ##                    8.390769                    8.461867

``` r
t.test(egg.mass ~ m_line, data = quail)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  egg.mass by m_line
    ## t = 22.991, df = 756.76, p-value < 2.2e-16
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  1.403929 1.666061
    ## sample estimates:
    ## mean in group Maternal high  mean in group Maternal low 
    ##                    12.81221                    11.27722

``` r
t.test(egg.mass ~ p_line, data = quail)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  egg.mass by p_line
    ## t = -1.2039, df = 758.49, p-value = 0.229
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  -0.27570893  0.06609723
    ## sample estimates:
    ## mean in group Paternal high  mean in group Paternal low 
    ##                    12.01641                    12.12122

Boxplots and plots of means were used to visualize the combined effects
of parental lines (maternal and paternal). I really thought this would
be a coolthing to visualize but it’s just repeating or reaffirming the
last set of boxplots. Anyways, maternal investment is suggested to be a
dominating factor in both egg mass and hatch mass.

``` r
ggplot(quail) + 
  aes(x = parents, y = hatch.mass) +
  geom_boxplot(outlier.shape = NA) +
  geom_point(alpha = 0.3, position = "jitter", colour = "blue") +
  guides(alpha=FALSE) +
  xlab("Parent cross") + 
  ylab("Hatch mass (g)") +
  theme_cowplot() + 
  theme(axis.text.x = element_text(angle = 30)) 
```

![](Homework02_files/figure-gfm/Boxplots%20and%20mean%20comparison%20of%20parental%20investment%20by%20parental%20crosses-1.png)<!-- -->

``` r
ggplot(quail) + 
  aes(x = parents, y = egg.mass) +
  geom_boxplot(outlier.shape = NA) +
  geom_point(alpha = 0.3, position = "jitter", colour = "blue") +
  guides(alpha=FALSE) +
  xlab("Parent cross") + 
  ylab("Egg mass (g)") +
  theme_cowplot() + 
  theme(axis.text.x = element_text(angle = 30)) 
```

![](Homework02_files/figure-gfm/Boxplots%20and%20mean%20comparison%20of%20parental%20investment%20by%20parental%20crosses-2.png)<!-- -->

``` r
plotmeans(hatch.mass ~ parents, data = quail, xlab = "Parents", ylab = "Hatch mass (g)")
```

![](Homework02_files/figure-gfm/Boxplots%20and%20mean%20comparison%20of%20parental%20investment%20by%20parental%20crosses-3.png)<!-- -->

``` r
plotmeans(egg.mass ~ parents, data = quail, xlab = "Parents", ylab = "Egg mass (g)")
```

![](Homework02_files/figure-gfm/Boxplots%20and%20mean%20comparison%20of%20parental%20investment%20by%20parental%20crosses-4.png)<!-- -->

ANOVA confirms the conclusions made from the boxplots and plots of
means. There are significant differences in the means of different
populations. With p-values \< 0.05 for hatch mass and egg mass (p =
2e-16 for both). Going further with the Tukey test it’s made even more
clear that maternal factors have the greatest influence on early mass.

Hatch mass:Maternal high x Paternal low-Maternal high x Paternal high p
= 0.4050669, Maternal low x Paternal low-Maternal low x Paternal high p
= 0.9911414. Egg mass: Maternal high x Paternal low-Maternal high x
Paternal high p = 0.2087676, Maternal low x Paternal low-Maternal low x
Paternal high p = 0.9936364.

The high p-values indicate statistically insignificant differences
between the populations where the Maternal line is the same.

<http://www.sthda.com/english/wiki/one-way-anova-test-in-r>

``` r
cat("Hatch mass")
```

    ## Hatch mass

``` r
hatch.aov <- aov(hatch.mass ~ parents, data = quail)
summary(hatch.aov)
```

    ##              Df Sum Sq Mean Sq F value Pr(>F)    
    ## parents       3  277.4   92.46     163 <2e-16 ***
    ## Residuals   761  431.7    0.57                   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
TukeyHSD(hatch.aov)
```

    ##   Tukey multiple comparisons of means
    ##     95% family-wise confidence level
    ## 
    ## Fit: aov(formula = hatch.mass ~ parents, data = quail)
    ## 
    ## $parents
    ##                                                                   diff
    ## Maternal high x Paternal low-Maternal high x Paternal high  0.11805583
    ## Maternal low x Paternal high-Maternal high x Paternal high -1.15520019
    ## Maternal low x Paternal low-Maternal high x Paternal high  -1.13219042
    ## Maternal low x Paternal high-Maternal high x Paternal low  -1.27325602
    ## Maternal low x Paternal low-Maternal high x Paternal low   -1.25024626
    ## Maternal low x Paternal low-Maternal low x Paternal high    0.02300977
    ##                                                                    lwr
    ## Maternal high x Paternal low-Maternal high x Paternal high -0.07738562
    ## Maternal low x Paternal high-Maternal high x Paternal high -1.35169389
    ## Maternal low x Paternal low-Maternal high x Paternal high  -1.33062207
    ## Maternal low x Paternal high-Maternal high x Paternal low  -1.47171347
    ## Maternal low x Paternal low-Maternal high x Paternal low   -1.45062265
    ## Maternal low x Paternal low-Maternal low x Paternal high   -0.17839309
    ##                                                                   upr     p adj
    ## Maternal high x Paternal low-Maternal high x Paternal high  0.3134973 0.4050669
    ## Maternal low x Paternal high-Maternal high x Paternal high -0.9587065 0.0000000
    ## Maternal low x Paternal low-Maternal high x Paternal high  -0.9337588 0.0000000
    ## Maternal low x Paternal high-Maternal high x Paternal low  -1.0747986 0.0000000
    ## Maternal low x Paternal low-Maternal high x Paternal low   -1.0498699 0.0000000
    ## Maternal low x Paternal low-Maternal low x Paternal high    0.2244126 0.9911414

``` r
cat("\nEgg mass")
```

    ## 
    ## Egg mass

``` r
egg.aov <- aov(egg.mass ~ parents, data = quail)
summary(egg.aov)
```

    ##              Df Sum Sq Mean Sq F value Pr(>F)    
    ## parents       3  453.5  151.18   176.3 <2e-16 ***
    ## Residuals   761  652.5    0.86                   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
TukeyHSD(egg.aov)
```

    ##   Tukey multiple comparisons of means
    ##     95% family-wise confidence level
    ## 
    ## Fit: aov(formula = egg.mass ~ parents, data = quail)
    ## 
    ## $parents
    ##                                                                   diff
    ## Maternal high x Paternal low-Maternal high x Paternal high  0.18183479
    ## Maternal low x Paternal high-Maternal high x Paternal high -1.45832449
    ## Maternal low x Paternal low-Maternal high x Paternal high  -1.43304590
    ## Maternal low x Paternal high-Maternal high x Paternal low  -1.64015928
    ## Maternal low x Paternal low-Maternal high x Paternal low   -1.61488069
    ## Maternal low x Paternal low-Maternal low x Paternal high    0.02527859
    ##                                                                    lwr
    ## Maternal high x Paternal low-Maternal high x Paternal high -0.05842858
    ## Maternal low x Paternal high-Maternal high x Paternal high -1.69988142
    ## Maternal low x Paternal low-Maternal high x Paternal high  -1.67698521
    ## Maternal low x Paternal high-Maternal high x Paternal low  -1.88413031
    ## Maternal low x Paternal low-Maternal high x Paternal low   -1.86121075
    ## Maternal low x Paternal low-Maternal low x Paternal high   -0.22231334
    ##                                                                   upr     p adj
    ## Maternal high x Paternal low-Maternal high x Paternal high  0.4220982 0.2087676
    ## Maternal low x Paternal high-Maternal high x Paternal high -1.2167676 0.0000000
    ## Maternal low x Paternal low-Maternal high x Paternal high  -1.1891066 0.0000000
    ## Maternal low x Paternal high-Maternal high x Paternal low  -1.3961882 0.0000000
    ## Maternal low x Paternal low-Maternal high x Paternal low   -1.3685506 0.0000000
    ## Maternal low x Paternal low-Maternal low x Paternal high    0.2728705 0.9936364

Originally I was trying to help Fallon figure out a way to visualize
multiple boxplots of different y-values in a single figure. This was not
what she wanted but it looks cool so it stays. The egg and hatch mass
boxplots are nothing new but looking at the week 2 mass suggests
regardless of the chick’s parentage, they seem to approach a similar
mass. In other words, it may be that parental investment has the most
impact around hatching. As time goes on the effect of parental
investment on mass is less
pronounced.

<https://stackoverflow.com/questions/14785530/ggplot-boxplot-of-multiple-column-values>
<https://stackoverflow.com/questions/14604439/plot-multiple-boxplot-in-one-graph>
<https://www.rdocumentation.org/packages/mudata/versions/0.1.1/topics/id.vars>

``` r
mass <- melt(quail, id.vars='parents', measure.vars= c('egg.mass','hatch.mass', 'week2.mass'))
ggplot(mass) +
      geom_boxplot(aes(x = parents, y = log(value), color = variable)) + 
      xlab("Parent cross") +
      ylab("log10 mass (g)") +
      theme_cowplot() + 
      theme(axis.text.x = element_text(angle = 30)) 
```

![](Homework02_files/figure-gfm/Boxplot%20of%20egg,%20hatch,%20and%20week%202%20mass-1.png)<!-- -->

Egg and hatch mass are very likely dependent variables but we can use
the two to see the relationship between chick mass and parental
investment in another way. From the scatterplot we can confirm again
that the individuals with the greatest egg and hatch mass are those with
high maternal investment.

``` r
ggplot(quail) + 
  aes(y = (hatch.mass), x = (egg.mass)) + 
  theme(legend.position = c(0.05, 0.8)) +
  geom_point(aes(colour = parents), alpha = 0.5) +
  geom_smooth(method=lm , colour="black", se=TRUE) +
  ylab("Hatch mass (g)") + 
  xlab("Egg mass (g)") +
  theme_cowplot()
```

![](Homework02_files/figure-gfm/Scatterplot%20egg%20mass%20x%20hatch%20mass-1.png)<!-- -->
The p-value for linear regression is well below 0.05 (p = 2.2e-16).

``` r
egg_mass_fit = lm((egg.mass)~(hatch.mass), data=quail)
summary(egg_mass_fit)
```

    ## 
    ## Call:
    ## lm(formula = (egg.mass) ~ (hatch.mass), data = quail)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -1.44789 -0.23200 -0.02279  0.19199  1.37006 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  2.01454    0.11324   17.79   <2e-16 ***
    ## hatch.mass   1.19318    0.01335   89.36   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.3556 on 763 degrees of freedom
    ## Multiple R-squared:  0.9128, Adjusted R-squared:  0.9127 
    ## F-statistic:  7985 on 1 and 763 DF,  p-value: < 2.2e-16

Out of curiosity I wondered if the egg itself was something that also
differed in mass. To investigate this question I created a new variable
called just\_the\_egg which was the result of subtracting the hatch mass
from the egg mass. The variable was plotted as a boxplot and plot of
means with respect to parental line cross and suggests that maternal
investment is the deciding factor for just the egg as well.

``` r
quail <- mutate(quail, just_the_egg = (egg.mass - hatch.mass))

ggplot(quail) + 
  aes(x = parents, y = just_the_egg) +
  geom_boxplot(outlier.shape = NA) +
  geom_point(alpha = 0.3, position = "jitter", colour = "blue") +
  guides(alpha=FALSE) +
  xlab("Parental cross") + 
  ylab("just_the_egg mass (g)") +
  theme_cowplot() + 
  theme(axis.text.x = element_text(angle = 30)) 
```

![](Homework02_files/figure-gfm/Just%20the%20egg-1.png)<!-- -->

``` r
plotmeans(hatch.mass ~ parents, data = quail, xlab = "Parents", ylab = "just_the_egg mass (g)")
```

![](Homework02_files/figure-gfm/Just%20the%20egg-2.png)<!-- -->

<https://twitter.com/CMastication/status/1142832452890759169/photo/1>
