#!/bin/bash
#SBATCH --account=def-idworkin


```{bash}
dir=/2/scratch/Bio722/Drosophila_RNA
name=subset_samw_17C_gen_fed_R1_TAGCTT_L002
dir_out=/2/scratch/Bio722/Drosophila_RNA/trimmedReads

java -jar /usr/local/trimmomatic/trimmomatic-0.36.jar PE -threads 12 \
  ${dir}/${name}_R1_001.fastq ${dir}/${name}_R2_001.fastq \
  ${dir_out}/${name}_1_pe.fastq ${dir_out}/${name}_1_se.fastq \
  ${dir_out}/${name}_2_pe.fastq ${dir_out}/${name}_2_se.fastq \
  ILLUMINACLIP:/2/scratch/Bio722_2019/ID/BBMap_adapters.fa:2:30:10 LEADING:3 TRAILING:3 MAXINFO:20:0.2 MINLEN:36
```



#!/bin/bash
#SBATCH --account=def-idworkin
#SBATCH --array=0-114
#SBATCH --cpus-per-task=8
#SBATCH --mem=10G
#SBATCH --time=1:00:00
#SBATCH --mail-user=ighalok@mcmaster.ca
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

module load bbmap/39.06

in=/home/ighalok/scratch/FC_DNA_genome
out=/home/ighalok/scratch/FC_trimmed

forward=(${in}/*_R1.fastq.gz)

R1var=${forward[${SLURM_ARRAY_TASK_ID}]}
adaptors=/home/ighalok/scratch/AllAdapters.fa

filename=${R1var##*/}
base=${filename%_R1.fastq.gz}

bbduk.sh \
in1=${in}/${base}_R1.fastq.gz  \
in2=${in}/${base}_R2.fastq.gz \
out1=${out}/${base}_R1_trimmed.fastq.gz \
out2=${out}/${base}_R2_trimmed.fastq.gz \
ref=${adaptors} \
threads=32 ktrim=r k=31 mink=8 hdist=1 tpe tbo \
qtrim=rl trimq=20 minlength=36 maq=20 minlen=36

