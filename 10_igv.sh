#9Jan2020
#count_igv.sh
#!/bin/bash

#Bedgraph 
#PBS -l walltime=08:00:00,nodes=1:ppn=6,mem=10gb	
#PBS -o /scratch.global/nosha003/e_o/igv_atac_o
#PBS -e /scratch.global/nosha003/e_o/igv_atac_e
#PBS -N igv_atacseq
#PBS -V
#PBS -r n

DIR="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 1)"
SAMPLE="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 2)"
SAMPLE2="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 3)"
ID="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 4)"

cd /scratch.global/nosha003/atac/align
    
perl /home/springer/nosha003/schmitz/scripts/bedgraph_igv.pl -i ${ID}.bedgraph -o ${ID}.igv

module load igv
module load java
/home/springer/nosha003/igv/IGVTools/igvtools toTDF ${ID}.igv ${ID}.tdf /home/springer/nosha003/database/B73v4/Zea_mays.AGPv4.dna.genome.fa


#qsub -t 1-4 -v LIST=/home/springer/nosha003/schmitz/atac_merge.txt /scratch.global/nosha003/atac/count_igv.sh
