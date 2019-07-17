# genomics

<strong> PCA_r </strong>

To use, first make executable ("chmod +x PCA_r"). Requires the presence of files automatedPCA.R and automatedPCA_subset.R

Input files are a vcf table and a text file that lists population identifications in the same order as individuals appear in the vcf table. For example, if the vcf columns are "blue1, blue2, green1, green2, red1, red2" you would want a population text file that says:

blue

blue

green

green

red

red

To see the order of individuals in the vcf file, I use the command, grep 'CHROM' myfile.vcf

Output files are a .gds file, a .txt file that holds the points for the PCA plots, a summary.txt file that gives a summary of the gds file, a percentvariation.txt file that gives the percent of variation accounted for by each principle component, and two pdf files. Both show the same plots of the PCA, but one is color coded by population and the other is color coded by individual. Both have the legend printed in the top left corner of the plot, which will likely have to be moved using Illustrator. The legend in the by-individual plot is likely cropped, but the information is still there and can be extracted using Illustrator and editing or removing the clipping mask over the boundaries of the legend.

If the option to subset snps is chosen, a second set of all of these files is created.
