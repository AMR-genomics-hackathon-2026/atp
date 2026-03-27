process MOB_RECON {

    tag "${meta}"
    conda "${moduleDir}/mob.yml"
    publishDir "${params.outdir}/mob_suite", mode: 'copy', pattern: "*.csv", overwrite: true

    input:
    tuple val(meta), path(fasta)
  
    output:
    tuple val(meta), path("*.csv"), emit: csv
  
    script:
    """
    sh ${moduleDir}/mob_recon.sh ${fasta}
    """
    stub:
    """
    touch mobtyper_results.csv
    """
}