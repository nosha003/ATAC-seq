#9Jan2020
#atacseq_count
#count reads for 100 bp tiles with bedtools intersect
	
#!/bin/bash
#PBS -l walltime=08:00:00,nodes=1:ppn=6,mem=40gb
#PBS -o /scratch.global/nosha003/e_o/atacseq_count_o
#PBS -e /scratch.global/nosha003/e_o/atacseq_count_e
#PBS -N atacseq_count
#PBS -V
#PBS -r n

ID="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 4)"

#load modules
module load bedtools/2.17.0
module load samtools

mkdir /scratch.global/nosha003/atac/counts
mkdir /scratch.global/nosha003/atac/counts/${ID}

cd /scratch.global/nosha003/atac
cd /scratch.global/nosha003/atac/counts/${ID}

samtools sort -O sam -T ${ID} /scratch.global/nosha003/atac/align/${ID}_all.sam > /scratch.global/nosha003/atac/align/${ID}_all.sort.sam
samtools view -S -b /scratch.global/nosha003/atac/align/${ID}_all.sort.sam > /scratch.global/nosha003/atac/align/${ID}_all.sort.bam

#count number of reads aligning to each 100 bp window
bedtools intersect -abam /scratch.global/nosha003/atac/align/${ID}_all.sort.bam -b /home/springer/nosha003/database/B73v4/B73v4_100bp_bins.gff -bed -wa -wb > ${ID}.all.uniq.100bpbins.bed

## all bins
perl /home/springer/nosha003/wenli_data/scripts/bincounts.pl -i /home/springer/nosha003/database/B73v4/B73v4_100bp_bins.gff -I ${ID}.all.uniq.100bpbins.bed -o ${ID}.all.uniq.counts.txt

## all bins bed count file
cut -f 13,16-21 ${ID}.all.uniq.100bpbins.bed | sort | uniq > ${ID}.all.uniq.100bpbins_cut.bed
perl /home/springer/nosha003/wenli_data/scripts/bincounts_bed.pl -i ${ID}.all.uniq.counts.txt -I ${ID}.all.uniq.100bpbins_cut.bed -o ${ID}.all.uniq.100bpcounts.bed

#qsub -t 1-4 -v LIST=/home/springer/nosha003/schmitz/atac_merge.txt /scratch.global/nosha003/atac/100bp_counts_merge.sh
#qsub -t 1-4 -v LIST=/home/springer/nosha003/schmitz/atac_merge.txt /scratch.global/nosha003/atac/100bp_counts_merge_2.sh
#qsub -t 1 -v LIST=/home/springer/nosha003/schmitz/atac_merge_mo17only.txt /scratch.global/nosha003/atac/100bp_counts_merge_2.sh
