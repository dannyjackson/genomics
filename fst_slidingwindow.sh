#!/bin/bash

#Automated Fst script 
#requires file Fst.R to be located in home directory

if [ $# -lt 1 ]
  then
    echo "Generates a pdf of a sliding window fst scan.
    [-v] Path to vcf file
    [-o] Output directory for files
    [-p] Population file
    [-n] Project name, prefix for output files
    [-w] Size of sliding window. Also used for step size to prevent overlap."

  else
    while getopts v:o:p:n:w: option
    do
    case "${option}"
    in
    v) dataset=${OPTARG};;
    o) outDir=${OPTARG};;
    p) pops=${OPTARG};;
    n) name=${OPTARG};;
    w) window=${OPTARG};;
    esac
    done

fi
