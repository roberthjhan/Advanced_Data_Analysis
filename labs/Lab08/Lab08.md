Lab 08/Homework 6
================
Robert Han
23 Mar 2020

## Loading Libraries

## Objectives for Lab 8 and HW 6

1.  Introduction to RNA-Seq
2.  Become familiar with NGS file formats
3.  Using Galaxy on BisonNet
4.  Quality control of fastq files

**This .Rmd file will be turned in before lab next week as Homework 6**

## Background

We will be using the dataset the following paper:
<https://genome.cshlp.org/content/21/2/193.full>

The paper is also available in the Readings directory of the class repo.

The Dataset is from Deep Sequencing of Poly(A)+ RNA from the Drosophila
melanogaster S2-DRSC cells that have been RNAi depleted of mRNAs
encoding RNA binding proteins.

For the tutorial, you will need use the following files in Galaxy:
(Search them in ncbi sra site) Untreated: SRR031711, SRR031714,
SRR031716 RNAi: SRR031718, SRR031724, SRR031726

These files were obtained from the NCBI’s Sequence Read Archive:
<https://www.ncbi.nlm.nih.gov/sra> Look up each of the Run Accession
numbers and record the needed information below.

The number of reads is listed as “\# of Spots”.

``` r
s_names <- c("SRR031711", "SRR031714", "SRR031716", "SRR031718", "SRR031724", "SRR031726")
s_long_names <- c("S2_DRSC_Untreated-1", "S2_DRSC_Untreated-3", "S2_DRSC_Untreated-4", "S2_DRSC_CG8144_RNAi-1", "S2_DRSC_CG8144_RNAi-3", "S2_DRSC_CG8144_RNAi-4")
s_layout <- c("SINGLE", "PAIRED", "PAIRED", "SINGLE", "PAIRED", "PAIRED")
s_reads <- c(6064911, 5327425, 5921707, 6724171, 5962418, 6372581)
s_bases <- c(272.9*10^6, 394.2*10^6, 438.2*10^6, 302.6*10^6, 441.2*10^6, 471.6*10^6)

SRAsummary <- data.frame(SampleName=character(),
                         LongName=character(),
                         Layout=character(),
                         Reads=double(),
                         Bases=double(),
                         stringsAsFactors=FALSE) # This updated code fixed the problem with the original Rmd

for (i in 1:length(s_names)){
  SRAsummary %>% 
  add_row(
    SampleName = s_names[i], 
    LongName = s_long_names[i], 
    Layout = s_layout[i],                         # or "PAIRED"
    Reads = s_reads[i], 
    Bases = s_bases[i]) -> SRAsummary
} 
```

Calculate how long each read is expected to be:

``` r
SRAsummary %>%
  mutate(ReadLength = round(Bases / (Reads * (1 + (Layout == "PAIRED"))))) -> SRAsummary
print(SRAsummary)
```

    ##   SampleName              LongName Layout   Reads     Bases ReadLength
    ## 1  SRR031711   S2_DRSC_Untreated-1 SINGLE 6064911 272900000         45
    ## 2  SRR031714   S2_DRSC_Untreated-3 PAIRED 5327425 394200000         37
    ## 3  SRR031716   S2_DRSC_Untreated-4 PAIRED 5921707 438200000         37
    ## 4  SRR031718 S2_DRSC_CG8144_RNAi-1 SINGLE 6724171 302600000         45
    ## 5  SRR031724 S2_DRSC_CG8144_RNAi-3 PAIRED 5962418 441200000         37
    ## 6  SRR031726 S2_DRSC_CG8144_RNAi-4 PAIRED 6372581 471600000         37

``` r
write_csv(SRAsummary, path = "SRAsummary.csv")
```

## Study Design

Review the material at <https://rnaseq.uoregon.edu/>, in the paper, and
in the SRA to answer the following questions:

1.  What are the biological conditions that we are going to compare?

A comparison of splicing regulators between the fruit flies and humans
ps-repressed/activated exons.

2.  How many biological replicates are we studying for each condition?

Treated (PS targeted): biological quadruplicate Untreated: biological
triplicate

3.  What sequencing platform was used?

Illumina

4.  What selection scheme (if any) was performed on the RNA?

Size selection

5.  What was the depth of sequencing for each condition (min, max, and
    mean)?

Read lengths between 37 and 45

6.  What library prep protocol used? If a stranded library prep was
    used, what is the strandedness of the reads?

Illumina mRNA-seq prep kit

7.  Were the sequences single-end or paired end?

Both single-ended and pair ended

8.  What is the length of the reads?

37 nt

## Next Generation Sequencing Files

The first type of file that we will examine is a fastq file. The “q” is
for quality scores. It is a sequence file (usually DNA) that includes a
quality score for every base. Fastq files are flat text files, but they
are often found gzipped to save space, with the extension .fastq.gz or
.fq.gz

To look at fastq files in R, we will use the ShortRead package:
<https://kasperdanielhansen.github.io/genbioconductor/html/ShortRead.html>

``` r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ShortRead")
```

    ## Bioconductor version 3.10 (BiocManager 1.30.10), R 3.6.3 (2020-02-29)

    ## Installing package(s) 'ShortRead'

    ## 
    ## The downloaded binary packages are in
    ##  /var/folders/z3/6m48xn815sddgbt9fmsg33j80000gn/T//Rtmp1ums2X/downloaded_packages

    ## Old packages: 'backports', 'biomaRt', 'class', 'foreign', 'fs', 'glue',
    ##   'lattice', 'nlme', 'nnet', 'plotly', 'quantreg', 'survival', 'vcd'

``` r
library(ShortRead)
```

    ## Loading required package: BiocGenerics

    ## Loading required package: parallel

    ## 
    ## Attaching package: 'BiocGenerics'

    ## The following objects are masked from 'package:parallel':
    ## 
    ##     clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
    ##     clusterExport, clusterMap, parApply, parCapply, parLapply,
    ##     parLapplyLB, parRapply, parSapply, parSapplyLB

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     combine, intersect, setdiff, union

    ## The following objects are masked from 'package:stats':
    ## 
    ##     IQR, mad, sd, var, xtabs

    ## The following objects are masked from 'package:base':
    ## 
    ##     anyDuplicated, append, as.data.frame, basename, cbind, colnames,
    ##     dirname, do.call, duplicated, eval, evalq, Filter, Find, get, grep,
    ##     grepl, intersect, is.unsorted, lapply, Map, mapply, match, mget,
    ##     order, paste, pmax, pmax.int, pmin, pmin.int, Position, rank,
    ##     rbind, Reduce, rownames, sapply, setdiff, sort, table, tapply,
    ##     union, unique, unsplit, which, which.max, which.min

    ## Loading required package: BiocParallel

    ## Loading required package: Biostrings

    ## Loading required package: S4Vectors

    ## Loading required package: stats4

    ## 
    ## Attaching package: 'S4Vectors'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     first, rename

    ## The following object is masked from 'package:tidyr':
    ## 
    ##     expand

    ## The following object is masked from 'package:base':
    ## 
    ##     expand.grid

    ## Loading required package: IRanges

    ## 
    ## Attaching package: 'IRanges'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     collapse, desc, slice

    ## The following object is masked from 'package:purrr':
    ## 
    ##     reduce

    ## Loading required package: XVector

    ## 
    ## Attaching package: 'XVector'

    ## The following object is masked from 'package:purrr':
    ## 
    ##     compact

    ## 
    ## Attaching package: 'Biostrings'

    ## The following object is masked from 'package:base':
    ## 
    ##     strsplit

    ## Loading required package: Rsamtools

    ## Loading required package: GenomeInfoDb

    ## Loading required package: GenomicRanges

    ## Loading required package: GenomicAlignments

    ## Loading required package: SummarizedExperiment

    ## Loading required package: Biobase

    ## Welcome to Bioconductor
    ## 
    ##     Vignettes contain introductory material; view with
    ##     'browseVignettes()'. To cite Bioconductor, see
    ##     'citation("Biobase")', and for packages 'citation("pkgname")'.

    ## Loading required package: DelayedArray

    ## Loading required package: matrixStats

    ## 
    ## Attaching package: 'matrixStats'

    ## The following objects are masked from 'package:Biobase':
    ## 
    ##     anyMissing, rowMedians

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     count

    ## 
    ## Attaching package: 'DelayedArray'

    ## The following objects are masked from 'package:matrixStats':
    ## 
    ##     colMaxs, colMins, colRanges, rowMaxs, rowMins, rowRanges

    ## The following object is masked from 'package:purrr':
    ## 
    ##     simplify

    ## The following objects are masked from 'package:base':
    ## 
    ##     aperm, apply, rowsum

    ## 
    ## Attaching package: 'GenomicAlignments'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     last

    ## 
    ## Attaching package: 'ShortRead'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     id

    ## The following object is masked from 'package:purrr':
    ## 
    ##     compose

    ## The following object is masked from 'package:tibble':
    ## 
    ##     view

The ShortRead package was one of the first Bioconductor packages to deal
with low-level analysis of high-throughput sequencing data. Some of its
functionality has now been superseded by other packages, but there is
still relevant functionality left.

Reading FASTQ files The FASTQ file format is the standard way of
representing raw (unaligned) next generation sequencing reads,
particular for the Illumina platform. The format basically consists of 4
lines per read, with the lines containing

1.  Read name (sometimes includes flowcell ID or other information).
2.  Read nucleotides
3.  Either empty or a repeat of line 1
4.  Encoded read quality scores

Paired-end reads are (usually) stored in two separate files, where the
reads are ordered the same (this is obviously fragile; what if reads are
re-ordered in one file and not the other).

These files are read by `readFastq()` which produces an object of class
`ShortReadQ`.

``` r
list.files()
```

    ## [1] "Lab08.Rmd"                 "SRAsummary.csv"           
    ## [3] "SRR031714_1.head400.fastq" "SRR031714_2.head400.fastq"

``` r
read_1 <- readFastq("SRR031714_1.head400.fastq")
read_2 <- readFastq("SRR031714_2.head400.fastq")
```

The ShortReadQ class has an id and two sets of strings: one for the read
nucleotides and one for the base qualities. We can check these strings
for the first ten reads and also that the ids match between read\_1 and
read\_2.

``` r
id(read_1)[1:10]
```

    ##   A BStringSet instance of length 10
    ##      width seq
    ##  [1]    47 SRR031714.1 HWI-EAS299_130MNEAAXX:2:1:785:591/1
    ##  [2]    48 SRR031714.2 HWI-EAS299_130MNEAAXX:2:1:1703:586/1
    ##  [3]    48 SRR031714.3 HWI-EAS299_130MNEAAXX:2:1:1788:543/1
    ##  [4]    48 SRR031714.4 HWI-EAS299_130MNEAAXX:2:1:1729:593/1
    ##  [5]    49 SRR031714.5 HWI-EAS299_130MNEAAXX:2:1:1247:1030/1
    ##  [6]    48 SRR031714.6 HWI-EAS299_130MNEAAXX:2:1:1747:596/1
    ##  [7]    48 SRR031714.7 HWI-EAS299_130MNEAAXX:2:1:1588:584/1
    ##  [8]    48 SRR031714.8 HWI-EAS299_130MNEAAXX:2:1:1758:603/1
    ##  [9]    48 SRR031714.9 HWI-EAS299_130MNEAAXX:2:1:1744:583/1
    ## [10]    49 SRR031714.10 HWI-EAS299_130MNEAAXX:2:1:1738:523/1

``` r
sread(read_1)[1:10]
```

    ##   A DNAStringSet instance of length 10
    ##      width seq
    ##  [1]    37 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    ##  [2]    37 GTAATTTTTTTGGAGAGTTCATATCGATAAAAAAGAT
    ##  [3]    37 GTTTGTGAAAAATAGATTGCTGGATCAAGAAATTAAA
    ##  [4]    37 GCCGGGAAGAGGATACGTCCGTCGATCGTGTGTCCAG
    ##  [5]    37 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    ##  [6]    37 GTGTAAGGCACTAAAGTATATCTCCTTTTAACATCTC
    ##  [7]    37 GGAGTTCCCCCCTCTGGGTCGCTTCGCTGCGCGTGAC
    ##  [8]    37 GTGATATTAAACGTGATATGAGCGAAAACAAGTCGAA
    ##  [9]    37 GCGGTAATGTATAGGTATACAACTTAAGCGCCATCCA
    ## [10]    37 GCAGAGTGGATTACGTAATTTCGCTCTACCAAACAAA

``` r
quality(read_1)[1:10]
```

    ## class: FastqQuality
    ## quality:
    ##   A BStringSet instance of length 10
    ##      width seq
    ##  [1]    37 IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
    ##  [2]    37 IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIB
    ##  [3]    37 IIIIIIIIIIIIIIIIIIII'IIIIIIIIIIIIIIII
    ##  [4]    37 IIIIIIIIIIIIIIIIIIIIIEIII$II(I8I;II63
    ##  [5]    37 IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
    ##  [6]    37 IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
    ##  [7]    37 IIIIIIIIIIIIIIIIII$IIII3III64&III>I;I
    ##  [8]    37 IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIH<
    ##  [9]    37 IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII9
    ## [10]    37 IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIDI

``` r
# Check that ids match
id(read_2)[1:10]
```

    ##   A BStringSet instance of length 10
    ##      width seq
    ##  [1]    47 SRR031714.1 HWI-EAS299_130MNEAAXX:2:1:785:591/2
    ##  [2]    48 SRR031714.2 HWI-EAS299_130MNEAAXX:2:1:1703:586/2
    ##  [3]    48 SRR031714.3 HWI-EAS299_130MNEAAXX:2:1:1788:543/2
    ##  [4]    48 SRR031714.4 HWI-EAS299_130MNEAAXX:2:1:1729:593/2
    ##  [5]    49 SRR031714.5 HWI-EAS299_130MNEAAXX:2:1:1247:1030/2
    ##  [6]    48 SRR031714.6 HWI-EAS299_130MNEAAXX:2:1:1747:596/2
    ##  [7]    48 SRR031714.7 HWI-EAS299_130MNEAAXX:2:1:1588:584/2
    ##  [8]    48 SRR031714.8 HWI-EAS299_130MNEAAXX:2:1:1758:603/2
    ##  [9]    48 SRR031714.9 HWI-EAS299_130MNEAAXX:2:1:1744:583/2
    ## [10]    49 SRR031714.10 HWI-EAS299_130MNEAAXX:2:1:1738:523/2

``` r
# The end of each id is different for read 1 and read 2 (as expected).
# To remove this we can use gsub and then check that the read names match
?gsub
sum(gsub("/1", "", id(read_1)) == gsub("/2", "", id(read_2)))
```

    ## [1] 100

``` r
sum(gsub("/1", "", id(read_1)) != gsub("/2", "", id(read_2)))
```

    ## [1] 0

Note how the quality scores are listed as characters. You can convert
them into standard 0-40 integer quality scores by

``` r
as(quality(read_1), "matrix")[1:10,1:37]
```

    ##       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12] [,13]
    ##  [1,]   40   40   40   40   40   40   40   40   40    40    40    40    40
    ##  [2,]   40   40   40   40   40   40   40   40   40    40    40    40    40
    ##  [3,]   40   40   40   40   40   40   40   40   40    40    40    40    40
    ##  [4,]   40   40   40   40   40   40   40   40   40    40    40    40    40
    ##  [5,]   40   40   40   40   40   40   40   40   40    40    40    40    40
    ##  [6,]   40   40   40   40   40   40   40   40   40    40    40    40    40
    ##  [7,]   40   40   40   40   40   40   40   40   40    40    40    40    40
    ##  [8,]   40   40   40   40   40   40   40   40   40    40    40    40    40
    ##  [9,]   40   40   40   40   40   40   40   40   40    40    40    40    40
    ## [10,]   40   40   40   40   40   40   40   40   40    40    40    40    40
    ##       [,14] [,15] [,16] [,17] [,18] [,19] [,20] [,21] [,22] [,23] [,24] [,25]
    ##  [1,]    40    40    40    40    40    40    40    40    40    40    40    40
    ##  [2,]    40    40    40    40    40    40    40    40    40    40    40    40
    ##  [3,]    40    40    40    40    40    40    40     6    40    40    40    40
    ##  [4,]    40    40    40    40    40    40    40    40    36    40    40    40
    ##  [5,]    40    40    40    40    40    40    40    40    40    40    40    40
    ##  [6,]    40    40    40    40    40    40    40    40    40    40    40    40
    ##  [7,]    40    40    40    40    40     3    40    40    40    40    18    40
    ##  [8,]    40    40    40    40    40    40    40    40    40    40    40    40
    ##  [9,]    40    40    40    40    40    40    40    40    40    40    40    40
    ## [10,]    40    40    40    40    40    40    40    40    40    40    40    40
    ##       [,26] [,27] [,28] [,29] [,30] [,31] [,32] [,33] [,34] [,35] [,36] [,37]
    ##  [1,]    40    40    40    40    40    40    40    40    40    40    40    40
    ##  [2,]    40    40    40    40    40    40    40    40    40    40    40    33
    ##  [3,]    40    40    40    40    40    40    40    40    40    40    40    40
    ##  [4,]     3    40    40     7    40    23    40    26    40    40    21    18
    ##  [5,]    40    40    40    40    40    40    40    40    40    40    40    40
    ##  [6,]    40    40    40    40    40    40    40    40    40    40    40    40
    ##  [7,]    40    40    21    19     5    40    40    40    29    40    26    40
    ##  [8,]    40    40    40    40    40    40    40    40    40    40    39    27
    ##  [9,]    40    40    40    40    40    40    40    40    40    40    40    24
    ## [10,]    40    40    40    40    40    40    40    40    40    40    35    40

In this conversion, each letter is matched to an integer between 0 and
40. This matching is known as the “encoding” of the quality scores and
there has been different ways to do this encoding. Unfortunately, it is
not stored in the FASTQ file which encoding is used, so you have to know
or guess the encoding. The ShortRead package does this for you.

These numbers are related to the probability that the reported base is
different from the template fragment (ie. a sequence error).

# Galaxy\!

Log in at <http://galaxy.bucknell.edu>

You must be on campus or connected to the VPN to access Galaxy on
BisonNet.

Take the interactive tours on the `Galaxy UI` and the `History`.

## Moving shared data into your history

Click on the `Shared Data > Data Libraries` tab.

Click the Pasilla Datset. Select all of the files and then `To History >
as Datasets`.

Click `Analyze Data` and verify that the 10 data files have been moved
to the History.

Click the eye icon next to each to verify that the files look like they
are in the proper fastq format and that the reads are the expected
length:  
<https://support.illumina.com/bulletins/2016/04/fastq-files-explained.html>

## Running FastQC

In the Tools section, type FastQC in the search box and then click the
matching tool.

Run FastQC on one of the files and then wait for it to complete.

View the results by clicking on the eye icon for the Webpage output.

Run FastQC on each of the fastq files.

When all of the jobs are complete (this may take a little while), run
the MultiQC tool to aggregate all of the FastQC results into a single
report. In MultiQC, first change the input type from Bamtools to FastQC.
To select multiple files as input, use command-click (Mac) or ctrl-click
(PC).

After MultiQC is run, compare the samples to determine if there are any
large differences in quality problems between them.

You may want to download the MultiQC webpage, unzip it, and open the
html file in a browser so that you can view it without logging in to
Galaxy. Download a file from Galaxy by clicking on it in the History
area and then clicking the disk icon.

## QC Summary

<http://www.bioinformatics.babraham.ac.uk/projects/fastqc/>

Review the examples of “Good” and “Bad” Illumina data and summarize your
impressions of this dataset.

## Trimmomatic

<http://www.usadellab.org/cms/index.php?page=trimmomatic>

To try to improve the quality of this dataset, we will use trimmomatic.
Trimmomatic performs a variety of useful trimming tasks for illumina
paired-end and single ended data.

Use Galaxy to run trimmomatic on each of the files, paying close
attention to the PAIRED files and processing them as `two separate input
files`.

Use the following trimmomatic parameters
(<http://journal.frontiersin.org/article/10.3389/fgene.2014.00013/full>):

1.  “Perform initial ILLUMINACLIP step?” should be changed to Yes and
    the settings changed to TruSeq2 (single or paired, as appropriate)
    and 2:40:15:8. Note that the adapter sequences to be used should
    match the sequencing technology used to obtain the reads. According
    to the SRA metadata, these files were obtained using a Genome
    Analyzer II (GAII) and so TruSeq2 is the correct primer file.

2.  “SLIDINGWINDOW” should be changed to “Average quality required” = 5

3.  Then “Insert trimmomatic operation” and set it to “MINLEN” = 25

Run trimmomatic on each set of files (a total of 6 times).

For the paired files, trimmomatic will produce 4 output files: R1
Paired, R2 Paired, R1 Unpaired, and R2 Unpaired. The unpaired files
contain reads that were orphaned when their mate was discarded due to
the trimming settings. They can be used in some analyses, but we will
not be needing them, so it is best to delet them at this point so they
don’t confuse us later.

## FastQC and MultiQC

Now run FastQC and MultiQC on the trimmed data. Has it improved? Is it
“good” yet?

1.  How many reads were removed from each file during the trimming step?

Total sequences removed (in millions): RNAi-1: 0.1 RNAi-3: 1 RNAi-4: 0.1
Untreated-1: 0.1 Untreated-3: 0.1 Untreated-4: 0.8

2.  What are the read lengths of each file after trimming (min, max,
    mean)?

Sample Name % Dups % GC Length M Seqs S2\_DRSC\_CG8144\_RNAi-1 28.7% 49%
44 bp 35.2 S2\_DRSC\_CG8144\_RNAi-3\_R1 46.2% 54% 37 bp 12.3
S2\_DRSC\_CG8144\_RNAi-3\_R2 0.2% 55% 37 bp 12.3
S2\_DRSC\_CG8144\_RNAi-4\_R1 50.7% 55% 37 bp 12.5
S2\_DRSC\_CG8144\_RNAi-4\_R2 48.0% 55% 37 bp 12.5 S2\_DRSC\_Untreated-1
2.8% 51% 45 bp 34.3 S2\_DRSC\_Untreated-3\_R1 45.3% 53% 37 bp 10.6
S2\_DRSC\_Untreated-3\_R2 32.5% 53% 37 bp 10.6 S2\_DRSC\_Untreated-4\_R1
47.4% 54% 37 bp 12.2 S2\_DRSC\_Untreated-4\_R2 37.3% 55% 37 bp 12.2

Sample Name % Dups % GC Length M Seqs Trimmomatic on
S2\_DRSC\_CG8144\_RNAi-3\_R1 \_R1 paired 38.6% 54% 35 bp 6.7 Trimmomatic
on S2\_DRSC\_CG8144\_RNAi-3\_R2 \_R2 paired 22.2% 54% 33 bp 6.7
Trimmomatic on S2\_DRSC\_CG8144\_RNAi-4\_R1 \_R1 paired 46.5% 54% 36 bp
11.5 Trimmomatic on S2\_DRSC\_CG8144\_RNAi-4\_R2 \_R2 paired 39.6% 54%
35 bp 11.5 Trimmomatic on S2\_DRSC\_Untreated-3\_R1 \_R1 paired 39.8%
53% 36 bp 9.7 Trimmomatic on S2\_DRSC\_Untreated-3\_R2 \_R2 paired 44.2%
53% 36 bp 9.7 Trimmomatic on S2\_DRSC\_Untreated-4\_R1 \_R1 paired 39.5%
53% 36 bp 7.1 Trimmomatic on S2\_DRSC\_Untreated-4\_R2 \_R2 paired 29.3%
53% 33 bp 7.1

3.  After trimming, how do the quality of the single-end reads compare
    to the paired-end reads (within each treatment group)?

Phred scores improve.

4.  After trimming, how do the quality of the RNAi treated reads compare
    to the control reads (within each sequencing layout type)?

After trimming the sequence quality appears to improve Phred scores for
the paired end reads are in the green area for all base positions in the
read whereas the

5.  Do you anticipate any problems using this data to compare
    differential transcript expression between the two treatment groups?

I think that after trimming the quality of the data has improved to a
point where we should not expect blaring problems when comparing the
transcript expressions.

## Helpful RNA-Seq Links

RNA-seqlopedia: <https://rnaseq.uoregon.edu/>

RNA-Seq Blog: <http://www.rna-seqblog.com/>

QCFAIL Blog: <https://sequencing.qcfail.com/> (Unfortunately it looks
like they are no longer posting, but they have some great posts about
problems with certain Illumina sequencers.)

QCFAIL post about SRA file corruption:
<https://sequencing.qcfail.com/articles/data-can-be-corrupted-upon-extraction-from-sra-files/>
(This is why it is so important to look at the raw fastq files and check
the lengths of the reads before trimming.)
