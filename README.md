# LSF Generation for GNU Parallel Processing on Login Node
This workflow pipeline consist of using LSF to mass create wrapper scripts to run through GNU Parallel for multiple job handling on a single login node.

Each login node contained 16-32 CPUs, where each task can be divided into a single CPU. For brevity (and to not get yelled at), lets keep is a conservative 6-8 CPU limit.

You might be asking; why do this when we have hpc with LSF? Certain HPC's lack internet connection on computer nodes, therefore for internet specific tasks (Container Pulling, SRA Toolkit, etc.) we need to run the jobs on the login node. Instead of working manually we can automate a pipeline to just carry the jobs through for us.

## Abstract Pipeline Blueprint
This is an abstraction of how the pipeline works to generate wrappers and run things automatically though LSF and GNU

### 1. Configuration Layer (Config.sh)
File: Config (abstracted name)

Purpose: Define global parameters, paths, and utility functions.

One-line summary: Provides all configuration and helper functions required by the pipeline (logs, directories, variables, etc.)

Data Flow: Supplies settings and utilities to all subsequent pipeline components.

### 2. Task Scheduling Layer (Launch.sh)
File: Launcher (abstracted name)

Purpose: Divide input data into tasks and submit them for execution.

One-line summary: Splits the workload and schedules tasks for execution on a compute system.

Data Flow: Input dataset → scheduled tasks (each corresponding to one or more items). 

Consumes: INPUT_LIST, and Config Variables
Produces: Scheduled LSF tasks

### 3. Task Generation Layer (01_do_something.sh)
File: TaskGenerator (abstracted name)

Purpose: Transform each scheduled task into an executable unit or script.

One-line summary: Generates individual executable commands/scripts for each scheduled task.

Data Flow: Scheduled task + input item → executable unit (command/script).

Consumes: Single item from INPUT_LIST
Produces: Wrapper script in RESULTS_DIR

### 4. Command Aggregation Layer (all_commands.txt)
File: CommandCollector (abstracted name)

Purpose: Collect all executable units into a single list for node-level execution.

One-line summary: Aggregates all executable units into a unified command list for parallel execution.

Data Flow: Executable units → aggregated command list.

Consumes: Wrapper scripts from RESULTS_DIR
Produces: all_commands.txt for GNU parallel execution

### 5. Node-level Parallel Execution Layer (run_parallel.sh)
File: NodeExecutor (abstracted name)

Purpose: Execute multiple tasks concurrently on a single node.

One-line summary: Runs tasks from the command list in parallel on a single compute node.

Data Flow: Aggregated command list → parallel execution → outputs/logs

Consumes: all_commands.txt
Produces: Expectected results and logs

## Basic Flowchart
```
[Config.sh] 
    ↓ provides config & functions
[launch.sh] 
    ↓ submits array jobs per input item
[01A_get_something.sh] 
    ↓ generates wrapper scripts for each item
[RESULTS_DIR/*.sh] 
    ↓ aggregated into all_commands.txt
[run_parallel.sh] 
    ↓ executes all wrapper scripts in parallel (node-level)
OUTPUT: results and logs for all items
```

