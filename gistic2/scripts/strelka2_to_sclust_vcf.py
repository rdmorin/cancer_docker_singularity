import sys
import vcfpy

vcf_infile  = sys.argv[1]

reader = vcfpy.Reader.from_path(vcf_infile)

print("##fileformat=VCFv4.2")
print('#INFO=<ID=DP,Number=1,Type=Integer,Description="Read Depth Tumor">')
print('##INFO=<ID=DP_N,Number=1,Type=Integer,Description="Read Depth Normal">')
print('##INFO=<ID=AF,Number=A,Type=Float,Description="Allelic Frequency Tumor">')
print('##INFO=<ID=AF_N,Number=A,Type=Float,Description="Allelic Frequency Normal">')
print('##INFO=<ID=FR,Number=1,Type=Float,Description="Forward-Reverse Score">')
print('##INFO=<ID=TG,Number=1,Type=String,Description="Target Name (Genome Partition)">')
print('##INFO=<ID=DB,Number=0,Type=Flag,Description="dbSNP Membership">')
print('#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO')

for record in reader:
    if not record.is_snv(): 
        continue
    chrm = str(record.CHROM)
    pos  = str(record.POS)
    ID   = "."
    qual = "."
    filt = ";".join(record.FILTER)
    n_allele = str(record.REF)
    t_allele = record.ALT[0].serialize()

    normal = record.calls[0]
    tumour = record.calls[1]

    n_dp = normal.data["DP"]
    t_dp = tumour.data["DP"]
    n_ad = normal.data[f"{n_allele}U"][0]
    t_ad = tumour.data[f"{t_allele}U"][0]
    n_af = 0
    t_af = t_ad/t_dp

    info_field = f"DP={t_dp};DP_N={n_dp};AF={t_af};AF_N={n_af};.;.;."

    out_rec = [chrm, pos, ID, n_allele, t_allele, qual, filt, info_field]
    print('\t'.join(out_rec))

