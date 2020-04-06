# SARTools Tutorial

This tutorial assumes that you have alread completed the [Galaxy Tutorial](1-Galaxy.md)

## SARTools

The SARTools package has been developped at PF2 - Institut Pasteur by M.-A. Dillies and H. Varet. *SARTools: A DESeq2- and EdgeR-Based R Pipeline for Comprehensive Differential Analysis of RNA-Seq Data*, PLoS One, 2016, doi: http://dx.doi.org/10.1371/journal.pone.0157022 when using this tool for any analysis published.

Help for SARTools, including installation, can be found at https://github.com/PF2-pasteur-fr/SARTools

## Tutorial

1. Make a SARTools folder within your local repo directory and place the following files from the Class repo within it:
   - The transcripts.target.txt and genes.target.txt files
   - The template_script_DESeq2.r file (and the template_script_edgeR.r file although you won't need that for now)
   - Also move the transcripts.tsv and genes.tsv files that you downloaded in Part 1 into this folder
   
2. Within R Studio open template_script_DESeq2.r
   - Create a new folder called SARTools.DESeq2.genes
   - Use File... Save As... to rename the script to YourName_genes_SARTools_DESeq2.r and save it in the folder you just created
   
3. Edit the following lines in the R script
   - Assign `workDir` to the location of the folder that you just created
     - To see the current working directory, type `getwd()` in the Console
     - Use this as a base to determine the correct string to use for `workDir`
   - Change `projectName` to "SARTools.DESeq2.genes" and `author` to your name
   - Change `targetFile` to "../genes.target.txt" (Why do we use `../` ?)
   - Change `rawDir` to "../"
   - Assign `featuresToRemove` to NULL and then remove the next two lines. (This step is optional, but cleans up the code.)
   - Change `varInt` to "Treatment" and `condRef` to "Untreated"
   - Leave `batch <- NULL` for now, although we will be revisiting this later.
   - Change `idColumn`, `countColumn`, and `rowSkip` to the appropriate values.
   
4. Open the target.txt file and one of the tsv files to verify the following
   - The target.txt file has exact matches for each file name in the column "files"
   - The `varInt` and `batch` variables are an exact match for column names (unless `batch` is NULL)
   - The `condRef` is an exact match for one of the values in the `varInt` column
   - The `idColumn`, `countColumn`, and `rowSkip` values match the format of the tsv file
   - Close the target.txt and tsv files
   
5. Running the SARTools R script
   - Save the edited script
   - Position the cursor at the top of the Script and type command-enter (or ctrl-enter) to run one line at a time
   - Watch the outpout in the Console to make sure that you catch any errors (some warnings are expected):
     - Do all 6 samples get loaded properly?
     - Are there similar null counts in the 6 samples?
     - How many total differentially expressed genes were detected?
     
6. Open the html report file
   - Read through the file carefully. Use the following figures to determine if there were problems with any of the samples.
     - Figure 1: Number of mapped reads per sample.
     - Figure 3: Density distribution of read counts.
     - Figure 10: Boxplots of read counts.
   - Use the following figures to asses whether the factor that you are interested in (RNAi treatment) is responsible for most of the variation in the samples:
     - Figure 6: Sample clustering based on normalized data.
     - Figure 7: Principal Component Analysis.
   - Use the following to determine if there were differentially expressed genes (or transcripts)
     - Figure 12: Distribution of raw p-values.
     - Table 7: Number of up-, down- and total number of differentially expressed features.
     - Figure 13: MA-plot.
     - Figure 14: Volcano plot.
   - Note the R session information and parameters for reproducibility purposes.
   
7. That initial analysis had some issues that we can try to resolve. Generate new working directories and analysis scripts to explore the following:
   - Is there a batch effect that we should take into consideration?
   - Should we be comparing the expression of **genes** or **transcripts**?
