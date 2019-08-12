#28Jan2017
#atacseq_count
#count reads for 100 bp tiles with bedtools intersect
	
#!/bin/bash
#PBS -l walltime=08:00:00,nodes=1:ppn=1,mem=5gb
#PBS -o /scratch.global/nosha003/schmitz/e_o/atacseq_count_o
#PBS -e /scratch.global/nosha003/schmitz/e_o/atacseq_count_e
#PBS -N atacseq_count
#PBS -V
#PBS -r n

ID="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 3)"

#load modules
module load bedtools
module load samtools
	
cd /scratch.global/nosha003/schmitz/atacseq

#index alignment file
samtools index align/${ID}_bowtie.clean.bam
samtools index align/${ID}_bowtie_uniq.clean.bam

#count number of reads aligning to each 100 bp window
bedtools intersect -a /home/springer/nosha003/schmitz/atacseq/align/${ID}_bowtie.clean.bam -b /home/springer/nosha003/database/B73v4_100bp_bins.gff -bed -wa -wb > counts/${ID}.bowtie.100bpbins.bed
bedtools intersect -a /home/springer/nosha003/schmitz/atacseq/align/${ID}_bowtie_uniq.clean.bam -b /home/springer/nosha003/database/B73v4_100bp_bins.gff -bed -wa -wb > counts/${ID}_uniq.bowtie.100bpbins.bed

## all bins
perl /home/springer/nosha003/wenli_data/scripts/bincounts.pl -i /home/springer/nosha003/database/B73v4_100bp_bins.gff -I counts/${ID}.bowtie.100bpbins.bed -o counts/${ID}.bowtie.counts.txt
perl /home/springer/nosha003/wenli_data/scripts/bincounts.pl -i /home/springer/nosha003/database/B73v4_100bp_bins.gff -I counts/${ID}_uniq.bowtie.100bpbins.bed -o counts/${ID}_uniq.bowtie.counts.txt

## all bins bed count file
cut -f 13,16-21 counts/${ID}.bowtie.100bpbins.bed | sort | uniq > counts/${ID}.bowtie.100bpbins_cut.bed
perl /home/springer/nosha003/wenli_data/scripts/bincounts_bed.pl -i counts/${ID}.bowtie.counts.txt -I counts/${ID}.bowtie.100bpbins_cut.bed -o counts/${ID}.bowtie.100bpcounts.bed
cut -f 13,16-21 counts/${ID}_uniq.bowtie.100bpbins.bed | sort | uniq > counts/${ID}_uniq.bowtie.100bpbins_cut.bed
perl /home/springer/nosha003/wenli_data/scripts/bincounts_bed.pl -i counts/${ID}_uniq.bowtie.counts.txt -I counts/${ID}_uniq.bowtie.100bpbins_cut.bed -o counts/${ID}_uniq.bowtie.100bpcounts.bed
  
cp /scratch.global/nosha003/schmitz/atacseq/counts/${ID}_uniq.bowtie.100bpcounts.bed /home/springer/nosha003/schmitz/atacseq/counts/.
