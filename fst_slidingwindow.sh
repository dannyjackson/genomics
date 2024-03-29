#!/bin/bash

#Automated Fst script 
#requires file Fst.R to be located in home directory

if [ $# -lt 1 ]
  then
    echo "Generates a pdf of a sliding window fst scan.
    [-v] Path to vcf file
    [-o] Output directory for files
    [-p] Population 1 file
    [-q] Population 2 file
    [-n] Project name, prefix for output files
    [-w] Window size
    [-s] Window step size (usually give the same number as for window to prevent overlap)"
  else
    while getopts v:o:p:q:n:w:s: option
    do
    case "${option}"
    in
    v) dataset=${OPTARG};;
    o) outDir=${OPTARG};;
    p) pop1=${OPTARG};;
    q) pop2=${OPTARG};;
    n) name=${OPTARG};;
    w) window=${OPTARG};;
    s) step=${OPTARG};;
    esac
    done
    
  vcftools --vcf $dataset --weir-fst-pop $pop1 --weir-fst-pop $pop2 --fst-window-size $window --fst-window-step $step --out $outDir/$name

  sed -i 's/scaffold//g' $outDir/$name.windowed.weir.fst
  sed -i 's/Scaffold//g' $outDir/$name.windowed.weir.fst
  Rscript ~/genomics/Fst.R $dataset $outDir $name 

fi
