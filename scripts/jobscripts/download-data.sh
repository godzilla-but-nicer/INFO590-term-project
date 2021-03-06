#!/bin/bash
#####  Constructed by HPC everywhere #####
#PBS -M patgwall@iu.edu
#PBS -l nodes=1:ppn=1,walltime=0:12:59:00
#PBS -m abe
#PBS -N download-data
#PBS -j oe

######  Module commands #####
module unload python/3.6.8
module load anaconda/python3.8/2020.07



######  Job commands go below this line #####
source activate base
conda activate 590term
cd /N/project/info590_edwards_wall

# Snakemake should ignore if present but i might as well comment it out
# snakemake --cores 1 data/ref/macaque-ref.fna
snakemake --cores 1 data/reads/macaque-female2.fastq
snakemake --cores 1 data/reads/macaque-male2.fastq
