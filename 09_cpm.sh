#13Jan2020
#cpm

#!/bin/bash
#PBS -l walltime=08:00:00,nodes=1:ppn=6,mem=40gb
#PBS -o /scratch.global/nosha003/e_o/cpm_o
#PBS -e /scratch.global/nosha003/e_o/cpm_e
#PBS -N cpm
#PBS -V
#PBS -r n

cd /scratch.global/nosha003/atac/
module load R/3.5.0
R CMD BATCH 09_cpm.R
wait

# qsub /scratch.global/nosha003/atac/cpm.sh
