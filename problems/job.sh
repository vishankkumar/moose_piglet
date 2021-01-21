#!/bin/bash
# Submission script for Zenobe
#PBS -q main
#PBS -r y
#PBS -W group_list=2020038_HPCCOM_ABEE
#
#PBS -l walltime=00:01:00
#PBS -l select=1:mem=2625mb

exec > ${PBS_O_WORKDIR}/jobs/${PBS_JOBID}.log
echo "------------------ Work dir --------------------"
cd ${PBS_O_WORKDIR} && echo ${PBS_O_WORKDIR}
echo "------------------ Job Info --------------------"
echo "jobid : $PBS_JOBID"
echo "jobname : $PBS_JOBNAME"
echo "job type : $PBS_ENVIRONMENT"
echo "submit dir : $PBS_O_WORKDIR"
echo "queue : $PBS_O_QUEUE"
echo "user : $PBS_O_LOGNAME"
echo "threads : $OMP_NUM_THREADS"

module purge
source ~/miniconda3/etc/profile.d/conda.sh  
conda activate moose

mpirun -np 1 python hello.py
# mpirun -np 8 /home/abee/abee01/github/moose_projects/moose_piglet/moose_piglet-opt -i s3_decomp.i

qstat -f $PBS_JOBID
