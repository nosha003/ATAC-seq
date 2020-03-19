#9Jan2020

#!/bin/bash
#PBS -l walltime=08:00:00,nodes=1:ppn=1,mem=5gb
#PBS -o /scratch.global/nosha003/e_o/atacseq_fastqc_o
#PBS -e /scratch.global/nosha003/e_o/atacseq_fastqc_e
#PBS -N fastqc
#PBS -V
#PBS -r n

DIR="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 1)"
SAMPLE="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 2)"
SAMPLE2="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 3)"
ID="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 4)"

module load fastqc

mkdir /scratch.global/nosha003/atac/fastqc

fastqc -o /scratch.global/nosha003/atac/fastqc --noextract -f fastq ${DIR}/${SAMPLE}.fastq

# qsub -t 1-8 -v LIST=/home/springer/nosha003/schmitz/atac_design.txt /scratch.global/nosha003/atac/fastqc.sh
# qsub -t 1-8 -v LIST=/home/springer/nosha003/schmitz/atac_design_2.txt /scratch.global/nosha003/atac/fastqc.sh
# qsub -t 1-4 -v LIST=/home/springer/nosha003/schmitz/atac_schmitz_design.txt /scratch.global/nosha003/atac/fastqc.sh
