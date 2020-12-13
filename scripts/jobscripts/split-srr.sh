#!/bin/bash
#####  Constructed by HPC everywhere #####
#PBS -M patgwall@iu.edu
#PBS -l nodes=1:ppn=1,walltime=0:12:59:00
#PBS -m abe
#PBS -N split-male-noer
#PBS -j oe

######  Module commands #####
module unload python/3.6.8
module load anaconda/python3.8/2020.07
module load sra-toolkit


######  Job commands go below this line #####
source activate base
conda activate 590term
cd /N/project/info590_edwards_wall/data/reads

fastq-dump --split-files macaque-male.srr

