#!/bin/bash
#SBATCH --account=def-idworkin
#SBATCH --array=0-21
#SBATCH --cpus-per-task=32
#SBATCH --mem=16G
#SBATCH --time=2:00:00
#SBATCH --mail-user=ighalok@mcmaster.ca
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --array=0-21          #(number of R1 files - 1), e.g. 0-23 for 24 samples

module load bbmap/39.06

raw_dir=/home/ighalok/projects/def-idworkin/ighalok/igernasoc/rawData
trim_dir=/home/ighalok/projects/def-idworkin/ighalok/igernasoc/trimmed

adapters=/home/ighalok/scratch/AllAdapters.fa

forward=(${raw_dir}/*_R1.fastq.gz)
R1var=${forward[${SLURM_ARRAY_TASK_ID}]}

filename=${R1var##*/}
base=${filename%_R1.fastq.gz}

sample=day${base#*.day}    # -> day2_F_C

bbduk.sh -Xmx12g \
in1=${raw_dir}/${base}_R1.fastq.gz \
in2=${raw_dir}/${base}_R2.fastq.gz \
out1=${trim_dir}/${sample}_R1_trimmed.fastq.gz \
out2=${trim_dir}/${sample}}_R2_trimmed.fastq.gz \
ref=${adapters} \
threads=${SLURM_CPUS_PER_TASK} ktrim=r k=23 mink=11 hdist=1 tpe tbo \
qtrim=rl trimq=10 minlength=36 \
stats=${trim_dir}/${sample}_bbduk_stats.txt



