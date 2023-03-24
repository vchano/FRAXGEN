#!/bin/bash
#-------------------------------------------------------------------------------

##################################################################
#                                                                #
#                       FastQC in rawreads                       #
#                                                                #
##################################################################

#-------------------------------------------------------------------------------
#
#    Forest Genetics and Forest Tree Breeding
#    Büsgenweg 
#    Georg-August-Universtät Göttingen
#    https://github.com/vchano/
#
# Licence: GNU General Public Licence Version 3
#-------------------------------------------------------------------------------

#SBATCH -p medium
#SBATCH -A all
#SBATCH -n 96
#SBATCH -N 1
#SBATCH --job-name=FRX.FQC1
#SBATCH --output=FASTQC1_FRAXGEN_%J_out.txt
#SBATCH --error=FASTQC1_FRAXGEN_%J_err.txt
#SBATC --exclusive
#SBATCH --ntasks-per-socket 24
#SBATC --qos long
#SBATCH --time=6:00:00
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-user=vmchano.gaug@gmail.com


# Load modules

module load fastqc/0.11.4
module load anaconda3/2020.11

# Set PATHS to working directories
INPUT=$SCRATCH/FRAXGEN/0.RAWDATA
OUTPUT=$SCRATCH/FRAXGEN/1.QC/RAWDATA

# Run FastQC
fastqc $INPUT/*.fastq.gz --outdir $OUTPUT --threads 96

# Run MultiQC
source activate multiqc
multiqc $OUTPUT/
conda deactivate


#-------------------------------------------------------------------------------

# End
echo '**************************************************'
exit 0

#-------------------------------------------------------------------------------
# Excute this script as sbatch $SCRATCH/TGC_WES/APPS/1.tgc_wes_fastqc.rd.sh
#-------------------------------------------------------------------------------
