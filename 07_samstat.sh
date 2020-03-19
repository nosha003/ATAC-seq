#9Jan2020
#samstat.sh
#!/bin/bash

#Samstat_metrics
#PBS -l walltime=24:00:00,nodes=1:ppn=6,mem=10gb	
#PBS -o /scratch.global/nosha003/e_o/samstat_o
#PBS -e /scratch.global/nosha003/e_o/samstat_e
#PBS -N samstat
#PBS -V
#PBS -r n

DIR="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 1)"
SAMPLE="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 2)"
SAMPLE2="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 3)"
ID="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 4)"
ADAPTER="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 5)"

mkdir /scratch.global/nosha003/atac/samstat
cd /scratch.global/nosha003/atac/samstat

#samstat
module load samtools

/home/springer/nosha003/software/samstat-1.5.1/src/samstat /scratch.global/nosha003/atac/align/${ID}_pe_bowtie2.bam
/home/springer/nosha003/software/samstat-1.5.1/src/samstat /scratch.global/nosha003/atac/align/${ID}_pe_bowtie2_uniq.sam

#qsub -t 1-8 -v LIST=/home/springer/nosha003/schmitz/atac_design.txt /scratch.global/nosha003/atac/samstat.sh
#qsub -t 1-8 -v LIST=/home/springer/nosha003/schmitz/atac_design_2.txt /scratch.global/nosha003/atac/samstat.sh
#qsub -t 1-4 -v LIST=/home/springer/nosha003/schmitz/atac_schmitz_design.txt /scratch.global/nosha003/atac/samstat.sh
