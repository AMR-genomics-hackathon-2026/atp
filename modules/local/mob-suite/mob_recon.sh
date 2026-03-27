#!/bin/bash
# excecution: sh mob_recon.sh /path/to/genomes_dir

# =========================
# CONFIGURATION
# =========================

# Directories
FASTAS="$1"
MOBSUITE="/path/to/mobsuite"
ERROR_LOG="/path/to/mobsuite_errors.log"

# Other settings
THREADS=8
DATE=$(date +%Y%m%d)
shopt -s nullglob

# Create required directories
mkdir -p "$MOBSUITE"
mkdir -p "$(dirname "$ERROR_LOG")"



# =========================
# EXECUTION
# =========================

for fasta_file in $FASTAS; do

    f=$(basename "$fasta_file" .fasta)

    echo "Running MobSuite for ${f}"

    if ! mob_recon \
        --num_threads "${THREADS}" \
        --infile "$fasta_file" \
        --outdir "${MOBSUITE}/${f}" \
        --sample_id "${f}" \
        --prefix "${f}" \
        --keep_tmp 2>>"$ERROR_LOG"; then
        
        echo "⚠️ ERROR: MobSuite failed for ${f}" >> "$ERROR_LOG"
    else
        echo "✅ MobSuite finished for ${f}" >> "$ERROR_LOG"
    fi

done




# =========================
# SUMMARY OUTPUTS
# =========================

head -n 1 "${MOBSUITE}"/*/*.mobtyper_results.txt | head -n 1 > "${MOBSUITE}/MOBTyper-summary_${DATE}.csv"
tail -n +2 -q "${MOBSUITE}"/*/*.mobtyper_results.txt >> "${MOBSUITE}/MOBTyper-summary_${DATE}.csv"
