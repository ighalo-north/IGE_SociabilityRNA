#!/bin/bash
#SBATCH -t 00-03:00:00
#SBATCH -A def-idworkin
#SBATCH --cpus-per-task=32
#SBATCH --array=0-22
#SBATCH --mem=20G
#SBATCH --mail-user=ighalok@mcmaster.ca
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

module load fastqc/0.12.1
parallel --will-cite --jobs $SLURM_CPUS_PER_TASK fastqc -t 1  \
-o /home/ighalok/projects/def-idworkin/ighalok/igernasoc/fastqc_trim/ \
{} \
::: /home/ighalok/projects/def-idworkin/ighalok/igernasoc/trimmed/*trimmed.fastq.gz
