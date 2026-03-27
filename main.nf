#!/usr/bin/env nextflow
// main script to exceute the all the plasmids/phage analysis pipeline using the modules created for each tool.

// establish input channels

Channel
    .fromPath(params.fasta)
    .map { tuple(it.baseName, it) }
    .set { fasta }

// Import processes
include {RGI_MAIN} from "${projectDir}/modules/nf-core/rgi/main/main.nf"
include {DEFENSE_FINDER} from "${projectDir}/modules/local/defense_finder/df.nf"
include {MOB_RECON} from "${projectDir}/modules/local/mob-suite/mob.nf"

workflow {
    // check that databases have been provided
    if (params.card == "specify_path") {
        error "ERROR: CARD database path must be specified in nextflow.config, default is CARD protein homolog fasta"
    }
    RGI_MAIN(fasta, params.card)
    DEFENSE_FINDER(fasta)
    MOB_RECON(fasta)
}