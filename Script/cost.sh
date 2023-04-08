#!/bin/bash
#SBATCH --job-name=bt-mz
#SBATCH --output=bt-mz_%j.out
#SBATCH --error=bt-mz_%j.err
#SBTACH --nodes=4
#SBATCH --ntasks=192
#SBATCH --cpus-per-task=24
#SBATCH --qos=debug

# Modificad esta linea con vuestro PATH a los ejecutables
export NAS_PATH=/home/nct01/nct01175/Project/NPB3.3.1-MZ/NPB3.3-MZ-MPI/bin

echo "Using $SLURM_NTASKS processes and $SLURM_CPUS_PER_TASK threads per process"
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK


srun --nodes=4 --ntasks=8 --cpus-per-task=24 $NAS_PATH/bt-mz.D.8
srun --nodes=4 --ntasks=192 --cpus-per-task=1 $NAS_PATH/bt-mz.D.192

srun --nodes=8 --ntasks=16 --cpus-per-task=24 $NAS_PATH/bt-mz.D.16
srun --nodes=8 --ntasks=384 --cpus-per-task=1 $NAS_PATH/bt-mz.D.384

srun --nodes=4 --ntasks=8 --cpus-per-task=24 $NAS_PATH/sp-mz.D.8
srun --nodes=4 --ntasks=192 --cpus-per-task=1 $NAS_PATH/sp-mz.D.192

srun --nodes=8 --ntasks=16 --cpus-per-task=24 $NAS_PATH/sp-mz.D.16
srun --nodes=8 --ntasks=384 --cpus-per-task=1 $NAS_PATH/sp-mz.D.384

