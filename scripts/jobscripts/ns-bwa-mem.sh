#!/bin/bash
#####  Constructed by HPC everywhere #####
#PBS -M patgwall@iu.edu
#PBS -l nodes=1:ppn=10,walltime=0:24:00:00
#PBS -m abe
#PBS -N ns-big-bwa-mem1
#PBS -j oe

######  Module commands #####
module unload python/3.6.8
module load anaconda/python3.8/2020.07
module load bwa/0.7.12
module load samtools


######  Job commands go below this line #####
source activate base
conda activate 590term
cd /N/project/info590_edwards_wall/data/


bwa mem -t 10 bwa-idx/macaque-ref macaque-male.srr_1.fastq macaque-male.srr_2.fastq > mapped/macaque-male.sam
