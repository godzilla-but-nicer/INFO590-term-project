#!/bin/bash
#####  Constructed by HPC everywhere #####
#PBS -M patgwall@iu.edu
#PBS -l nodes=1:ppn=10,walltime=0:00:10:00
#PBS -m abe
#PBS -N 2ns-bwa-mem
#PBS -j oe

######  Module commands #####
module unload python/3.6.8
module load anaconda/python3.8/2020.07
module load bwa/0.7.12



######  Job commands go below this line #####
source activate base
conda activate 590term
cd /N/project/info590_edwards_wall/data/reads


bwa mem -p -t 10 macaque-ref.fna macaque-female.fastq > ../ns-mapped/female.sam
