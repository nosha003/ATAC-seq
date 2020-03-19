Steps for processing ATAC-seq datasets

1) generate names.txt with directory, read1, read2, id, barcode
2) fastqc to determine quality of reads
3) trim reads with cutadapt and re-run qc
4) create bowtie2 index of reference genome
5) align to reference using bowtie2 and convert bam to sam file
6) subset alignment to uniquely mapped reads
7) samstat for read alignment statistics
8) merge reps if necessary
9) generate 100bp bin files and calculate cpm
10) QC final data with metaplot and IGV file (bedgraph and tdf) creation
11) call MACs peaks
