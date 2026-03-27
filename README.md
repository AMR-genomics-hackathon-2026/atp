
# ATP: All the Plasmids/Phages

## Overview

ATP is a Nextflow-based pipeline for analysing the geNomad results from the ATB database. Presently working on a Pseudomonas aeruginosa subset, n = 695. GeNomad outputs contigs classified as plasmids and phages, the ATP pipeline will further analyse them using the following tools:

## Modules
- [RGI](https://github.com/arpcard/rgi)
- [MOB-RECON](https://github.com/phac-nml/mob-suite)
- [defense-finder](https://github.com/mdmparis/defense-finder)

## Prerequisites

- [Nextflow](https://www.nextflow.io/docs/latest/install.html)
- [conda/mamba](https://mamba.readthedocs.io/en/latest/installation/mamba-installation.html)
- [CARD](https://card.mcmaster.ca/download) for RGI

## Usage

### Basic Run

```bash
nextflow run main.nf --fasta <input.fasta>
```

## Output

Results are saved to the `results` directory.

## Support

For issues or questions, please open an issue on GitHub.
