#15Jan2020
#!/bin/bash

#Unique_Alignment
#PBS -l walltime=20:00:00,nodes=1:ppn=6,mem=20gb	
#PBS -o /scratch.global/nosha003/e_o/uniq_align_o
#PBS -e /scratch.global/nosha003/e_o/uniq_align_e
#PBS -N uniq
#PBS -V
#PBS -r n

DIR="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 1)"
SAMPLE="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 2)"
SAMPLE2="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 3)"
ID="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 4)"
ADAPTER="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 5)"

module load bowtie2/2.2.4
module load samtools/1.9

cd /scratch.global/nosha003/atac/align/
  
grep -E "@|NM:" ${ID}_pe_bowtie2.sam | grep -v "XS:" > ${ID}_pe_bowtie2_uniq.sam

# qsub -t 1-8 -v LIST=/home/springer/nosha003/schmitz/atac_design.txt /scratch.global/nosha003/atac/uniq_align.sh
# qsub -t 1-8 -v LIST=/home/springer/nosha003/schmitz/atac_design_2.txt /scratch.global/nosha003/atac/uniq_align.sh
# qsub -t 1-4 -v LIST=/home/springer/nosha003/schmitz/atac_schmitz_design.txt /scratch.global/nosha003/atac/uniq_align.sh
