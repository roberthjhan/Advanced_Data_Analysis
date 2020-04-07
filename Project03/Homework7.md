Homework 7
================
Robert Han
1 Apr 2020

## Loading Libraries

## Prerequisites for Homework 7

1.  Completion of the [Galaxy](1-Galaxy.md) and
    [SARTools](2-SARTools.md) tutorials.
2.  Results from either EdgeR and DESeq2 analysis of differential
    **gene** expression of the Pasilla dataset (after batch effect
    correction)
3.  Results from the EdgeR and DESeq2 analysis of differential
    **transcript** expression of the Pasilla dataset (after batch effect
    correction)

## Batch Correction in SARTools

As we noted during the previous lab, the Single and Paired samples were
quite different in the Pasilla dataset. This difference was a problem
because it was not related to the hypothesis: that transcript expression
would be affected by RNAi treatment. For this reason, we want to block
the effects of sequencing layout on the experimental design by using
batch correction. In SARTools this is done simply by providing a column
in the target.txt file that contains the batch information and then
setting `batch` to that column name. You should run the SARTools
analysis again after setting batch \<- “batch” and changing the working
directory to a new directory (like “SARTools.DESeq2.genes.batch”). You
will need to also make that directory in the Files panel. Lastly, you
should probably change the project name to something like
“SARTools.DESeq2.genes.batch”.

## Transcript Expression

Because we expect Pasilla knockdown to affect alternative splicing, we
need to look at transcript expression and not just gene expression. Run
the DESeq2 and edgeR analyses using transcripts instead of genes. (You
will still need to use batch correction.) Don’t forget to make new
directories for the output and give the project a new name so that the
previous files don’t get overwritten.

## Objectives

\[ \] Compare the number of genes differentially expressed before and
after batch correction \[ \] Confirm whether Pasilla gene expression was
knocked down by the RNAi treatment \[ \] Compare the differential
transcript expression detected by edgeR and DESeq2

## Batch Correction

Compare the SARTools Report for one of the analyses with and without
batch correction. In one or two sentences, summarize the difference that
batch correction made in the PCA plot and the number of differentially
expressed genes.

Batch correction appeared to possibly double the number of
differentially expressed genes at very low p-values. With the PCA we see
notable changes after batch correction where the batch corrected PCA
appears to have been rotated 90 degrees.

## Pasilla Gene Analysis

1.  Use <http://flybase.org/> to determine the FlyBase **gene** name for
    the Pasilla gene.
2.  Load in the gene expression results from either EdgeR or DESeq2.
3.  Determine if the Pasilla gene was differentially expressed in the
    treated samples. (look at p-value of pasilla gene)

pasilla (CG42670,
FBgn0261552)

``` r
wd <- "/Users/robert/Documents/School/Advanced Data Analysis/rob_han/Project03/SARTools/"
setwd(wd)
RNAivsUntreated_complete <- read_delim("SARToolsDESeq2.batch.genes/tables/RNAivsUntreated.complete.txt", 
    "\t", escape_double = FALSE, trim_ws = TRUE)
```

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   Id = col_character(),
    ##   betaConv = col_logical(),
    ##   maxCooks = col_logical()
    ## )

    ## See spec(...) for full column specifications.

``` r
# Check that numbers agree with SARTools Report

tot <- RNAivsUntreated_complete %>% dplyr::filter(padj < 0.05) %>% tally()
EZ_print(c("Total:", tot, "\n"))
```

    ## Total: 1525

``` r
up <- RNAivsUntreated_complete %>% dplyr::filter(padj < 0.05) %>% dplyr::filter(FoldChange > 1) %>% tally()
EZ_print(c("Up:", up, "\n"))
```

    ## Up: 704

``` r
down <- RNAivsUntreated_complete %>% dplyr::filter(padj < 0.05) %>% dplyr::filter(FoldChange < 1) %>% tally()
EZ_print(c("Down:", down))
```

    ## Down: 821

Checking the Pasilla gene, we see it is present and downregulaed by a
fold change of 0.274.

``` r
head(RNAivsUntreated_complete)
```

    ## # A tibble: 6 x 27
    ##   Id     Ctrl1 Ctrl3 Ctrl4  RNAi1 RNAi3 RNAi4 norm.Ctrl1 norm.Ctrl3 norm.Ctrl4
    ##   <chr>  <dbl> <dbl> <dbl>  <dbl> <dbl> <dbl>      <dbl>      <dbl>      <dbl>
    ## 1 FBgn…    195    75    64    174    85    69         98        117         91
    ## 2 FBgn…      8     2     5     21     3     2          4          3          7
    ## 3 FBgn…     12     4     4     11     0     1          6          6          6
    ## 4 FBgn… 285369 68062 49594 276128 36619 38709     143731     106368      70666
    ## 5 FBgn…    792   241   294    798   285   305        399        377        419
    ## 6 FBgn…      2     0     0      0     0     0          1          0          0
    ## # … with 17 more variables: norm.RNAi1 <dbl>, norm.RNAi3 <dbl>,
    ## #   norm.RNAi4 <dbl>, baseMean <dbl>, Untreated <dbl>, RNAi <dbl>,
    ## #   FoldChange <dbl>, log2FoldChange <dbl>, stat <dbl>, pvalue <dbl>,
    ## #   padj <dbl>, dispGeneEst <dbl>, dispFit <dbl>, dispMAP <dbl>,
    ## #   dispersion <dbl>, betaConv <lgl>, maxCooks <lgl>

``` r
FBgn0261552 <- dplyr::filter(RNAivsUntreated_complete, Id == "FBgn0261552")
FBgn0261552
```

    ## # A tibble: 1 x 27
    ##   Id    Ctrl1 Ctrl3 Ctrl4 RNAi1 RNAi3 RNAi4 norm.Ctrl1 norm.Ctrl3 norm.Ctrl4
    ##   <chr> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>      <dbl>      <dbl>      <dbl>
    ## 1 FBgn… 22518  5916  5184  6734  1604  1703      11342       9246       7387
    ## # … with 17 more variables: norm.RNAi1 <dbl>, norm.RNAi3 <dbl>,
    ## #   norm.RNAi4 <dbl>, baseMean <dbl>, Untreated <dbl>, RNAi <dbl>,
    ## #   FoldChange <dbl>, log2FoldChange <dbl>, stat <dbl>, pvalue <dbl>,
    ## #   padj <dbl>, dispGeneEst <dbl>, dispFit <dbl>, dispMAP <dbl>,
    ## #   dispersion <dbl>, betaConv <lgl>, maxCooks <lgl>

## Comparison of EdgeR and DESeq2

1.  Load in the transcript expression results from both EdgeR or DESeq2.
2.  Determine the number of differentially expressed transcripts
    detected by each program.
3.  Compare the identity of the transcripts differentially
expressed

<!-- end list -->

``` r
wd <- "/Users/robert/Documents/School/Advanced Data Analysis/rob_han/Project03/SARTools/"
setwd(wd)

DESeq2_RNAivsUntreated_complete <- read_delim("SARToolsDESeq2.batch.transcripts/tables/RNAivsUntreated.complete.txt", 
    "\t", escape_double = FALSE, trim_ws = TRUE)
```

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   Id = col_character(),
    ##   betaConv = col_logical(),
    ##   maxCooks = col_logical()
    ## )

    ## See spec(...) for full column specifications.

``` r
edgeR_RNAivsUntreated_complete <- read_delim("SARTools_edgeR.batch.transcripts/tables/RNAivsUntreated.complete.txt", 
    "\t", escape_double = FALSE, trim_ws = TRUE)
```

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   Id = col_character()
    ## )
    ## See spec(...) for full column specifications.

``` r
EZ_print(c("Count:", "DESeq2", "edgeR", "\n"))
```

    ## Count: DESeq2 edgeR

``` r
tot1 <- DESeq2_RNAivsUntreated_complete %>% dplyr::filter(padj < 0.05) %>% tally()
tot2 <- edgeR_RNAivsUntreated_complete %>% dplyr::filter(padj < 0.05) %>% tally()
EZ_print(c("Total: ", tot1, tot2, "\n"))
```

    ## Total:  1565 1447

``` r
up1 <- DESeq2_RNAivsUntreated_complete %>% dplyr::filter(padj < 0.05) %>% dplyr::filter(FoldChange > 1) %>% tally()
up2 <- edgeR_RNAivsUntreated_complete %>% dplyr::filter(padj < 0.05) %>% dplyr::filter(FC > 1) %>% tally()
EZ_print(c("Up:     ", up1, up2, "\n"))
```

    ## Up:      752 702

``` r
down1 <- DESeq2_RNAivsUntreated_complete %>% dplyr::filter(padj < 0.05) %>% dplyr::filter(FoldChange < 1) %>% tally()
down2 <- edgeR_RNAivsUntreated_complete %>% dplyr::filter(padj < 0.05) %>% dplyr::filter(FC < 1) %>% tally()
EZ_print(c("Down:   ", down1, down2, "\n"))
```

    ## Down:    813 745

``` r
dim(DESeq2_RNAivsUntreated_complete)
```

    ## [1] 30061    27

``` r
dim(edgeR_RNAivsUntreated_complete)
```

    ## [1] 30061    22

Are the same transcripts being picked up by the two tools? No. We see
that of the transcripts that were seen to be upregulated and
downregulated, 606 and 653, respectively, were found by both DESeq2 and
EdgeR. For those same categories 146, and 160 for upregulated, and
downregulated respectively were not found in the other
test.

``` r
DESeq2_RNAivsUntreated_complete %>% dplyr::filter(padj < 0.05) %>% dplyr::filter(FoldChange > 1)-> D_up
edgeR_RNAivsUntreated_complete %>% dplyr::filter(padj < 0.05) %>% dplyr::filter(FC > 1) -> E_up
DESeq2_RNAivsUntreated_complete %>% dplyr::filter(padj < 0.05) %>% dplyr::filter(FoldChange < 1) -> D_down
edgeR_RNAivsUntreated_complete %>% dplyr::filter(padj < 0.05) %>% dplyr::filter(FC < 1)-> E_down 

D_up$Id %in% E_up$Id %>% sum() -> in_up
D_down$Id %in% E_down$Id %>% sum() -> in_down

(!D_down$Id %in% E_down$Id) %>% sum() -> not_in_down
(!D_up$Id %in% E_up$Id) %>% sum() -> not_in_up

EZ_print(c("up:", in_up, "\ndown:", in_down))
```

    ## up: 606 
    ## down: 653

``` r
EZ_print(c("\nnot in up:", not_in_up, "\nnot in down:", not_in_down))
```

    ## 
    ## not in up: 146 
    ## not in down: 160

Bonus, if you are feeling brave. Look for a new package that allows you
to make Venn diagrams of the differentially expressed transcripts.

## Helpful RNA-Seq Links

Pasilla paper: <https://genome.cshlp.org/content/21/2/193.full>

RNA-seqlopedia: <https://rnaseq.uoregon.edu/>

RNA-Seq Blog: <http://www.rna-seqblog.com/>

QCFAIL Blog: <https://sequencing.qcfail.com/> (Unfortunately it looks
like they are no longer posting, but they have some great posts about
problems with certain Illumina sequencers.)

QCFAIL post about SRA file corruption:
<https://sequencing.qcfail.com/articles/data-can-be-corrupted-upon-extraction-from-sra-files/>
(This is why it is so important to look at the raw fastq files and check
the lengths of the reads before trimming.)
