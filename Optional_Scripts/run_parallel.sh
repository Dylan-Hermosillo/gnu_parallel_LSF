#! /bin/bash

CPUS=$JOB2_CPUS
PARALLEL=${PARALLEL}
cat $SCRIPTS_DIR/aggregate_prefetch_wrappers.txt | $PARALLEL -j $CPUS -a -