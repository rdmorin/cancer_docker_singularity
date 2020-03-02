# Generate IGV screenshots en masse 
Runs IGV in headless mode to generate static images (PNGs) showing regions of interest based on a bedpe file

### Requirements
Place tumour and normal bam file pairs in data/genome_bams/tumourID.bam.

Put one or more bedpe file with a name that follows the pattern tumourID-normalID.bedpe.

Update regular expressions as needed in the wildcard constraint section. 

IGV is installed automatically. 