#Download all the files specified in data/urls
#echo "Downloading the sequencing data files..."
#for url in $(cat ~/decont/data/urls)
#do
  #  bash ~/decont/scripts/download.sh $url data
#done

# Download the contaminants fasta file, uncompress it, and
# filter to remove all small nuclear RNAs
#echo "Downloading the contaminants database and filtering it..."
#bash ~/decont/scripts/download.sh https://bioinformatics.cnio.es/data/courses/decont/contaminants.fasta.gz res yes

# Index the contaminants file
#echo "Indexing the contaminants database..."
#bash ~/decont/scripts/index.sh res/filtered_contaminants.fasta res/contaminants_idx

# Merge the samples into a single file
#echo "Merging the fastqs from the same sample into a single file..."
#for sid in $(ls ../data/*.fastq.gz | cut -d"-" -f1 | sed "s:../data/::" | sort | uniq)
#do
#    bash ~/decont/scripts/merge_fastqs.sh data out/merged $sid
#done

# TODO: run cutadapt for all merged files
#echo "Running cutadapt..."
#mamba install -y cutadapt
#mkdir -p ~/decont/log/cutadapt
#mkdir -p ~/decont/out/trimmed
#for sid in $(ls ../data/*.fastq.gz | cut -d"-" -f1 | sed "s:../data/::" | sort | uniq)
#do
#    cutadapt -m 18 -a TGGAATTCTCGGGTGCCAAGG --discard-untrimmed \
#    -o ~/decont/out/trimmed/${sid}.trimmed.fastq.gz ~/decont/out/merged/${sid}.fastq.gz > ~/decont/log/cutadapt/${sid}.log
#done

# TODO: run STAR for all trimmed files
echo "Running star..."
for sid in $(ls ../data/*.fastq.gz | cut -d"-" -f1 | sed "s:../data/::" | sort | uniq)
do
    mkdir -p ~/decont/out/star/$sid
    STAR --runThreadN 4 --genomeDir ~/decont/res/contaminants_idx \
         --outReadsUnmapped Fastx --readFilesIn ~/decont/out/trimmed/${sid}.trimmed.fastq.gz \
         --readFilesCommand gunzip -c --outFileNamePrefix ~/decont/out/star/$sid/
done 

# TODO: create a log file containing information from cutadapt and star logs
# (this should be a single log file, and information should be *appended* to it on each run)
# - cutadapt: Reads with adapters and total basepairs
# - star: Percentages of uniquely mapped reads, reads mapped to multiple loci, and to too many loci
# tip: use grep to filter the lines you're interested in
