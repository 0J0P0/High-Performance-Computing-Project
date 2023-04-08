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

# nodes = number of nodes (4, 6, 8)
# cpus-per-task= MPI tasks per node


# bt-mz.D.x with 8 nodes
srun --nodes=8 --ntasks=16 --cpus-per-task=24 $NAS_PATH/bt-mz.D.16
srun --nodes=8 --ntasks=24 --cpus-per-task=16 $NAS_PATH/bt-mz.D.24
srun --nodes=8 --ntasks=32 --cpus-per-task=12 $NAS_PATH/bt-mz.D.32
srun --nodes=8 --ntasks=48 --cpus-per-task=8 $NAS_PATH/bt-mz.D.48
srun --nodes=8 --ntasks=64 --cpus-per-task=6 $NAS_PATH/bt-mz.D.64
srun --nodes=8 --ntasks=96 --cpus-per-task=4 $NAS_PATH/bt-mz.D.96
srun --nodes=8 --ntasks=192 --cpus-per-task=2 $NAS_PATH/bt-mz.D.192
srun --nodes=8 --ntasks=384 --cpus-per-task=1 $NAS_PATH/bt-mz.D.384



8 &16 & 24 \\
8 &24 & 16 \\
8 &32 & 12 \\
8 &48 & 8 \\
8 &64 & 6 \\
8 &96 & 4 \\
8 &192 & 2  \\
8 &384 & 1  \\