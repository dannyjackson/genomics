# genomics

<b>PCA_r

To use, first make executable ("chmod +x PCA_r"). Requires the presence of files automatedPCA.R and automatedPCA_subset.R
Input files are a vcf table and a text file that lists population identifications in the same order as individuals appear in the vcf table. For example, if the vcf columns are "blue1, blue2, green1, green2, red1, red2" you would want a population text file that says:

blue

blue

green

green

red

red

To see the order of individuals in the vcf file, I use the command, grep 'CHROM' myfile.vcf
