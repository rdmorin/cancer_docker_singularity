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

### Optional

The singularity container is derived directly from the genepattern/docker-gistic container. The dockerfile detailing its configuration is included here along with the Singularity definition file. The latter was modified to allow the external libraries used by Matlab to be available. If you are so inclined, you may choose to rebuild these with different configurations. 
