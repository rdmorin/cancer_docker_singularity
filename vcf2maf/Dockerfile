FROM ensemblorg/ensembl-vep
USER root
RUN apt-get update && apt-get install wget && wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
USER vep
RUN bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/vep/anaconda && echo 'export PATH="/opt/vep/anaconda/bin:$PATH"' >> /opt/vep/.profile && rm -f Miniconda3-latest-Linux-x86_64.sh
ENV PATH "$PATH:/opt/vep/anaconda/bin"
RUN conda init bash && conda update -n base -c defaults conda 
RUN conda install -c bioconda vcf2maf && conda update -n base -c defaults conda
ENTRYPOINT ["/bin/bash", "-c"]


