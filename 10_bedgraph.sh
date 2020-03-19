#9Jan2020
#atacseq_bedgraph.sh
#!/bin/bash

#Bedgraph 
#PBS -l walltime=08:00:00,nodes=1:ppn=6,mem=10gb	
#PBS -o /scratch.global/nosha003/e_o/bedgraph_atac_o
#PBS -e /scratch.global/nosha003/e_o/bedgraph_atac_e
#PBS -N bedgraph_atacseq
#PBS -V
#PBS -r n

DIR="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 1)"
SAMPLE="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 2)"
SAMPLE2="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 3)"
ID="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 4)"

module load bedtools
module load samtools

cd /scratch.global/nosha003/atac/align
    
bedtools genomecov -ibam ${ID}.bam -bg > ${ID}.bedgraph
bedtools genomecov -ibam ${ID}.uniq.bam -bg > ${ID}.uniq.bedgraph

#qsub -t 1-4 -v LIST=/home/springer/nosha003/schmitz/atac_merge.txt /scratch.global/nosha003/atac/bedgraph.sh
