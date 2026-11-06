#!/bin/bash
#SBATCH -t 00-03:00:00
#SBATCH -A def-idworkin
#SBATCH --cpus-per-task=32
#SBATCH --mem=20G
#SBATCH --mail-user=ighalok@mcmaster.ca
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

module load fastqc/0.12.1
module load multiqc/1.35

# Set your analysis directory and output directory
INPUT_DIR="/home/ighalok/projects/def-idworkin/ighalok/igernasoc/fastqc_trimmed/"
OUTPUT_DIR="./multiqc_report"

# Run MultiQC
multiqc "$INPUT_DIR" -o "$OUTPUT_DIR"
