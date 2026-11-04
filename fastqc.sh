#!/bin/bash
#SBATCH -t 00-05:00:00
#SBATCH -A def-idworkin
#SBATCH --cpus-per-task=32
#SBATCH --mem=0
#SBATCH --mail-user=ighalok@mcmaster.ca
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL


echo "Current working directory: `pwd`"
echo "Starting job $SLURM_ARRAY_JOB_ID at: `date` "

module load fastqc/0.12.1
parallel --will-cite --jobs $SLURM_CPUS_PER_TASK fastqc -t 1  \
-o /home/ighalok/projects/def-idworkin/ighalok/ige_rna_sociability/rawData/ {} \
::: /home/ighalok/projects/def-idworkin/ighalok/ige_rna_sociability/rawData/NS*.gz

echo "Job $SLURM_ARRAY_JOB_ID finished w exit code $? at: `date` "
