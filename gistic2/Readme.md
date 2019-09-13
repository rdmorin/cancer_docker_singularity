# Snakemake workflow for running Gistic via Singularity

This is intended to be a portable version of GISTIC2 that can be run on any system capable of running Singularity and Snakemake. It should automatically pull the reference files and Singularity container when run.

## Getting Started

In theory, the only configuration required is to choose the appropriate config file matching the reference genome used in generating segmented copy number. 
cp config_hg38.yaml config.yaml

### Prerequisites

You will need to have a working installation of Singularity and Snakemake on the system. To allow the container to be used, snakemake must be run with the appropriate option. 

```
snakemake --use-singularity
```

