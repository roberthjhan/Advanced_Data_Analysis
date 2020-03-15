Homework 03
================
Robert Han
02/03/2020

``` r
knitr::opts_chunk$set(echo = TRUE)
```

# Homework 3

Due at noon on 12 Feb 2020.

# Exploratory Data Analysis Checklist

Follow Chapter 5 from *Exploratory Data Analysis with R*
(<https://leanpub.com/exdata/read_full>) by Roger D. Peng to explore one
of the following datasets: - Uganda Bat Dataset from Lab 4 - NHANES
Dataset from Lab 3

Loading in the data is the first step. “This is survey data collected by
the US National Center for Health Statistics (NCHS) which has conducted
a series of health and nutrition surveys since the early 1960’s. Since
1999 approximately 5,000 individuals of all ages are interviewed in
their homes every year and complete the health examination component of
the survey. The health examination is conducted in a mobile examination
center (MEC)” (Lab03 description). This dataset includes data from two
years (2009-10 & 2010-11)

According to what’s been read in, we can expect 10,000 rows of data,
with several rows having at least one NA value, and 76 columns or
variables.

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    10000 obs. of  76 variables:
    ##  $ ID              : int  51624 51624 51624 51625 51630 51638 51646 51647 51647 51647 ...
    ##  $ SurveyYr        : Factor w/ 2 levels "2009_10","2011_12": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Gender          : Factor w/ 2 levels "female","male": 2 2 2 2 1 2 2 1 1 1 ...
    ##  $ Age             : int  34 34 34 4 49 9 8 45 45 45 ...
    ##  $ AgeDecade       : Factor w/ 8 levels " 0-9"," 10-19",..: 4 4 4 1 5 1 1 5 5 5 ...
    ##  $ AgeMonths       : int  409 409 409 49 596 115 101 541 541 541 ...
    ##  $ Race1           : Factor w/ 5 levels "Black","Hispanic",..: 4 4 4 5 4 4 4 4 4 4 ...
    ##  $ Race3           : Factor w/ 6 levels "Asian","Black",..: NA NA NA NA NA NA NA NA NA NA ...
    ##  $ Education       : Factor w/ 5 levels "8th Grade","9 - 11th Grade",..: 3 3 3 NA 4 NA NA 5 5 5 ...
    ##  $ MaritalStatus   : Factor w/ 6 levels "Divorced","LivePartner",..: 3 3 3 NA 2 NA NA 3 3 3 ...
    ##  $ HHIncome        : Factor w/ 12 levels " 0-4999"," 5000-9999",..: 6 6 6 5 7 11 9 11 11 11 ...
    ##  $ HHIncomeMid     : int  30000 30000 30000 22500 40000 87500 60000 87500 87500 87500 ...
    ##  $ Poverty         : num  1.36 1.36 1.36 1.07 1.91 1.84 2.33 5 5 5 ...
    ##  $ HomeRooms       : int  6 6 6 9 5 6 7 6 6 6 ...
    ##  $ HomeOwn         : Factor w/ 3 levels "Own","Rent","Other": 1 1 1 1 2 2 1 1 1 1 ...
    ##  $ Work            : Factor w/ 3 levels "Looking","NotWorking",..: 2 2 2 NA 2 NA NA 3 3 3 ...
    ##  $ Weight          : num  87.4 87.4 87.4 17 86.7 29.8 35.2 75.7 75.7 75.7 ...
    ##  $ Length          : num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ HeadCirc        : num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ Height          : num  165 165 165 105 168 ...
    ##  $ BMI             : num  32.2 32.2 32.2 15.3 30.6 ...
    ##  $ BMICatUnder20yrs: Factor w/ 4 levels "UnderWeight",..: NA NA NA NA NA NA NA NA NA NA ...
    ##  $ BMI_WHO         : Factor w/ 4 levels "12.0_18.5","18.5_to_24.9",..: 4 4 4 1 4 1 2 3 3 3 ...
    ##  $ Pulse           : int  70 70 70 NA 86 82 72 62 62 62 ...
    ##  $ BPSysAve        : int  113 113 113 NA 112 86 107 118 118 118 ...
    ##  $ BPDiaAve        : int  85 85 85 NA 75 47 37 64 64 64 ...
    ##  $ BPSys1          : int  114 114 114 NA 118 84 114 106 106 106 ...
    ##  $ BPDia1          : int  88 88 88 NA 82 50 46 62 62 62 ...
    ##  $ BPSys2          : int  114 114 114 NA 108 84 108 118 118 118 ...
    ##  $ BPDia2          : int  88 88 88 NA 74 50 36 68 68 68 ...
    ##  $ BPSys3          : int  112 112 112 NA 116 88 106 118 118 118 ...
    ##  $ BPDia3          : int  82 82 82 NA 76 44 38 60 60 60 ...
    ##  $ Testosterone    : num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ DirectChol      : num  1.29 1.29 1.29 NA 1.16 1.34 1.55 2.12 2.12 2.12 ...
    ##  $ TotChol         : num  3.49 3.49 3.49 NA 6.7 4.86 4.09 5.82 5.82 5.82 ...
    ##  $ UrineVol1       : int  352 352 352 NA 77 123 238 106 106 106 ...
    ##  $ UrineFlow1      : num  NA NA NA NA 0.094 ...
    ##  $ UrineVol2       : int  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ UrineFlow2      : num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ Diabetes        : Factor w/ 2 levels "No","Yes": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ DiabetesAge     : int  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ HealthGen       : Factor w/ 5 levels "Excellent","Vgood",..: 3 3 3 NA 3 NA NA 2 2 2 ...
    ##  $ DaysPhysHlthBad : int  0 0 0 NA 0 NA NA 0 0 0 ...
    ##  $ DaysMentHlthBad : int  15 15 15 NA 10 NA NA 3 3 3 ...
    ##  $ LittleInterest  : Factor w/ 3 levels "None","Several",..: 3 3 3 NA 2 NA NA 1 1 1 ...
    ##  $ Depressed       : Factor w/ 3 levels "None","Several",..: 2 2 2 NA 2 NA NA 1 1 1 ...
    ##  $ nPregnancies    : int  NA NA NA NA 2 NA NA 1 1 1 ...
    ##  $ nBabies         : int  NA NA NA NA 2 NA NA NA NA NA ...
    ##  $ Age1stBaby      : int  NA NA NA NA 27 NA NA NA NA NA ...
    ##  $ SleepHrsNight   : int  4 4 4 NA 8 NA NA 8 8 8 ...
    ##  $ SleepTrouble    : Factor w/ 2 levels "No","Yes": 2 2 2 NA 2 NA NA 1 1 1 ...
    ##  $ PhysActive      : Factor w/ 2 levels "No","Yes": 1 1 1 NA 1 NA NA 2 2 2 ...
    ##  $ PhysActiveDays  : int  NA NA NA NA NA NA NA 5 5 5 ...
    ##  $ TVHrsDay        : Factor w/ 7 levels "0_hrs","0_to_1_hr",..: NA NA NA NA NA NA NA NA NA NA ...
    ##  $ CompHrsDay      : Factor w/ 7 levels "0_hrs","0_to_1_hr",..: NA NA NA NA NA NA NA NA NA NA ...
    ##  $ TVHrsDayChild   : int  NA NA NA 4 NA 5 1 NA NA NA ...
    ##  $ CompHrsDayChild : int  NA NA NA 1 NA 0 6 NA NA NA ...
    ##  $ Alcohol12PlusYr : Factor w/ 2 levels "No","Yes": 2 2 2 NA 2 NA NA 2 2 2 ...
    ##  $ AlcoholDay      : int  NA NA NA NA 2 NA NA 3 3 3 ...
    ##  $ AlcoholYear     : int  0 0 0 NA 20 NA NA 52 52 52 ...
    ##  $ SmokeNow        : Factor w/ 2 levels "No","Yes": 1 1 1 NA 2 NA NA NA NA NA ...
    ##  $ Smoke100        : Factor w/ 2 levels "No","Yes": 2 2 2 NA 2 NA NA 1 1 1 ...
    ##  $ Smoke100n       : Factor w/ 2 levels "Non-Smoker","Smoker": 2 2 2 NA 2 NA NA 1 1 1 ...
    ##  $ SmokeAge        : int  18 18 18 NA 38 NA NA NA NA NA ...
    ##  $ Marijuana       : Factor w/ 2 levels "No","Yes": 2 2 2 NA 2 NA NA 2 2 2 ...
    ##  $ AgeFirstMarij   : int  17 17 17 NA 18 NA NA 13 13 13 ...
    ##  $ RegularMarij    : Factor w/ 2 levels "No","Yes": 1 1 1 NA 1 NA NA 1 1 1 ...
    ##  $ AgeRegMarij     : int  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ HardDrugs       : Factor w/ 2 levels "No","Yes": 2 2 2 NA 2 NA NA 1 1 1 ...
    ##  $ SexEver         : Factor w/ 2 levels "No","Yes": 2 2 2 NA 2 NA NA 2 2 2 ...
    ##  $ SexAge          : int  16 16 16 NA 12 NA NA 13 13 13 ...
    ##  $ SexNumPartnLife : int  8 8 8 NA 10 NA NA 20 20 20 ...
    ##  $ SexNumPartYear  : int  1 1 1 NA 1 NA NA 0 0 0 ...
    ##  $ SameSex         : Factor w/ 2 levels "No","Yes": 1 1 1 NA 2 NA NA 2 2 2 ...
    ##  $ SexOrientation  : Factor w/ 3 levels "Bisexual","Heterosexual",..: 2 2 2 NA 2 NA NA 1 1 1 ...
    ##  $ PregnantNow     : Factor w/ 3 levels "Yes","No","Unknown": NA NA NA NA NA NA NA NA NA NA ...

    ## Rows:  10000

    ## Columns:  76

Summary of dataset.

    ##        ID           SurveyYr       Gender          Age          AgeDecade   
    ##  Min.   :51624   2009_10:5000   female:5020   Min.   : 0.00    40-49 :1398  
    ##  1st Qu.:56904   2011_12:5000   male  :4980   1st Qu.:17.00    0-9   :1391  
    ##  Median :62160                                Median :36.00    10-19 :1374  
    ##  Mean   :61945                                Mean   :36.74    20-29 :1356  
    ##  3rd Qu.:67039                                3rd Qu.:54.00    30-39 :1338  
    ##  Max.   :71915                                Max.   :80.00   (Other):2810  
    ##                                                               NA's   : 333  
    ##    AgeMonths          Race1           Race3               Education   
    ##  Min.   :  0.0   Black   :1197   Asian   : 288   8th Grade     : 451  
    ##  1st Qu.:199.0   Hispanic: 610   Black   : 589   9 - 11th Grade: 888  
    ##  Median :418.0   Mexican :1015   Hispanic: 350   High School   :1517  
    ##  Mean   :420.1   White   :6372   Mexican : 480   Some College  :2267  
    ##  3rd Qu.:624.0   Other   : 806   White   :3135   College Grad  :2098  
    ##  Max.   :959.0                   Other   : 158   NA's          :2779  
    ##  NA's   :5038                    NA's    :5000                        
    ##       MaritalStatus         HHIncome     HHIncomeMid        Poverty     
    ##  Divorced    : 707   more 99999 :2220   Min.   :  2500   Min.   :0.000  
    ##  LivePartner : 560   75000-99999:1084   1st Qu.: 30000   1st Qu.:1.240  
    ##  Married     :3945   25000-34999: 958   Median : 50000   Median :2.700  
    ##  NeverMarried:1380   35000-44999: 863   Mean   : 57206   Mean   :2.802  
    ##  Separated   : 183   45000-54999: 784   3rd Qu.: 87500   3rd Qu.:4.710  
    ##  Widowed     : 456   (Other)    :3280   Max.   :100000   Max.   :5.000  
    ##  NA's        :2769   NA's       : 811   NA's   :811      NA's   :726    
    ##    HomeRooms       HomeOwn             Work          Weight      
    ##  Min.   : 1.000   Own  :6425   Looking   : 311   Min.   :  2.80  
    ##  1st Qu.: 5.000   Rent :3287   NotWorking:2847   1st Qu.: 56.10  
    ##  Median : 6.000   Other: 225   Working   :4613   Median : 72.70  
    ##  Mean   : 6.249   NA's :  63   NA's      :2229   Mean   : 70.98  
    ##  3rd Qu.: 8.000                                  3rd Qu.: 88.90  
    ##  Max.   :13.000                                  Max.   :230.70  
    ##  NA's   :69                                      NA's   :78      
    ##      Length          HeadCirc         Height           BMI       
    ##  Min.   : 47.10   Min.   :34.20   Min.   : 83.6   Min.   :12.88  
    ##  1st Qu.: 75.70   1st Qu.:39.58   1st Qu.:156.8   1st Qu.:21.58  
    ##  Median : 87.00   Median :41.45   Median :166.0   Median :25.98  
    ##  Mean   : 85.02   Mean   :41.18   Mean   :161.9   Mean   :26.66  
    ##  3rd Qu.: 96.10   3rd Qu.:42.92   3rd Qu.:174.5   3rd Qu.:30.89  
    ##  Max.   :112.20   Max.   :45.40   Max.   :200.4   Max.   :81.25  
    ##  NA's   :9457     NA's   :9912    NA's   :353     NA's   :366    
    ##     BMICatUnder20yrs         BMI_WHO         Pulse           BPSysAve    
    ##  UnderWeight:  55    12.0_18.5   :1277   Min.   : 40.00   Min.   : 76.0  
    ##  NormWeight : 805    18.5_to_24.9:2911   1st Qu.: 64.00   1st Qu.:106.0  
    ##  OverWeight : 193    25.0_to_29.9:2664   Median : 72.00   Median :116.0  
    ##  Obese      : 221    30.0_plus   :2751   Mean   : 73.56   Mean   :118.2  
    ##  NA's       :8726    NA's        : 397   3rd Qu.: 82.00   3rd Qu.:127.0  
    ##                                          Max.   :136.00   Max.   :226.0  
    ##                                          NA's   :1437     NA's   :1449   
    ##     BPDiaAve          BPSys1          BPDia1           BPSys2     
    ##  Min.   :  0.00   Min.   : 72.0   Min.   :  0.00   Min.   : 76.0  
    ##  1st Qu.: 61.00   1st Qu.:106.0   1st Qu.: 62.00   1st Qu.:106.0  
    ##  Median : 69.00   Median :116.0   Median : 70.00   Median :116.0  
    ##  Mean   : 67.48   Mean   :119.1   Mean   : 68.28   Mean   :118.5  
    ##  3rd Qu.: 76.00   3rd Qu.:128.0   3rd Qu.: 76.00   3rd Qu.:128.0  
    ##  Max.   :116.00   Max.   :232.0   Max.   :118.00   Max.   :226.0  
    ##  NA's   :1449     NA's   :1763    NA's   :1763     NA's   :1647   
    ##      BPDia2           BPSys3          BPDia3       Testosterone    
    ##  Min.   :  0.00   Min.   : 76.0   Min.   :  0.0   Min.   :   0.25  
    ##  1st Qu.: 60.00   1st Qu.:106.0   1st Qu.: 60.0   1st Qu.:  17.70  
    ##  Median : 68.00   Median :116.0   Median : 68.0   Median :  43.82  
    ##  Mean   : 67.66   Mean   :117.9   Mean   : 67.3   Mean   : 197.90  
    ##  3rd Qu.: 76.00   3rd Qu.:126.0   3rd Qu.: 76.0   3rd Qu.: 362.41  
    ##  Max.   :118.00   Max.   :226.0   Max.   :116.0   Max.   :1795.60  
    ##  NA's   :1647     NA's   :1635    NA's   :1635    NA's   :5874     
    ##    DirectChol       TotChol         UrineVol1       UrineFlow1     
    ##  Min.   :0.390   Min.   : 1.530   Min.   :  0.0   Min.   : 0.0000  
    ##  1st Qu.:1.090   1st Qu.: 4.110   1st Qu.: 50.0   1st Qu.: 0.4030  
    ##  Median :1.290   Median : 4.780   Median : 94.0   Median : 0.6990  
    ##  Mean   :1.365   Mean   : 4.879   Mean   :118.5   Mean   : 0.9793  
    ##  3rd Qu.:1.580   3rd Qu.: 5.530   3rd Qu.:164.0   3rd Qu.: 1.2210  
    ##  Max.   :4.030   Max.   :13.650   Max.   :510.0   Max.   :17.1670  
    ##  NA's   :1526    NA's   :1526     NA's   :987     NA's   :1603     
    ##    UrineVol2       UrineFlow2     Diabetes     DiabetesAge        HealthGen   
    ##  Min.   :  0.0   Min.   : 0.000   No  :9098   Min.   : 1.00   Excellent: 878  
    ##  1st Qu.: 52.0   1st Qu.: 0.475   Yes : 760   1st Qu.:40.00   Vgood    :2508  
    ##  Median : 95.0   Median : 0.760   NA's: 142   Median :50.00   Good     :2956  
    ##  Mean   :119.7   Mean   : 1.149               Mean   :48.42   Fair     :1010  
    ##  3rd Qu.:171.8   3rd Qu.: 1.513               3rd Qu.:58.00   Poor     : 187  
    ##  Max.   :409.0   Max.   :13.692               Max.   :80.00   NA's     :2461  
    ##  NA's   :8522    NA's   :8524                 NA's   :9371                    
    ##  DaysPhysHlthBad  DaysMentHlthBad  LittleInterest   Depressed   
    ##  Min.   : 0.000   Min.   : 0.000   None   :5103   None   :5246  
    ##  1st Qu.: 0.000   1st Qu.: 0.000   Several:1130   Several:1009  
    ##  Median : 0.000   Median : 0.000   Most   : 434   Most   : 418  
    ##  Mean   : 3.335   Mean   : 4.127   NA's   :3333   NA's   :3327  
    ##  3rd Qu.: 3.000   3rd Qu.: 4.000                                
    ##  Max.   :30.000   Max.   :30.000                                
    ##  NA's   :2468     NA's   :2466                                  
    ##   nPregnancies       nBabies         Age1stBaby    SleepHrsNight   
    ##  Min.   : 1.000   Min.   : 0.000   Min.   :14.00   Min.   : 2.000  
    ##  1st Qu.: 2.000   1st Qu.: 2.000   1st Qu.:19.00   1st Qu.: 6.000  
    ##  Median : 3.000   Median : 2.000   Median :22.00   Median : 7.000  
    ##  Mean   : 3.027   Mean   : 2.457   Mean   :22.65   Mean   : 6.928  
    ##  3rd Qu.: 4.000   3rd Qu.: 3.000   3rd Qu.:26.00   3rd Qu.: 8.000  
    ##  Max.   :32.000   Max.   :12.000   Max.   :39.00   Max.   :12.000  
    ##  NA's   :7396     NA's   :7584     NA's   :8116    NA's   :2245    
    ##  SleepTrouble PhysActive  PhysActiveDays       TVHrsDay        CompHrsDay  
    ##  No  :5799    No  :3677   Min.   :1.000   2_hr     :1275   0_to_1_hr:1409  
    ##  Yes :1973    Yes :4649   1st Qu.:2.000   1_hr     : 884   0_hrs    :1073  
    ##  NA's:2228    NA's:1674   Median :3.000   3_hr     : 836   1_hr     :1030  
    ##                           Mean   :3.744   0_to_1_hr: 638   2_hr     : 589  
    ##                           3rd Qu.:5.000   More_4_hr: 615   3_hr     : 347  
    ##                           Max.   :7.000   (Other)  : 611   (Other)  : 415  
    ##                           NA's   :5337    NA's     :5141   NA's     :5137  
    ##  TVHrsDayChild   CompHrsDayChild Alcohol12PlusYr   AlcoholDay    
    ##  Min.   :0.000   Min.   :0.000   No  :1368       Min.   : 1.000  
    ##  1st Qu.:1.000   1st Qu.:0.000   Yes :5212       1st Qu.: 1.000  
    ##  Median :2.000   Median :1.000   NA's:3420       Median : 2.000  
    ##  Mean   :1.939   Mean   :2.198                   Mean   : 2.914  
    ##  3rd Qu.:3.000   3rd Qu.:6.000                   3rd Qu.: 3.000  
    ##  Max.   :6.000   Max.   :6.000                   Max.   :82.000  
    ##  NA's   :9347    NA's   :9347                    NA's   :5086    
    ##   AlcoholYear    SmokeNow    Smoke100         Smoke100n       SmokeAge    
    ##  Min.   :  0.0   No  :1745   No  :4024   Non-Smoker:4024   Min.   : 6.00  
    ##  1st Qu.:  3.0   Yes :1466   Yes :3211   Smoker    :3211   1st Qu.:15.00  
    ##  Median : 24.0   NA's:6789   NA's:2765   NA's      :2765   Median :17.00  
    ##  Mean   : 75.1                                             Mean   :17.83  
    ##  3rd Qu.:104.0                                             3rd Qu.:19.00  
    ##  Max.   :364.0                                             Max.   :72.00  
    ##  NA's   :4078                                              NA's   :6920   
    ##  Marijuana   AgeFirstMarij   RegularMarij  AgeRegMarij    HardDrugs  
    ##  No  :2049   Min.   : 1.00   No  :3575    Min.   : 5.00   No  :4700  
    ##  Yes :2892   1st Qu.:15.00   Yes :1366    1st Qu.:15.00   Yes :1065  
    ##  NA's:5059   Median :16.00   NA's:5059    Median :17.00   NA's:4235  
    ##              Mean   :17.02                Mean   :17.69              
    ##              3rd Qu.:19.00                3rd Qu.:19.00              
    ##              Max.   :48.00                Max.   :52.00              
    ##              NA's   :7109                 NA's   :8634               
    ##  SexEver         SexAge      SexNumPartnLife   SexNumPartYear   SameSex    
    ##  No  : 223   Min.   : 9.00   Min.   :   0.00   Min.   : 0.000   No  :5353  
    ##  Yes :5544   1st Qu.:15.00   1st Qu.:   2.00   1st Qu.: 1.000   Yes : 415  
    ##  NA's:4233   Median :17.00   Median :   5.00   Median : 1.000   NA's:4232  
    ##              Mean   :17.43   Mean   :  15.09   Mean   : 1.342              
    ##              3rd Qu.:19.00   3rd Qu.:  12.00   3rd Qu.: 1.000              
    ##              Max.   :50.00   Max.   :2000.00   Max.   :69.000              
    ##              NA's   :4460    NA's   :4275      NA's   :5072                
    ##       SexOrientation  PregnantNow  
    ##  Bisexual    : 119   Yes    :  72  
    ##  Heterosexual:4638   No     :1573  
    ##  Homosexual  :  85   Unknown:  51  
    ##  NA's        :5158   NA's   :8304  
    ##                                    
    ##                                    
    ## 

Looking at the head and tail of the dataset we see several NA’s
indicating we may need to run an NA removal function at some point.

``` r
head(NHANES)
```

    ## # A tibble: 6 x 76
    ##      ID SurveyYr Gender   Age AgeDecade AgeMonths Race1 Race3 Education
    ##   <int> <fct>    <fct>  <int> <fct>         <int> <fct> <fct> <fct>    
    ## 1 51624 2009_10  male      34 " 30-39"        409 White <NA>  High Sch…
    ## 2 51624 2009_10  male      34 " 30-39"        409 White <NA>  High Sch…
    ## 3 51624 2009_10  male      34 " 30-39"        409 White <NA>  High Sch…
    ## 4 51625 2009_10  male       4 " 0-9"           49 Other <NA>  <NA>     
    ## 5 51630 2009_10  female    49 " 40-49"        596 White <NA>  Some Col…
    ## 6 51638 2009_10  male       9 " 0-9"          115 White <NA>  <NA>     
    ## # … with 67 more variables: MaritalStatus <fct>, HHIncome <fct>,
    ## #   HHIncomeMid <int>, Poverty <dbl>, HomeRooms <int>, HomeOwn <fct>,
    ## #   Work <fct>, Weight <dbl>, Length <dbl>, HeadCirc <dbl>, Height <dbl>,
    ## #   BMI <dbl>, BMICatUnder20yrs <fct>, BMI_WHO <fct>, Pulse <int>,
    ## #   BPSysAve <int>, BPDiaAve <int>, BPSys1 <int>, BPDia1 <int>, BPSys2 <int>,
    ## #   BPDia2 <int>, BPSys3 <int>, BPDia3 <int>, Testosterone <dbl>,
    ## #   DirectChol <dbl>, TotChol <dbl>, UrineVol1 <int>, UrineFlow1 <dbl>,
    ## #   UrineVol2 <int>, UrineFlow2 <dbl>, Diabetes <fct>, DiabetesAge <int>,
    ## #   HealthGen <fct>, DaysPhysHlthBad <int>, DaysMentHlthBad <int>,
    ## #   LittleInterest <fct>, Depressed <fct>, nPregnancies <int>, nBabies <int>,
    ## #   Age1stBaby <int>, SleepHrsNight <int>, SleepTrouble <fct>,
    ## #   PhysActive <fct>, PhysActiveDays <int>, TVHrsDay <fct>, CompHrsDay <fct>,
    ## #   TVHrsDayChild <int>, CompHrsDayChild <int>, Alcohol12PlusYr <fct>,
    ## #   AlcoholDay <int>, AlcoholYear <int>, SmokeNow <fct>, Smoke100 <fct>,
    ## #   Smoke100n <fct>, SmokeAge <int>, Marijuana <fct>, AgeFirstMarij <int>,
    ## #   RegularMarij <fct>, AgeRegMarij <int>, HardDrugs <fct>, SexEver <fct>,
    ## #   SexAge <int>, SexNumPartnLife <int>, SexNumPartYear <int>, SameSex <fct>,
    ## #   SexOrientation <fct>, PregnantNow <fct>

``` r
tail(NHANES)
```

    ## # A tibble: 6 x 76
    ##      ID SurveyYr Gender   Age AgeDecade AgeMonths Race1 Race3 Education
    ##   <int> <fct>    <fct>  <int> <fct>         <int> <fct> <fct> <fct>    
    ## 1 71909 2011_12  male      28 " 20-29"         NA Mexi… Mexi… 9 - 11th…
    ## 2 71909 2011_12  male      28 " 20-29"         NA Mexi… Mexi… 9 - 11th…
    ## 3 71910 2011_12  female     0 " 0-9"            5 White White <NA>     
    ## 4 71911 2011_12  male      27 " 20-29"         NA Mexi… Mexi… College …
    ## 5 71915 2011_12  male      60 " 60-69"         NA White White College …
    ## 6 71915 2011_12  male      60 " 60-69"         NA White White College …
    ## # … with 67 more variables: MaritalStatus <fct>, HHIncome <fct>,
    ## #   HHIncomeMid <int>, Poverty <dbl>, HomeRooms <int>, HomeOwn <fct>,
    ## #   Work <fct>, Weight <dbl>, Length <dbl>, HeadCirc <dbl>, Height <dbl>,
    ## #   BMI <dbl>, BMICatUnder20yrs <fct>, BMI_WHO <fct>, Pulse <int>,
    ## #   BPSysAve <int>, BPDiaAve <int>, BPSys1 <int>, BPDia1 <int>, BPSys2 <int>,
    ## #   BPDia2 <int>, BPSys3 <int>, BPDia3 <int>, Testosterone <dbl>,
    ## #   DirectChol <dbl>, TotChol <dbl>, UrineVol1 <int>, UrineFlow1 <dbl>,
    ## #   UrineVol2 <int>, UrineFlow2 <dbl>, Diabetes <fct>, DiabetesAge <int>,
    ## #   HealthGen <fct>, DaysPhysHlthBad <int>, DaysMentHlthBad <int>,
    ## #   LittleInterest <fct>, Depressed <fct>, nPregnancies <int>, nBabies <int>,
    ## #   Age1stBaby <int>, SleepHrsNight <int>, SleepTrouble <fct>,
    ## #   PhysActive <fct>, PhysActiveDays <int>, TVHrsDay <fct>, CompHrsDay <fct>,
    ## #   TVHrsDayChild <int>, CompHrsDayChild <int>, Alcohol12PlusYr <fct>,
    ## #   AlcoholDay <int>, AlcoholYear <int>, SmokeNow <fct>, Smoke100 <fct>,
    ## #   Smoke100n <fct>, SmokeAge <int>, Marijuana <fct>, AgeFirstMarij <int>,
    ## #   RegularMarij <fct>, AgeRegMarij <int>, HardDrugs <fct>, SexEver <fct>,
    ## #   SexAge <int>, SexNumPartnLife <int>, SexNumPartYear <int>, SameSex <fct>,
    ## #   SexOrientation <fct>, PregnantNow <fct>

## Formulate your question

Question: Recently I came across a subreddit called r/EOOD, or exercise
out of depression. We’ve all heard of the “runners high” but can
physical activity really reduce depression?

## Validate with at least one external data source

We can calculate the number of respondents reporting some form of
depression using the Depressed variable in NHANES. Out of the
participants choosing to answer 21.4% reported some level of depression.
My cursory look into depression statistics revealed major depressive
episodes are the common mode of reporting, and that the NIH estimates
around 7% of adults have at least one major depressive episode per year.
If we say that answering “Most” to the Depressed prompt, most closely
resembles a major depressive episode we find that 6.3% of respondents
fall into that analog. Therefore, it is probably safe to say this
dataset is a fair representation.

<https://www.nimh.nih.gov/health/statistics/major-depression.shtml>

    ## Depressed

    ##    None Several    Most    NA's 
    ##    5246    1009     418    3327

    ## Depressed: 21.38468 %

    ## Depressed (Most): 6.264049 %

## Try the easy solution first

To visualize the relationship between physical activity and depression,
we can take a look at the Depressed and PhysActive variables. Both
variables are categorical so we’ll take a look at counts in a barchart.

It kind of looks like the ratio of “No” to “Yes” (Physically Active)
increases with the Depressed variable. Its tough to tell because there
is not a even distribution of counts between the levels of Depressed. To
get a better look we can use the same data to build a percent stacked
barchart. Checking that out, we can see the percentage of people that
are not physically active is greatest in the depressed most days
category, and the opposite is true for the depressed “None” days.

``` r
ggplot(NHANES_adult) +
  aes(x = Depressed, fill = PhysActive, na.rm = TRUE) + 
  geom_bar(position = "dodge") +
  theme_cowplot()
```

![](Homework03_files/figure-gfm/EZ%20comparison-1.png)<!-- -->

``` r
ggplot(NHANES_adult) +
  aes(x = Depressed, fill = PhysActive, na.rm = TRUE) + 
  geom_bar(position = "fill") +
  ylab("Percent") +
  theme_cowplot()
```

![](Homework03_files/figure-gfm/EZ%20comparison-2.png)<!-- -->

Seeing as little interest can be a symptom of depression we can do the
same visualizations for the variable LittleINterest and PhysActive.
Unsurprisingly we get very similar barcharts for these two variables as
the last.

``` r
ggplot(NHANES_adult) +
  aes(x = LittleInterest, fill = PhysActive, na.rm = TRUE) + 
  geom_bar(position = "dodge") +
  theme_cowplot()
```

![](Homework03_files/figure-gfm/EZ%20comparison%20pt.%202-1.png)<!-- -->

``` r
ggplot(NHANES_adult) +
  aes(x = LittleInterest, fill = PhysActive, na.rm = TRUE) + 
  geom_bar(position = "fill") +
  ylab("Percent") +
  theme_cowplot()
```

![](Homework03_files/figure-gfm/EZ%20comparison%20pt.%202-2.png)<!-- -->

We run a chi squared test on the two variables to confirm our thoughts
about the relationship between being physically active. We get a
significant p-value (p = 1.787e-09) which means it is safe to reject the
null hypothesis that there is no relationship between the variables of
interest. We can actually look at the contribution of each cell in the
table by checking out the Pearson residual for each. From that
calculation we can see that the combination of Physically Active: No and
Depressed: Most days contributed the most to the chi squared (r =
3.605).

<http://www.sthda.com/english/wiki/chi-square-test-of-independence-in-r>
<https://stackoverflow.com/questions/48918408/how-to-add-label-in-table-in-r>

    ##                  Depressed (days)
    ## Physically Active None Several Most
    ##               No   997     225  115
    ##               Yes 1310     197   64

    ## 
    ##  Pearson's Chi-squared test
    ## 
    ## data:  PhysActivity_Depression
    ## X-squared = 40.286, df = 2, p-value = 1.787e-09

    ##                  Depressed (days)
    ## Physically Active   None Several   Most
    ##               No  -1.955   2.224  3.605
    ##               Yes  1.804  -2.052 -3.325

## Challenge your solution

I had a little difficulty mustering up the creative juices to challenge
my solution creatively so I decided to just copy the method used in the
Exploratory Data Analysis book. Even so, I understand why this step is
an important one in the data analysis process, since we took “the easy
way out” earlier. To challenge the solution, I employed the bootstrap
method which randomly alters the dataset in a way that it is for the
most part the same but slightly different. The same statistical analysis
was then used to analyze the “new” dataset.

After bootstrapping, there is still a significant p-value (p =
6.565e-09) which is still statistically significant. Furthermore, the
Pearson residuals for several variable combinations decreased indicating
that they had less contribution to the overall chi squared value.
Regardless, the Pearson residual for the combination of Physically
Active: No and Depressed: Most days contributed the most to the chi
squared (r = 3.326).

    ##                  Depressed (days)
    ## Physically Active None Several Most
    ##               No  1013     227  125
    ##               Yes 1281     189   73

    ## 
    ##  Pearson's Chi-squared test
    ## 
    ## data:  PhysActivity_Depression2
    ## X-squared = 37.683, df = 2, p-value = 6.565e-09

    ##                  Depressed (days)
    ## Physically Active   None Several   Most
    ##               No  -1.944   2.271  3.326
    ##               Yes  1.828  -2.136 -3.128

## Follow up

To follow up on these findings, I’d argue that the variables selected to
answer the intial question could have been better. I think
PhysActiveDays would have been a stronger representation of exercise
since whether or not a person is physically active can be subjective. I
don’t believe looking at how these results could change after several
years is necessary but could be interesting.

# Analytic Graphics

I have no idea what analytical graphics to use but here are some that
the page on chi squared I refrenced earlier used. These graphics show a
contingency table for the variables PhysActive and Depressed. It’s cool
because the size of the circle correlates to the number of instances in
the dataset. The second shows the scale of the Pearson residuals from
chi squared with the size and color of the circles correlating to
magnitude of the individual residuals. The default color for the text
labels is actually red and it took me a while to figure out that I had
to change it to black lol (why is the default red???).

``` r
# Visualize contingency table
balloonplot(t(PhysActivity_Depression),
    main ="Physical Activity~Depression", xlab ="Depressed (days)", ylab="PhysActive", label.size = 0.75,
    label = TRUE, show.margins = FALSE)
```

![](Homework03_files/figure-gfm/Analytical%20analysis%20using%20graphical%20graphics-1.png)<!-- -->

``` r
# Visualize Pearson residuals
corrplot(tl.col = "black", chisq$residuals, is.cor = FALSE)
```

![](Homework03_files/figure-gfm/Analytical%20analysis%20using%20graphical%20graphics-2.png)<!-- -->

## Show comparisons

There isn’t a whole lot we can do comparison-wise since the variables I
chose cover both ends of the spectrum. Had a chose perhaps
PhysAcitveDays which measures the number of days in a week that a
respondent is physically active, I could have used PhysActive: No as the
comparison.

## Show causality, mechanism, explanation, systematic structure

Low testosterone can be a contributer to the onset or worsening of
depression in both males and females. Furthermore, exercise can result
in increased testosterone. Luckily, testosterone levels were measured in
this dataset and can be used to establish causality.

Of course after running the code I realized that the researchers did not
get testosterone levels for female participants…

The boxplot shows, the medians and distributions of testosterone level
for both PhysActive categories are approximately the same with
PhysActive: Yes having a slightly higher median. However the median
testosterone value for Depressed: None is greater than that of both
Depressed: Several and Most which supports the proposed causality
between testosterone and depression. Since the median and IQR of of
testosterone level by PhysActive does not show much meaningful
information we can check the means as well.

``` r
NHANES_adult_male <- dplyr::filter(NHANES_adult, (Gender == "Male"))
NHANES_adult_female <- dplyr::filter(NHANES_adult, (Gender == "Female"))

ggplot(NHANES_adult_male) + 
  aes(x = PhysActive, y = (Testosterone)) +
  geom_boxplot(outlier.shape = NA) +
  geom_point(alpha = 0.3, position = "jitter", colour = "blue") +
  guides(alpha=FALSE) +
  xlab("PhysActive") + 
  ylab("Testosterone level") +
  theme_cowplot()
```

![](Homework03_files/figure-gfm/Boxplots%20for%20testosterone-1.png)<!-- -->

``` r
ggplot(NHANES_adult_male) + 
  aes(x = Depressed, y = (Testosterone)) +
  geom_boxplot(outlier.shape = NA) +
  geom_point(alpha = 0.3, position = "jitter", colour = "blue") +
  guides(alpha=FALSE) +
  xlab("Depressed") + 
  ylab("Testosterone level") +
  theme_cowplot()
```

![](Homework03_files/figure-gfm/Boxplots%20for%20testosterone-2.png)<!-- -->

``` r
#Female shows nothing
ggplot(NHANES_adult_female) + 
  aes(x = PhysActive, y = (Testosterone)) +
  geom_boxplot(outlier.shape = NA) +
  geom_point(alpha = 0.3, position = "jitter", colour = "red") +
  guides(alpha=FALSE) +
  xlab("Depressed") + 
  ylab("Testosterone level") +
  theme_cowplot()
```

![](Homework03_files/figure-gfm/Boxplots%20for%20testosterone-3.png)<!-- -->

When checking out the plotted means, a relatively small difference
between PhysActive categories becomes apparent. That being said the 95%
confidence interval does overlap a little bit It’s difficult to predict
what a t-test might yield for these variables. Taking a look at the
plotted means for testosterone level and Depressed suggests testosterone
level decreases the more often a person is depressed. Once again there
is overlap in the 95% confidence intervals so a statistical test could
help clear things up.

``` r
plotmeans((Testosterone) ~ PhysActive, data = NHANES_adult, xlab = "PhysActive", ylab = "Testosterone level")
```

![](Homework03_files/figure-gfm/Means:%20Testosterone%20~%20PhysActive,%20Testosterone%20~%20Depressed-1.png)<!-- -->

``` r
plotmeans((Testosterone) ~ Depressed, data = NHANES_adult, xlab = "Depressed", ylab = "Testosterone level")
```

![](Homework03_files/figure-gfm/Means:%20Testosterone%20~%20PhysActive,%20Testosterone%20~%20Depressed-2.png)<!-- -->

Since the testosterone data can only add meaningful information to our
narrative for males, I think it’s best to find another variable in the
dataset that will encompass both males and females. Not getting enough
sleep/having troubled sleep can also result in depression regardless of
gender. Furthermore, according to myself, physical activity can really
help with establishing and maintaining a healthy sleeping pattern.
Therefore, we may be able to draw some measure of causality from the
sleep length/qualitymeasurements included in this dataset.

Analyzing the boxplots there does not appear to be an immediate
difference in the distribution of hours slept with regard to how
individuals answered PhysActive. The boxplot for Depressed and hours
slept shows relatively similar distributions between categories of
Depressed. Notably Depressed: Most has a lower median and upper/lower
quartiles than the other categories of Depressed.

``` r
NHANES_adult <- drop_na(NHANES_adult, SleepHrsNight)

ggplot(NHANES_adult) + 
  aes(x = PhysActive, y = SleepHrsNight) +
  geom_boxplot(outlier.shape = NA) +
  geom_point(alpha = 0.3, position = "jitter", colour = "blue") +
  guides(alpha=FALSE) +
  xlab("PhysActive") + 
  ylab("Hourse slept") +
  theme_cowplot()
```

![](Homework03_files/figure-gfm/Boxplots%20for%20hours%20slept-1.png)<!-- -->

``` r
ggplot(NHANES_adult) + 
  aes(x = Depressed, y = SleepHrsNight) +
  geom_boxplot(outlier.shape = NA) +
  geom_point(alpha = 0.3, position = "jitter", colour = "blue") +
  guides(alpha=FALSE) +
  xlab("Depressed") + 
  ylab("Hours slept") +
  theme_cowplot()
```

![](Homework03_files/figure-gfm/Boxplots%20for%20hours%20slept-2.png)<!-- -->

Since the median and IQR for PhysActive and hours slept did not yield
much meaningful information we can take a look at the plotted means of
these variables. In this case there is a obvious difference between the
mean hours slept for the two responses to PhysActive. Furthermore the
95% confidence intervals do not overlap and so we could expect a
statistically significant difference between the two populations after
performing a t-test. Taking a look at the second graphic which looks at
hours slept and the Depressed variable, we see a general decrease in the
mean hours slept as the Depressed variable “increases”. Confidence
intervals for this plot are also pretty good so statistical analysis
should fit the narrative.

``` r
plotmeans(SleepHrsNight ~ PhysActive, data = NHANES_adult, xlab = "PhysActive", ylab = "Hours slept")
```

![](Homework03_files/figure-gfm/Means:%20SleepHrsNight%20~%20PhysActive,%20SleepHrsNight%20~%20Depressed-1.png)<!-- -->

``` r
plotmeans(SleepHrsNight ~ Depressed, data = NHANES_adult, xlab = "Depressed", ylab = "Hours slept")
```

![](Homework03_files/figure-gfm/Means:%20SleepHrsNight%20~%20PhysActive,%20SleepHrsNight%20~%20Depressed-2.png)<!-- -->

Well I guess we should do a t-test or two. The t-test for testosterone
level did return significantly different populations (p = 0.04514).
Performing the test on hours slept with respect to PhysActive response
returned a significant likliehood of independent populations (p =
8.33e-06).

    ## Testosterone level ~ PhysActive

    ## 
    ##  Two Sample t-test
    ## 
    ## data:  NHANES_adult$Testosterone by NHANES_adult$PhysActive
    ## t = -2.0042, df = 2906, p-value = 0.04514
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  -34.2058375  -0.3744968
    ## sample estimates:
    ##  mean in group No mean in group Yes 
    ##          211.4262          228.7164

    ## SleepHrsNight ~ PhysActive

    ## 
    ##  Two Sample t-test
    ## 
    ## data:  NHANES_adult$SleepHrsNight by NHANES_adult$PhysActive
    ## t = -4.4645, df = 2906, p-value = 8.33e-06
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  -0.3105863 -0.1210260
    ## sample estimates:
    ##  mean in group No mean in group Yes 
    ##          6.743455          6.959262
