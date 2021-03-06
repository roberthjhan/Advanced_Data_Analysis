Homework 08
================
Rob Han
20 Apr 2020

## Objectives

For this assignment you will need to characterize several attributes of
a differential expression transcriptomics study and compare them to the
study that you are using for Project 4. - \[ \] Differential Expression
experimental design - \[ \] Sample replication - \[ \] Sequencing depth
and format - \[ \] Quality control steps performed - \[ \] Mapping
program used - \[ \] DE analysis performed

## Example paper

RNA-Seq performed by: Frahm KA, Waldman JK, Luthra S, Rudine AC,
Monaghan-Nichols AP, Chandran UR. A comparison of the sexually dimorphic
dexamethasone transcriptome in mouse cerebral cortical and hypothalamic
embryonic neural stem cells. Mol Cell Endocrinol. 2017;
<https://doi.org/10.1016/j.mce.2017.05.026>.

You can find a copy of this paper in the Readings folder.

Abstract Fetal exposure to synthetic glucocorticoids reprograms distinct
neural circuits in the developing brain, often in a sex-specific manner,
via mechanisms that remain poorly understood. To reveal whether such
reprogramming is associated with select molecular signatures, we
characterized the transcriptome of primary, embryonic mouse cerebral
cortical and hypothalamic neural progenitor/stem cells derived from
individual male and female embryos exposed to the synthetic
glucocorticoid, dexamethasone. Gene expression profiling by RNA-Seq
identified differential expression of common and unique genes based upon
brain region, sex, and/or dexamethasone exposure. These gene expression
datasets provide a unique resource that will inform future studies
examining the molecular mechanisms responsible for region- and
sex-specific reprogramming of the fetal brain brought about by in utero
exposure to excess glucocorticoids.

Link to the dataset: <https://www.ncbi.nlm.nih.gov/sra/SRP100701>

## Your paper

Summarize your paper here. Provide links to the paper and to the RNAseq
dataset.

The herpes simplex virus (HSV) is particularly interesting because of
its ability to hide itself in its host’s genome in what is known as a
latent infection. During the latent infection the viral genome is well
protected from the host’s immune response making the disease a lifelong
one. Current treatment regimes seek only to inhibit the lytic infection
of HSV but the latent infection may be susceptible to targeting.
Arbuckle et al. attempts to target epigenetic genes contibuting to the
methylation of the HSV viral genome to facilitate immune response
targeting of viral genomes. The group found that inhibition of histone
methyltransferases EZH2 and EZH1 (EZH2/1) blocked the viral lytic cycle
of HSV from reactivation. Inhibition also induced an antiviral state in
Adenovirus and Zika virus
infections.

<https://mbio.asm.org/content/8/4/e01141-17#sec-10>

[https://www.ncbi.nlm.nih.gov/sra/SRX2897183\[accn\]](https://www.ncbi.nlm.nih.gov/sra/SRX2897183%5Baccn%5D)

## Questions

Answer these questions for each paper. Note that it is okay (well, okay
for you) if this information is not available in the paper. In that
case, indicate *NOT FOUND*.

1.  Differential Expression experimental design What was the organism,
    tissue, and treatment groups? Was there anything special about the
    RNA isolation procedures?

Frahm et al. Organism: C57BL/6 mice Tissue: cortical and hypothalamic
NPSC cultures Treatment groups: 100 nM Dex or vehicle(\[EtOH\]) RNA
isolation procedures: hypothalamic NPSCs: Machery-Nagel Nuce- lospin RNA
II kit cortical RNAs: Trizol (Life Technologies) lysates following
organic extraction and ethanol precipitation.

Arbuckle et al. Organism: HFF cells (human-foreskin), mouse ganglia
Tissue: ganglia (mouse) Treatment groups: EZH2/1 catalytic inhibitors
GSK126, GSK343, and UNC1999, astemizole RNA isolation procedures:
Isolate II RNA minikit (Bioline)

2.  Sample replication Were RNA samples pooled? How many individuals
    were used for each treatment group? What criteria was used to
    determine if this sample size was sufficient?

Frahm et al. I think samples were pooled. 3 biological replicates. I
don’t know that the sample size was discuseed

Arbuckle et al. I think samples were pooled 3 biological replicates.
*NOT FOUND*

3.  Sequencing depth and format What was the depth and type of
    sequencing performed? What criteria was used to determine if this
    sequencing depth was sufficient?

Frahm et al. TruSeq stranded total RNA kit -\> Tufts University Genomics
Core 10,250 protein coding genes, 155 long noncoding RNAs, 31 short non-
coding RNAs, and 48 pseudogenes

Arbuckle et al. TruSeq Stranded Total RNA with Ribo-Zero *NOT FOUND*

4.  Quality control steps performed How was the data cleaned (trimmed)
    and checked for quality? Were any samples excluded (and, if so,
    why)?

Frahm et al. The in house dataset was compared with another and genes
not shared by both were removed.

Arbuckle et al. RNA quality (an RNA integrity number of \>8.5) was
verified by Bioanalyzer. Unsure if samples were excluded.

5.  Mapping program used Finally, an easy question.

Frahm et al. Tophat1&2

Arbuckle et al. Star

6.  DE analysis performed What program was used? What cutoff values were
    used? Was more than one DE program used? (If so, how were results
    presented?)

Frahm et al. edgeR “\> 5 CPM in at least 3 samples”

Arbuckle et al. Partek Gene Specific Analysis Maybe: QIAGEN Ingenuity
pathway Analysis
