Homework 04
================
Robert Han
2/25/2020

## Loading Libraries

Use the following syntax to load any libraries that you need. This code
will prevent errors that will interfere with knitting of the Rmd file.
Also note that the `include=FALSE` option will prevent this code chunk
from appearing in the markdown file.

We will load the entire tidyverse library, which includes *dplyr*,
*ggplot2*, *readr*, and other packages.

Brenna recieved an article which was somewhat related to the paper I was
assigned titled “A long journey toward reproducible results.” The
article itself was about several groups of researchers who were unable
to reproduce the findings of the author’s research group. To resolve
this issue, they teamed up to standardize the way they set up and
performed their experiments and shared the data with each other in an
online dataset. I searched around for it, and found it, however
Petrasheck was not listed as a contributer to the dataset. In my
desperation I reached out the legend himself and lo and behold he
responded. He sent him his data in a .raw image file but alas, no matter
what I used to open it, I could not unlock it’s secrets. Photoshop,
Gimp, online image converters, nothing could crack this nut. And so, I
resorted to recreating a figure from the Supplementary Information which
holds summary statistics used to generate the figures.
<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5762131/>
<https://www.scripps.edu/faculty/petrascheck/>

Read in the data from the dataset that I made from the supplementary
information pdf. Make the variables “Strain” and “n” unique factors so
their arrangment won’t change in the
barplot.

<https://www.r-bloggers.com/use-unique-instead-of-levels-to-find-the-possible-values-of-a-character-variable-in-r/>

``` r
project_data <- read.csv("Summary statistics.csv")
project_data$Strain <- factor(project_data$Strain, levels=unique(project_data$Strain))

project_data$n <- sapply(project_data$n, as.character)
project_data$n[is.na(project_data$n)] <- " "

project_data$n <- factor(project_data$n, levels=unique(project_data$n))
project_data$n <- as.factor(project_data$n)
```

Check the data, make sure everything has been imported, make sure the
changes we made earlier carried through.

``` r
str(project_data)
```

    ## 'data.frame':    30 obs. of  6 variables:
    ##  $ Strain       : Factor w/ 16 levels "N2/d1","N2/L1",..: 1 1 2 3 4 4 5 5 6 6 ...
    ##  $ Drug         : Factor w/ 1 level "Mianserin": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Mean.lifespan: num  30.9 23.6 26.6 NA 35.6 34.2 30.2 29.5 19.7 17.2 ...
    ##  $ SEM          : int  3 3 5 NA 2 2 4 4 1 1 ...
    ##  $ n            : Factor w/ 16 levels "166","133","80",..: 1 2 3 4 5 6 7 5 7 6 ...
    ##  $ Treatment    : Factor w/ 2 levels "Control","Drug": 2 1 2 1 2 1 2 1 2 1 ...

``` r
head(project_data)
```

    ##   Strain      Drug Mean.lifespan SEM   n Treatment
    ## 1  N2/d1 Mianserin          30.9   3 166      Drug
    ## 2  N2/d1 Mianserin          23.6   3 133   Control
    ## 3  N2/L1 Mianserin          26.6   5  80      Drug
    ## 4        Mianserin            NA  NA       Control
    ## 5  N2/DR Mianserin          35.6   2  32      Drug
    ## 6  N2/DR Mianserin          34.2   2  30   Control

``` r
tail(project_data)
```

    ##    Strain      Drug Mean.lifespan SEM  n Treatment
    ## 25  ser-4 Mianserin          29.7   2 64      Drug
    ## 26  ser-4 Mianserin          27.7   2 71   Control
    ## 27  ser-7 Mianserin          33.9  11 32      Drug
    ## 28  ser-7 Mianserin          21.2  11 30   Control
    ## 29  tph-1 Mianserin          25.1   1 40      Drug
    ## 30  tph-1 Mianserin          25.0   1 56   Control

So this was a joy to figure out. Luckily I knew to use stat = “identity”
from project 1. In order to replicate the bar-graph in figure d, we need
to seperate the treatment groups, while also keeping strains together.
To do so we use the position = “dodge” arguement in conjunction with
fill = Treatment. This however makes the x-axis the strain so we also
need to overwrite that. Because the data we are overwriting with is a
discrete variable we use a specific call “scale\_x\_discrete().” Since
that makes the x-axis discrete we need to to specify in the geom\_line
calls (group = 1) The rest of the additions are cosmetic such as
horizontal lines, error bars, bar labels, and axis
labels.

<https://stackoverflow.com/questions/40211451/geom-text-how-to-position-the-text-on-bar-as-i-want>
<https://community.rstudio.com/t/error-aesthetics-must-be-either-length-1-or-the-same-as-the-data-2-fill/15579/3>
<http://www.sthda.com/english/wiki/ggplot2-error-bars-quick-start-guide-r-software-and-data-visualization>
<https://stackoverflow.com/questions/35095129/override-x-axis-ticks>
<https://stackoverflow.com/questions/31818264/no-line-in-plot-chart-despite-geom-line/31819922>

``` r
ggplot(project_data) +
  geom_line(aes(y =  40, group = 1)) +
  geom_line(aes(y =  30, group = 1)) +
  geom_line(aes(y =  20, group = 1)) +
  aes(x = Strain, y = Mean.lifespan, fill = Treatment) +
  geom_bar(stat="identity", width = 0.7, position = position_dodge(width = 1)) +
  geom_text(aes(label= Strain), position = position_dodge(width = 0.9), vjust = -1) +
  geom_errorbar(aes(ymin=Mean.lifespan-SEM, ymax=Mean.lifespan+SEM), width=.2, position=position_dodge(.9)) +
  scale_y_continuous(limits = c(0,45), expand = c(0, 0)) +
  scale_x_discrete(labels = c("166  133", "80   ", "    ", "32  30", "24  32", "24  30", "32  32", "32  48", "31  42", "43  55", "31  40", "32  40", "48  64", "64  71", "32  30", "40  56")) +
  xlab("Number of wells assayed") +
  ylab("Mean lifespan (days)") +
  theme_cowplot() 
```

    ## Warning: Removed 1 rows containing missing values (geom_bar).

    ## Warning: Removed 1 rows containing missing values (geom_text).

    ## Warning: Removed 2 rows containing missing values (geom_errorbar).

![](Homework4_files/figure-gfm/barplot-1.png)<!-- -->

When comparing this recreated figure with the original, I noticed that
the error bars differed greatly between the two. In my figure the error
bars are significantly larger than those in the paper. Checking the
supplementary data and figure methods, I’m not exactly sure why mine are
so much larger. Ser-7 for example was reported as having SEM of 11 which
is clearly reflected in my plot but appears much smaller in the paper
especially considering that the figure in the paper is cropped. As far
as reproducibility goes, I’d give this paper a lower score because the
raw data is not readily available. Furthermore, the supplementary
information does not appear to completely reflect the figures especially
where these error bars are concerned.

## Acknowledgements

Brenna, Fallon, and I hung out to lament about our troubles with finding
data, being able to wallow in a group is so much better than doing it
alone. Also big shoutout to Michael Petrascheck PhD, who not only
responded to my calls for help in a timely manner on a Sunday but was
able to send me the data for his paper, albeit in a format that I cannot
open.