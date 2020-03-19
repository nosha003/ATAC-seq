#9Jan2020
#atacseq_align.sh
#!/bin/bash

#Bowtie2_Alignment
#PBS -l walltime=20:00:00,nodes=1:ppn=6,mem=20gb	
#PBS -o /scratch.global/nosha003/schmitz/e_o/atacseq_align_o
#PBS -e /scratch.global/nosha003/schmitz/e_o/atacseq_align_e
#PBS -N atacseq_align
#PBS -V
#PBS -r n

DIR="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 1)"
SAMPLE="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 2)"
SAMPLE2="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 3)"
ID="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 4)"
ADAPTER="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 5)"

module load bowtie2/2.2.4
module load samtools/1.9

cd /scratch.global/nosha003/atac/
mkdir /scratch.global/nosha003/atac/align

bowtie2 -p 6 --phred33 -x /home/springer/nosha003/database/B73v4/index_bt2/Zea_mays.AGPv4.bt2 -1 /scratch.global/nosha003/atac/clean/${SAMPLE}_cutadapt.fastq -2 /scratch.global/nosha003/atac/clean/${SAMPLE2}_cutadapt.fastq -S /scratch.global/nosha003/atac/align/${ID}_pe_bowtie2.sam

samtools view -S -b -o /scratch.global/nosha003/atac/align/${ID}_pe_bowtie2.bam  /scratch.global/nosha003/atac/align/${ID}_pe_bowtie2.sam

# qsub -t 1-8 -v LIST=/home/springer/nosha003/schmitz/atac_design.txt /scratch.global/nosha003/atac/atacseq_align.sh
# qsub -t 1-8 -v LIST=/home/springer/nosha003/schmitz/atac_design_2.txt /scratch.global/nosha003/atac/atacseq_align.sh
# qsub -t 1-4 -v LIST=/home/springer/nosha003/schmitz/atac_schmitz_design.txt /scratch.global/nosha003/atac/atacseq_align.sh
