#!/bin/bash

#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --gpus=1
#SBATCH --cpus-per-gpu=4
#SBATCH --time=10-0:0
#note: time format: <days>-<hours>:<minutes>

SCRIPT_NAME="Template Job"
MCW_RESEARCH=/data/mcw_research

INPUT_DIR=$MCW_RESEARCH/from_disk_20200224
OUTPUT_DIR=$MCW_RESEARCH/tiles/prostate_he_tiles_0.5x_2

SCRIPT_PATH=$MCW_RESEARCH/python_image_prep/pyvips_WSI_to_tile.py
SCRIPT_ARGS="-i $INPUT_DIR -o $OUTPUT_DIR --count 10"

CONTAINER="/data/containers/msoe-tensorflow.sif"
COMMAND="python $SCRIPT_PATH $SCRIPT_ARGS"

## SCRIPT
echo "starting sbatch script: ${SCRIPT_NAME}"
date

echo Training Dataset: "$TRAINING_DATASET"
echo Using Container: "$CONTAINER"
echo Executing Command: "${COMMAND}"

srun singularity exec --nv -B /data:/data ${CONTAINER} /usr/local/bin/nvidia_entrypoint.sh "${COMMAND}"

echo "done we did it heck ya"
date
## END SCRIPT