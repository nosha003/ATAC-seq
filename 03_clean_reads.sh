#9Jan2020

#!/bin/bash
#PBS -l walltime=10:00:00,nodes=1:ppn=1,mem=5gb
#PBS -o /scratch.global/nosha003/e_o/atacseq_clean_o
#PBS -e /scratch.global/nosha003/e_o/atacseq_clean_e
#PBS -N clean
#PBS -V
#PBS -r n

DIR="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 1)"
SAMPLE="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 2)"
SAMPLE2="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 3)"
ID="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 4)"
ADAPTER="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 5)"

module load cutadapt/1.8.1
module load fastqc
module load trimmomatic

mkdir /scratch.global/nosha003/atac/clean

# trimmomatix 
#java -Xmx7000M -jar $TRIMMOMATIC/trimmomatic.jar SE -threads 4 -phred64 ${DIR}/${SAMPLE}.fastq /scratch.global/nosha003/atac/clean/${SAMPLE}_trim.fastq ILLUMINACLIP:$TRIMMOMATIC/adapters/all_illumina_adapters.fa:2:30:10:2:true LEADING:20 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:35
#java -Xmx7000M -jar $TRIMMOMATIC/trimmomatic.jar SE -threads 4 -phred64 ${DIR}/${SAMPLE2}.fastq /scratch.global/nosha003/atac/clean/${SAMPLE2}_trim.fastq ILLUMINACLIP:$TRIMMOMATIC/adapters/all_illumina_adapters.fa:2:30:10:2:true LEADING:20 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:35

cutadapt -b AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT -b ${ADAPTER} -f fastq -m 30 -q 10 --quality-base=33 -o /scratch.global/nosha003/atac/clean/${SAMPLE}_cutadapt.fastq ${DIR}/${SAMPLE}.fastq
cutadapt -b AATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT -b ${ADAPTER} -f fastq -m 30 -q 10 --quality-base=33 -o /scratch.global/nosha003/atac/clean/${SAMPLE2}_cutadapt.fastq ${DIR}/${SAMPLE2}.fastq

fastqc -o /scratch.global/nosha003/atac/fastqc --noextract -f fastq /scratch.global/nosha003/atac/clean/${SAMPLE}_cutadapt.fastq
fastqc -o /scratch.global/nosha003/atac/fastqc --noextract -f fastq /scratch.global/nosha003/atac/clean/${SAMPLE}_trim.fastq

# qsub -t 1-8 -v LIST=/home/springer/nosha003/schmitz/atac_design.txt /scratch.global/nosha003/atac/clean.sh
# qsub -t 1-8 -v LIST=/home/springer/nosha003/schmitz/atac_design_2.txt /scratch.global/nosha003/atac/clean.sh
# qsub -t 1-4 -v LIST=/home/springer/nosha003/schmitz/atac_schmitz_design.txt /scratch.global/nosha003/atac/clean.sh
