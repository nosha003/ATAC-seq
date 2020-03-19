# 15Jan2020
# merge bams

#!/bin/bash
#PBS -l walltime=20:00:00,nodes=1:ppn=1,mem=60gb
#PBS -o /scratch.global/nosha003/e_o/merge_o
#PBS -e /scratch.global/nosha003/e_o/merge_e
#PBS -N merge
#PBS -V
#PBS -r n

DIR="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 1)"
SAMPLE="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 2)"
SAMPLE2="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 3)"
ID="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 4)"

#load modules
module load samtools

cd /scratch.global/nosha003/atac/

#samtools merge /scratch.global/nosha003/atac/align/BN.bam /scratch.global/nosha003/atac/counts/BN1A/BN1A_sort.bam /scratch.global/nosha003/atac/counts/BN2A/BN2A_sort.bam 
samtools merge /scratch.global/nosha003/atac/align/${ID}.bam /scratch.global/nosha003/atac/counts/${SAMPLE}/${SAMPLE}_sort.bam /scratch.global/nosha003/atac/counts/${SAMPLE2}/${SAMPLE2}_sort.bam 
samtools merge /scratch.global/nosha003/atac/align/${ID}.uniq.bam /scratch.global/nosha003/atac/align/${SAMPLE}_uniq_sort.bam /scratch.global/nosha003/atac/align/${SAMPLE2}_uniq_sort.bam 

#qsub -t 1-4 -v LIST=/home/springer/nosha003/schmitz/atac_merge.txt /scratch.global/nosha003/atac/merge_bam.sh
