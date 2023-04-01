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
# 28024843.0|07:44:00|192|192|167.05K|154K|bt-mz.D.8|00:02:25|
srun --nodes=4 --ntasks=192 --cpus-per-task=1 $NAS_PATH/bt-mz.D.192
# 28024861.0|05:20:00|192|192|140.67K|1.89G|bt-mz.D.192|00:01:40|

srun --nodes=8 --ntasks=16 --cpus-per-task=24 $NAS_PATH/bt-mz.D.16
# 28024862.0|07:53:36|384|384|171.94K|28.29M|bt-mz.D.16|00:01:14|
srun --nodes=8 --ntasks=384 --cpus-per-task=1 $NAS_PATH/bt-mz.D.384
# 28024867.0|07:21:36|384|384|182.28K|5.26G|bt-mz.D.384|00:01:09|

srun --nodes=4 --ntasks=8 --cpus-per-task=24 $NAS_PATH/sp-mz.D.8
# 28024930.0|04:48:00|192|192|112.23K|900K|sp-mz.D.8|00:01:30
srun --nodes=4 --ntasks=192 --cpus-per-task=1 $NAS_PATH/sp-mz.D.192
# 28024931.0|04:03:12|192|192|124.08K|974.15M|sp-mz.D.192|00:01:16

srun --nodes=8 --ntasks=16 --cpus-per-task=24 $NAS_PATH/sp-mz.D.16
# 28024934.0|05:00:48|384|384|112.56K|44.75M|sp-mz.D.16|00:00:47
srun --nodes=8 --ntasks=384 --cpus-per-task=1 $NAS_PATH/sp-mz.D.384
# 28024939.0|04:28:48|384|384|130.08K|14.94G|sp-mz.D.384|00:00:42

