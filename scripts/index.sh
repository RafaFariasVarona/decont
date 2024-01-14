# This script should index the genome file specified in the first argument ($1),
# creating the index in a directory specified by the second argument ($2).

# The STAR command is provided for you. You should replace the parts surrounded
# by "<>" and uncomment it.
if [ "$#" -ne 2 ]
then
    echo "Usage: $0 <contaminants_file> <output_directory>"
    exit 1
fi
mamba install -y star
contaminants_file=$1
outdir=$2
STAR --runThreadN 4 --runMode genomeGenerate --genomeDir ~/decont/$outdir \
--genomeFastaFiles ~/decont/$contaminants_file --genomeSAindexNbases 9
