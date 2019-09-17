# Snakemake workflow for running VEP and vcf2maf using Singularity

This is intended to be a portable version of vcf2maf and VEP that can be run on any system capable of running Singularity and Snakemake. It should automatically pull the reference files and Singularity container when run. 
The reference (cache) for VEP is also automatically tabix-indexed to speed up the pipeline. This is the slowest part of the installation process. 

## Getting Started

Checkout the repository. 

###Warning: currently this workflow only works for hg38###

### Inputs

The workflow currently expects you to have pairs of vcf files from Strelka following the Strelka naming convention in the vcf directory. 

```vcf/mysample_TN.snvs.vcf vcf/mysample_TN.indels.vcf```

### Prerequisites

You will need to have a working installation of Singularity and Snakemake on the system. To allow the container to be used, snakemake must be run with the appropriate option. 

```
snakemake --use-singularity
```

### Reference files and Outputs

The intermediate files needed for VEP to run are pulled from a remote server and are stored in the reference directory. The outputs are written to subdirectories in vcf2maf_out/

