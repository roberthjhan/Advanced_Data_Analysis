# Galaxy Tutorial

1. Log into https://galaxy.bucknell.edu and take the interactive tours of the `Galaxy UI` and `History`
2. In Lab last week we have already accomplished:
   - Downloading the data from the sequence read archive (see below for links to the samples)
   - Trimming the data to remove adapters and poor quality reads using trimmomatic
   - Assessing the quality of the data using FastQC
3. Transfer the trimmed reads from the Data Library (required only if you didn't complete Lab 8 successfully)
   - Click on `Shared Data`... `Data Libraries`
   - Select "RNASeq Group Project" and then choose all of the files.
   - Click `To History`, `as Datasets`, and then `Import`
   - Click on the Galaxy logo in the top left to return to the Analysis page.
   - The data files should be in the History panel on the right. 
   - If you need to change histories, click the `View All Histories` icon in the top right of the History panel.
4. Pseudoaligning the reads to a transcriptome
   - In the tool panel, search for Salmon
   - Select the following options for Salmon
     - *Use a built-in index?* Use one from the history
     - *Select the reference transcriptome:* Drosophila_melanogaster.BDGP6.cdna.all.fa.gz
     - *kmerLen:* 21
     - *Is this library mate-paired?* Single-end
     - *FASTQ/FASTA file:* Trimmomatic on S2_DRSC_Untreated-1
     - *Specify the strandedness of the reads:* Not stranded (U)
     - *File containing a mapping of transcripts to genes:* Drosophila_melanogaster.BDGP6.95.chr.gtf.gz
   - Leave all of the other options as the defaults, and click `Execute`
5. After that job successfully runs on BisonNet, click the `Eye` icon to view the results.
   - You should see two results files, one for genes and the other for transcripts.
   - Each should have a 5 column table that includes the transcripts per million mapped reads (TPM) and the number of reads (numReads) mapped to each gene/transcript.
6. Click one of the results files in the History panel and then click `Run this job again` :arrows_counterclockwise:.
   - Change the the FASTQ/FASTA file to Trimmomatic on S2_DRSC_CG8144_RNAi-1.
   - Leave all other settings the same and click `Execute`
7. While that is running use `Run this job again` to set up one of the paired read files to run:
   - Change Is this library mate-paired? to Paired-end
   - Select Mate pair 1: Trimmomatic on S2_DRSC_Untreated-3_R1
   - Select Mate pair 2: Trimmomatic on S2_DRSC_Untreated-3_R2
   - Double check that you have R1 for Mate pair 1, R2 for Mate pair 2, and both come from the same sample
   - Click `Execute`
8. Now set up the other three paired samples. (You can fill up the queue and then make a sammich while you wait.)
   - When they are complete verify that each of the pseudoalignment runs ran properly.
      - Click on the results in the History panel to view the first 5 lines of the file.
      - Verify that there are values in the TPM and NumReads columns (click the View Data icon to see all the data if needed).
      - Click the View Details (i) icon to see the parameters used for the analysis.
      - Follow the `stdout` and `stderr` links to view the output generated during the analysis.
      - Under Tool Parameters verify which trimmed read file(s) were used.
9. Download each file and rename it.
   - As you check the read file, copy the sample name from the trimmed file name.
   - Click download :floppy_disk: and then find the downloaded file and rename it (no spaces or symbols):
      - Name the Gene Quantification files Sample_Name.genes.tsv and the Quantification files Sample_Name.transcripts.tsv
   - After you have downloaded all of the results files and renamed them, start the [SARTools Tutorial](2-SARTools.md)

### Samples
Untreated samples: 

- SRR031711 http://www.ncbi.nlm.nih.gov/Traces/sra/?run=SRR031711
- SRR031714 http://www.ncbi.nlm.nih.gov/Traces/sra/?run=SRR031714
- SRR031716 http://www.ncbi.nlm.nih.gov/Traces/sra/?run=SRR031716

RNAi-treated samples

+ SRR031718 http://www.ncbi.nlm.nih.gov/Traces/sra/?run=SRR031718
+ SRR031724 http://www.ncbi.nlm.nih.gov/Traces/sra/?run=SRR031724
+ SRR031726 http://www.ncbi.nlm.nih.gov/Traces/sra/?run=SRR031726
