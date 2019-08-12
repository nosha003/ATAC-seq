#24Jan2017
#atacseq_filter.sh
#!/bin/bash

#filter peaks
#PBS -l walltime=08:00:00,nodes=1:ppn=1,mem=2gb	
#PBS -o /scratch.global/nosha003/schmitz/e_o/atacseq_filter_o
#PBS -e /scratch.global/nosha003/schmitz/e_o/atacseq_filter_e
#PBS -N atacseq_filter
#PBS -V
#PBS -r n

SAMPLE="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 1)"
SAMPLE2="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 2)"
ID="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 3)"
ADAPTER="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 4)"

module load bedtools/2.25.0

bedtools coverage -a /scratch.global/nosha003/schmitz/atacseq/homer/peaks/${ID}_uniq.pks.bed -b /scratch.global/nosha003/schmitz/atacseq/align/${ID}_bowtie_uniq.bed > /scratch.global/nosha003/schmitz/atacseq/homer/peaks/${ID}_uniq.pks.bg
 
#then select the peaks based on the value of last column (reads density), usually I removed the reads density =< 2.5time of whole genome reads density. For more strict selection, you can increase the value to find sharper peaks.
awk '{if($4/$6) <= 2.5 print $0}' OFS="\t" /scratch.global/nosha003/schmitz/atacseq/homer/peaks/${ID}.pks.bg > /scratch.global/nosha003/schmitz/atacseq/homer/peaks/${ID}_cutoff.pks.bed

# qsub -t 1-12 -v LIST=/home/springer/nosha003/schmitz/scripts/atacseq_names.txt /home/springer/nosha003/schmitz/scripts/atacseq_filter.sh
# qsub -t 1-4 -v LIST=/home/springer/nosha003/schmitz/scripts/atacseq_combinereps_names.txt /home/springer/nosha003/schmitz/scripts/atacseq_filter.sh
