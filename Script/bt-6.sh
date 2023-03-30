#!/bin/bash
#SBATCH --job-name=bt-mz
#SBATCH --output=bt-mz_%j.out
#SBATCH --error=bt-mz_%j.err
#SBTACH --nodes=4
#SBATCH --ntasks=192
#SBATCH --cpus-per-task=24
#SBATCH --qos=debug

# Modificad esta linea con vuestro PATH a los ejecutables
export NAS_PATH=/home/nct01/nct01175/S2/NPB3.3.1-MZ/NPB3.3-MZ-MPI/bin

echo "Using $SLURM_NTASKS processes and $SLURM_CPUS_PER_TASK threads per process"
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# bt-mz.D.x with 6 nodes
srun --nodes=6 --ntasks=12 --cpus-per-task=24 $NAS_PATH/bt-mz.D.12
srun --nodes=6 --ntasks=18 --cpus-per-task=16 $NAS_PATH/bt-mz.D.18
srun --nodes=6 --ntasks=24 --cpus-per-task=12 $NAS_PATH/bt-mz.D.24
srun --nodes=6 --ntasks=36 --cpus-per-task=8 $NAS_PATH/bt-mz.D.36
srun --nodes=6 --ntasks=48 --cpus-per-task=6 $NAS_PATH/bt-mz.D.48
srun --nodes=6 --ntasks=72 --cpus-per-task=4 $NAS_PATH/bt-mz.D.72
srun --nodes=6 --ntasks=144 --cpus-per-task=2 $NAS_PATH/bt-mz.D.144
srun --nodes=6 --ntasks=288 --cpus-per-task=1 $NAS_PATH/bt-mz.D.288



