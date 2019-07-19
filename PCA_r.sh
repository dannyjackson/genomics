#!/bin/bash

#shell script to generate a PCA plot from a VCF file 
#requires file automatedPCA.R to be located in home directory 

if [ $# -lt 1 ]
  then
    echo "Generates two PCA plots, one defining points by population and another defining points by individual.
    [-v] Path to vcf file 
    [-o] Output directory for files
    [-p] Population file
    [-n] Project name, prefix for output files
    [-s] Asks if you want SNPs to be subsetted to account for linkage. Define as any text to subset, leave off to ignore."

  else
    while getopts v:o:p:n:s: option
    do
    case "${option}"
    in
    v) dataset=${OPTARG};;
    o) outDir=${OPTARG};;
    p) pops=${OPTARG};;
    n) name=${OPTARG};;
    s) subset=${OPTARG};;
    esac
    done
  Rscript ~/genomics/automatedPCA.R $dataset $outDir $pops $name
  
 if [ -z $subset];
 then
 echo "Option to subset SNPs not chosen";
 else Rscript ~/genomics/automatedPCA_subset.R $dataset $outDir $pops $name;
 fi
fi
