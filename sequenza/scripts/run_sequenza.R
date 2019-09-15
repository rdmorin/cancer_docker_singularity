suppressPackageStartupMessages({
    library(sequenza)
    library(readr)
    library(dplyr)
})

args <- commandArgs(trailingOnly = TRUE)

seqz <- args[1]
out <- args[2]
sample_id <- args[3]
#num.cores <- as.integer(args[4])

#if(is.null(num.cores)){
#    num.cores <- getOption("mc.cores", 2L)
#}

is_female = TRUE
chrs <- paste0('chr', c(seq(1,22), 'X'))
sex_chroms <- c(X = "chrX", Y = "chrY")

ploidies <- seq(1.8, 2.5, 0.1)
cellularities <- seq(0.1,1,0.01)

seq_extract <- 
    sequenza.extract(
        seqz,
        assembly = "hg38", 
        chromosome.list = chrs)

seq_fit <- 
    sequenza.fit(seq_extract, 
                 female = is_female,
                 chromosome.list = chrs)

tryCatch(
    sequenza.results(seq_extract, 
                     seq_fit, 
                     out.dir = out, 
                     chromosome.list = chrs, 
                     XY = sex_chroms,
                     female = is_female, 
                     sample.id = sample_id, 
                     CNt.max = 6),
    error = function(e) {print(paste0("Error in sample: ", sample_id))}
)
