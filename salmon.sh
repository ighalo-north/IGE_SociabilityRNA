#!/bin/bash

#SBATCH --account=def-idworkin
#SBATCH --mem-per-cpu=8G
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=8
#SBATCH --array=0-21
#SBATCH --mail-user=ighalok@mcmaster.ca
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --output=salmon.out

module load StdEnv/2020  gcc/9.3.0  openmpi/4.0.3

module load salmon/1.4.0

#salmon index -t dmel-all-transcript-r6.25.fasta -i ./salmon_index/dmel-all-transcript_r6.25_index

index_dir=/home/ighalok/projects/def-idworkin/ighalok/igernasoc/ref/dmel-all-transcript_r6.67_index

trim_dir=/home/ighalok/projects/def-idworkin/ighalok/igernasoc/trimmed

counts_dir=/home/ighalok/projects/def-idworkin/ighalok/igernasoc/salmoncounts

# Build sorted list of R1 files, pick the one matching this array task
files=(${trim_dir}/*_R1_trimmed.fastq.gz)
file=${files[$((SLURM_ARRAY_TASK_ID - 1))]}
 
if [ -z "${file}" ] || [ ! -f "${file}" ]; then
    echo "No file for array task ${SLURM_ARRAY_TASK_ID}; array range is larger than the number of samples."
    exit 1
fi
 
sample_name=$(basename "${file}" _R1_PE.fastq.gz)
out_dir=${counts_dir}/${sample_name}_quant
 
echo "Task ${SLURM_ARRAY_TASK_ID}: sample ${sample_name}"
 
salmon quant -i "${index_dir}" -l A \
    -1 "${trim_dir}/${sample_name}_R1_trimmed.fastq.gz" \
    -2 "${trim_dir}/${sample_name}_R2_trimmed.fastq.gz" \
    -p ${SLURM_CPUS_PER_TASK} --validateMappings --rangeFactorizationBins 4 \
    --seqBias --gcBias \
    -o "${out_dir}"
