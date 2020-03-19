#9Jan2020
#macs_peaks
#count reads for 100 bp tiles with macs peak finding algorithm
	
#!/bin/bash
#PBS -l walltime=20:00:00,nodes=1:ppn=1,mem=40gb
#PBS -o /scratch.global/nosha003/e_o/macs2_o
#PBS -e /scratch.global/nosha003/e_o/macs2_e
#PBS -N macs2
#PBS -V
#PBS -r n

DIR="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 1)"
SAMPLE="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 2)"
SAMPLE2="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 3)"
ID="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 4)"
CONTROL="$(/bin/sed -n ${PBS_ARRAYID}p ${LIST} | cut -f 5)"

#load modules
module load macs/2.1.1
module load R

cd /scratch.global/nosha003/atac/align
mkdir /scratch.global/nosha003/atac/macs2

macs2 callpeak -f BED -t ${ID}.bedgraph -g 2.1e9 --keep-dup all --nomodel --shift -100 --extsize 200 -n ../macs2/${ID}_uniq_bed_macs


awk '{if ($5 > 10) print $0}' ${ID}_uniq_bed_macs_summits.bed > ${ID}_uniq_bed_macs_summits_neglog10qvalgr10.bed
sort -k 1,1 -k 2,2n ${ID}_uniq_bed_macs_summits_neglog10qvalgr10.bed | grep -v 'ctg' > ${ID}_uniq_bed_macs_summits_neglog10qvalgr10_sort.bed

#qsub -t 1,5,6 -v LIST=/home/springer/nosha003/schmitz/atac_merge.txt /scratch.global/nosha003/atac/macs2.sh
