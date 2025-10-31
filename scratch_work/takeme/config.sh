# defining the working and scripts dir here
export WORKING_DIR=/rs1/shares/brc/admin/get_containers_lsf

# setting the scripts dir
export SCRIPTS_DIR=$WORKING_DIR/run_scripts

# create the log dir if it doesn't exist
export LOGS_DIR=$WORKING_DIR/logs
export RESULTS_DIR=$WORKING_DIR/results 

# input datasets
export CONTAINER_LIST="$WORKING_DIR/container_list"

# output container dir
export CONTAINER_DIR=/rs1/shares/brc/admin/containers

# tool directory and list
export TOOL_DIR=/rs1/shares/brc/admin/tools/container-mod
export CONTAINER_MOD=$TOOL_DIR/container-mod
export PROFILE="brc"

# list of jobs to run
export JOB1="get_containers_01A"
export CHUNK_SIZE=50

# container-mod configurations
export JOB1_CPUS=8
export JOB1_QUEUE="shared_memory"
export JOB1_MEMORY="8GB"
export JOB1_TIME="1:00"

# Some custom functions for our scripts
#
# --------------------------------------------------
function init_dir {
    for dir in $*; do
        if [ -d "$dir" ]; then
            rm -rf $dir/*
        else
            mkdir -p "$dir"
        fi
    done
}

# --------------------------------------------------
function create_dir {
    for dir in $*; do
        if [[ ! -d "$dir" ]]; then
          echo "$dir does not exist. Directory created"
          mkdir -p $dir
        fi
    done
}

# --------------------------------------------------
function lc() {
    wc -l $1 | cut -d ' ' -f 1
}
