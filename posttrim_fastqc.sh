#!/bin/bash

#SBATCH --account=def-idworkin
#SBATCH --mem-per-cpu=44072M
#SBATCH --time=12:00:00
#SBATCH --cpus-per-task=6
#SBATCH --output=fastqc_loop.out
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

module load StdEnv/2020

module load fastqc/0.11.9

input_dir=home/ighalok/projects/def-idworkin/ighalok/igernasoc/trimmed

out_dir=home/ighalok/projects/def-idworkin/ighalok/igernasoc/fastqc_trim

files=(${input_dir}/*.fastq.gz)

for file in ${files[@]}; do
  name=${file}
  sample_name=`basename ${name} .fastq.gz`
  echo "${out_dir}/${sample_name}_fastqc.zip"
  if [ ! -f "${out_dir}/${sample_name}_fastqc.zip" ]; then
    echo "Does Not Exist, so performing fastqc: "
    fastqc ${input_dir}/${sample_name}.fastq.gz -o home/ighalok/projects/def-idworkin/ighalok/igernasoc/fastqc_trim
  else
    echo "Already Complete"
  fi
done
