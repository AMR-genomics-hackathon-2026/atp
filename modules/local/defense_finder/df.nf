process DEFENSE_FINDER {
    tag "${meta}"
    publishDir "${params.outdir}/defense_finder", mode: 'copy', pattern: "defensefinder_merged.tsv", overwrite: true
    conda "${moduleDir}/df.yml"

    input:
    tuple val(meta), path(fasta)

    output:
    tuple val(meta), path("defensefinder_merged.tsv"), emit: tsv

    script:
    """
    sh ${moduleDir}/run_defense_finder.sh ${fasta} 
    """
    stub:
    """
    touch defensefinder_merged.tsv
    """
}