#!/bin/bash
#SBATCH --job-name=sp-mz
#SBATCH --output=./out/sp-mz_%j.out
#SBATCH --error=./err/sp-mz_%j.err
#SBTACH --nodes=4
#SBATCH --ntasks=384
#SBATCH --qos=debug

# Modificad esta linea con vuestro PATH a los ejecutables
export NAS_PATH=/home/nct01/nct01175/Project/NPB3.3.1-MZ/NPB3.3-MZ-MPI/bin

echo "Using $SLURM_NTASKS processes and $SLURM_CPUS_PER_TASK threads per process"
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK


srun --nodes=8 --ntasks=16 --cpus-per-task=24 $NAS_PATH/sp-mz.D.16
srun --nodes=8 --ntasks=24 --cpus-per-task=16 $NAS_PATH/sp-mz.D.24
srun --nodes=8 --ntasks=32 --cpus-per-task=12 $NAS_PATH/sp-mz.D.32
srun --nodes=8 --ntasks=48 --cpus-per-task=8 $NAS_PATH/sp-mz.D.48
srun --nodes=8 --ntasks=64 --cpus-per-task=6 $NAS_PATH/sp-mz.D.64
srun --nodes=8 --ntasks=96 --cpus-per-task=4 $NAS_PATH/sp-mz.D.96
srun --nodes=8 --ntasks=192 --cpus-per-task=2 $NAS_PATH/sp-mz.D.192
srun --nodes=8 --ntasks=384 --cpus-per-task=1 $NAS_PATH/sp-mz.D.384



