# Installation instructions:
# 1. Install DEBrowser and its dependencies by running the lines below
# in R or RStudio.

if (!requireNamespace("BiocManager", quietly=TRUE))
  install.packages("BiocManager")
BiocManager::install("debrowser")


# 2. Load the library

library(debrowser)

# 3. Prepare data for DEBrowser

if (!require("tidyverse")) install.packages("tidyverse"); library(tidyverse)

# List the count files. You may need to change the path and pattern to match your files.

workDir <- "/Users/robert/Documents/School/Advanced Data Analysis/rob_han/Final/"
setwd(workDir)

### Now repeat all of that for the transcript files
### Recursion = TRUE will tell R to search each subdirectory until there are no searchable directories left. (source: list.file help)
transcriptfilelist <- list.files( pattern="*abundance.tsv", full.names=T, recursive = TRUE)
transcriptfiles <- lapply(transcriptfilelist, read_tsv)
transcriptfilenames <- list.files( pattern="*abundance.tsv", full.names=F, recursive = TRUE)

samplenames <- gsub("SRP100701/kallisto/", "", transcriptfilenames) # Editing names
samplenames <- gsub("SRP100701/kallisto/","", samplenames)
samplenames <- gsub(".abundance.tsv", "", samplenames)
samplenames <- gsub("-","_", samplenames) # DEBrowser doesn't like -
samplenames <- trimws(samplenames)
samplenames

transcriptfiles %>%
  bind_cols() %>%
  dplyr::select(target_id, starts_with("est_counts")) -> transcripttable
colnames(transcripttable)[2:13] <- as.list(samplenames)

head(transcripttable)
str(transcripttable)
write_tsv(transcripttable, path="transcripttable.tsv")

## Also need to reformat the target.txt file to match the sample names
transcripts_target <- read_delim("transcript.target.tsv", 
                                 "\t", escape_double = FALSE, trim_ws = TRUE)
transcripts_target
colnames(transcripttable) <- gsub("-","_", colnames(transcripttable))
colnames(transcripttable)
transcripts_target$Sample_Name_s[1:12] <- colnames(transcripttable)[2:13]



metadata <- dplyr::select(transcripts_target, c(Sample_Name_s, gender_s, treatment_s))
colnames(metadata) <- c("sample","gender","treatment")
write_tsv(metadata, path="metadata.tsv")
metadata

colnames(transcripttable)[2:13] == metadata$sample


# 4. Start DEBrowser

startDEBrowser()

