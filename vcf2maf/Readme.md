# Snakemake workflow for running VEP and vcf2maf using Singularity

This is intended to be a portable version of vcf2maf and VEP that can be run on any system capable of running Singularity and Snakemake. It should automatically pull the reference files and Singularity container when run. 
The reference (cache) for VEP is also automatically tabix-indexed to speed up the pipeline. This is the slowest part of the installation process. 

## Getting Started

Checkout the repository. Optionally create a new conda environment to run Snakemake using envs/environment.yml.
If you are using hg19, replace the default (hg38) config.yaml file with config.hg19.yaml. 

### Inputs

The workflow currently expects you to have pairs of vcf files from Strelka following the Strelka naming convention in the vcf directory. A regular expression is used to identify sample IDs and to remove additional details, which should be separated by an underscore. Because of this, there can be no underscores in the sample ID itself. 

```vcf/mysample_TN.snvs.vcf vcf/mysample_TN.indels.vcf```

### Prerequisites

You will need to have a working installation of Singularity and Snakemake on the system. To allow the container to be used, snakemake must be run with the appropriate option. 

```
snakemake --use-singularity
```

### Reference files and Outputs

The intermediate files needed for VEP to run are pulled from a remote server and are stored in the reference directory. The outputs are written to subdirectories in vcf2maf_out/

### Known Issues

Some versions of Snakemake are not compatible with certain Singularity versions due to a bug in Snakemake. This has been fixed in more recent versions. If you encounter an error message like this:

```if not LooseVersion(v) >= LooseVersion```

...try updating to a more recent version of Snakemake or use the provided environment in envs/environment.yml


