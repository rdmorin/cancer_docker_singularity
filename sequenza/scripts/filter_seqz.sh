#!/bin/bash

# Usage: 
#   merge_seqz.sh all.seqz.gz dbsnp.pos [rare_vars.pos] | gzip > all.filt.seqz.gz

set -euf -o pipefail

SEQZ_FILE="$1"
DBSNP_POS_FILE="$2"
RARE_VARIANTS_TMP=$(mktemp /tmp/merge_seqz.sh.XXXXXX)
RARE_VARIANTS="${3:-${RARE_VARIANTS_TMP}}"

BUFFER_SIZE="${BUFFER_SIZE:-20G}"

zcat "${SEQZ_FILE}" \
	| egrep -v "^chromosome" \
	| awk 'BEGIN {FS="\t"} $9 == "het" {print $1 ":" $2}' \
	| sort -S "${BUFFER_SIZE}" \
	| comm - "${DBSNP_POS_FILE}" -2 -3 \
	| tr ":" "\t" \
	> "${RARE_VARIANTS}"

if [[ $SEQZ_BLACKLIST_BED_FILES != "" ]]; then
	zcat "${SEQZ_FILE}" \
		| awk 'BEGIN {FS=OFS="\t"} NR > 1 && $9 == "het" {print $1, $2-1, $2}' \
		| bedtools intersect -wa -a stdin -b $SEQZ_BLACKLIST_BED_FILES \
		| awk 'BEGIN {FS=OFS="\t"} {print $1, $3}' \
		>> "${RARE_VARIANTS}"
fi

zgrep -v -F -f "${RARE_VARIANTS}" "${SEQZ_FILE}"

rm -f "${RARE_VARIANTS_TMP}"
