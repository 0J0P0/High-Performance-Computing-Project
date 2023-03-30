#!/bin/bash

# make from 8 to 384 processes for bt-mz.D.x
make bt-mz CLASS=D NPROCS=8
make bt-mz CLASS=D NPROCS=12
make bt-mz CLASS=D NPROCS=16
make bt-mz CLASS=D NPROCS=18
make bt-mz CLASS=D NPROCS=24
make bt-mz CLASS=D NPROCS=32
make bt-mz CLASS=D NPROCS=36
make bt-mz CLASS=D NPROCS=48
make bt-mz CLASS=D NPROCS=64
make bt-mz CLASS=D NPROCS=72
make bt-mz CLASS=D NPROCS=96
make bt-mz CLASS=D NPROCS=128
make bt-mz CLASS=D NPROCS=144
make bt-mz CLASS=D NPROCS=192
make bt-mz CLASS=D NPROCS=288
make bt-mz CLASS=D NPROCS=384

# make from 8 to 384 processes for sp-mz.D.x
make bt-mz CLASS=D NPROCS=8
make bt-mz CLASS=D NPROCS=12
make bt-mz CLASS=D NPROCS=16
make bt-mz CLASS=D NPROCS=18
make bt-mz CLASS=D NPROCS=24
make bt-mz CLASS=D NPROCS=32
make bt-mz CLASS=D NPROCS=36
make bt-mz CLASS=D NPROCS=48
make bt-mz CLASS=D NPROCS=64
make bt-mz CLASS=D NPROCS=72
make bt-mz CLASS=D NPROCS=96
make bt-mz CLASS=D NPROCS=128
make bt-mz CLASS=D NPROCS=144
make bt-mz CLASS=D NPROCS=192
make bt-mz CLASS=D NPROCS=288
make bt-mz CLASS=D NPROCS=384

# make from 8 to 16 processes for lu-mz.D.x
make lu-mz CLASS=D NPROCS=8
make lu-mz CLASS=D NPROCS=12
make lu-mz CLASS=D NPROCS=16
