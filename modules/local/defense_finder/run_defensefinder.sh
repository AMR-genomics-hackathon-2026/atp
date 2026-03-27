#!/bin/bash
#run: run_defensefinder.sh /pathway/to/input/

#input fastas
INPUT_FASTAS="$1"

#output
OUT_DIR="defensefinder_results"
MERGED="defensefinder_merged.tsv"

mkdir -p "$OUT_DIR"
> "$MERGED"

echo "�� Processing files in: $INPUT_DIR"

first=true

for fasta in $INPUT_FASTAS; do
    [ -e "$fasta" ] || continue

    #get BioSample name
    sample=$(basename "$fasta" _plasmid.fna)

    #match output name
    outdir="$OUT_DIR/${sample}_defensefinder"

    #run DefenseFinder
    defense-finder run --antidefensefinder -o "$outdir" "$fasta"

    #output file name from DefenseFinder
    result="$outdir/${sample}_plasmid_defense_finder_systems.tsv"

    #skip if no output
    [ -f "$result" ] || { echo "No result for $sample"; continue; }

    if $first; then
        # write header once
        echo -e "sample\t$(head -n 1 "$result")" >> "$MERGED"
        first=false
    fi

    #append data with sample column
    tail -n +2 "$result" | awk -v s="$sample" '{print s "\t" $0}' >> "$MERGED"

done
