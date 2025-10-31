#!/bin/bash
#BSUB -R "span[hosts=1]"
#BSUB -o "./logs/output.01A.%J_%I.log"    # Standard output file (%J is job ID)
#BSUB -e "./logs/error.01A.%J_%I.log"     # Standard error file (%J is job ID)

# This script creates all of the databases needed for running the metags against

# load environment
pwd; hostname; date
source ./config.sh

# get the current container to get
JOBINDEX=$(($LSB_JOBINDEX - 1))
containers=($(cat ${CONTAINER_LIST}))
CONTAINER_PATH=${containers[${JOBINDEX}]}

echo "$CONTAINER_PATH started: `date`"
CONTAINER_NAME=$(basename "$CONTAINER_PATH")

# Set IFS to the delimiter (:)
IFS=':' read -r -a container_parts <<< "$CONTAINER_NAME"

# CONTAINER_NAME:  bbmap:39.33--he5f24ec_0
tool=${container_parts[0]} # string before :
version=${container_parts[1]} # version
version_num=$(echo $version | sed 's/--.*//')

if [[ ! -d "$CONTAINER_DIR/$tool/$version_num" ]]; then
	    printf "%s: %s\n" $tool $version_num 
	# if the container doesn't exist run container_mod 
	echo "running this:"
	echo "$CONTAINER_MOD pipe -t --profile $PROFILE $CONTAINER_PATH"
	echo "$CONTAINER_MOD pipe -t --profile $PROFILE $CONTAINER_PATH" > $RESULTS_DIR/${tool}_${version_num}.sh
	chmod 755 $RESULTS_DIR/${tool}_${version_num}.sh
fi

echo "finished getting $tool $version_num: `date`"
