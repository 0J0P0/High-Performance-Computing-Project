#!/bin/bash
#SBATCH --job-name=lu-mz
#SBATCH --output=./out/lu-mz_%j.out
#SBATCH --error=./err/lu-mz_%j.err
#SBTACH --nodes=4
#SBATCH --ntasks=16
#SBATCH --qos=debug

# Modificad esta linea con vuestro PATH a los ejecutables
export NAS_PATH=/home/nct01/nct01175/Project/NPB3.3.1-MZ/NPB3.3-MZ-MPI/bin

echo "Using $SLURM_NTASKS processes and $SLURM_CPUS_PER_TASK threads per process"
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK


srun --nodes=4 --ntasks=8 --cpus-per-task=24 $NAS_PATH/lu-mz.D.8
srun --nodes=4 --ntasks=12 --cpus-per-task=16 $NAS_PATH/lu-mz.D.12
srun --nodes=4 --ntasks=16 --cpus-per-task=12 $NAS_PATH/lu-mz.D.16


srun --nodes=6 --ntasks=12 --cpus-per-task=24 $NAS_PATH/lu-mz.D.12


srun --nodes=8 --ntasks=16 --cpus-per-task=24 $NAS_PATH/lu-mz.D.16

# version secuencial para el calculo del speedup empirico
# srun --nodes=1 --ntasks=8 --cpus-per-task=1 $NAS_PATH/lu-mz.D.8