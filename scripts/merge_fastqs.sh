# This script should merge all files from a given sample (the sample id is
# provided in the third argument ($3)) into a single file, which should be
# stored in the output directory specified by the second argument ($2).
#
# The directory containing the samples is indicated by the first argument ($1).
if [ "$#" -ne 3 ]
then
    echo "Usage: $0 <samples_directory> <output_directory> <sample_id>"
    exit 1
fi
samdir=$1
outdir=$2
sampleid=$3
mkdir -p ~/decont/$outdir
cat ~/decont/$samdir/${sampleid}*.fastq.gz > ~/decont/$outdir/${sampleid}.fastq.gz
