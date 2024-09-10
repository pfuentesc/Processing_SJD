#!/bin/bash

../../test_compress.sh

# Find NIFTI files
# Common files
t1file=$(find ./ -iname *AX_T1*.nii.gz )
t2file=$(find ./ -iname *SAG_T2*.nii.gz)
flairfile=$(find ./ -iname *FLAIR*.nii.gz)
b0file=$(find ./ -iname *B0*.nii.gz)
restingfile=$(find ./ -iname *RESTING*.nii.gz)
t1carafile=$(find ./ -iname *sT1W_3D_TFE*.nii.gz)

# Tasks
# FEPs/Cannabis/Mania
reward1file=$(find ./ -iname *Reward_1*.nii.gz)
reward2file=$(find ./ -iname *Reward_2*.nii.gz)
cmetfile=$(find ./ -iname *CMET*.nii.gz)
nbackfile=$(find ./ -iname *N_BACK*.nii.gz)
iapsfile=$(find ./ -iname *IAPS*.nii.gz)
metrofile=$(find ./ -iname *METRO*.nii.gz)

# AVH
alucinacionesfile=$(find ./ -iname *ALUCINACIONES*.nii.gz)
capturafile=$(find ./ -iname *CAPTURA*.nii.gz)
memoriafile=$(find ./ -iname *MEMORIA*.nii.gz)
rimasfile=$(find ./ -iname *RIMAS*.nii.gz)

# Lesex
produccionfile=$(find ./ -iname *PRODUCCION*.nii.gz)
semanticafile=$(find ./ -iname *SEMANTICA*.nii.gz)
haylingfile=$(find ./ -iname *HAYLING*.nii.gz)
# cmetfile=$(find ./ -iname *CMET*.nii.gz) #Already created



# Rename files
# Common files
cp $t1file t1_sjd.nii.gz
cp $t2file t2_sjd.nii.gz
cp $flairfile flair_sjd.nii.gz
cp $b0file b0_sjd.nii.gz
cp $restingfile resting_sjd.nii.gz
cp $t1carafile t1cara_sjd.nii.gz

# FEPs/Cannabis/Mania
cp $reward1file reward1mid_sjd.nii.gz
cp $reward2file reward2rlt_sjd.nii.gz
cp $cmetfile cmet_sjd.nii.gz
cp $nbackfile nback_sjd.nii.gz
cp $iapsfile iaps_sjd.nii.gz
cp $metrofile metro_sjd.nii.gz

# AVH
cp $alucinacionesfile alucinaciones_sjd.nii.gz
cp $capturafile captura_sjd.nii.gz
cp $memoriafile memoria_sjd.nii.gz
cp $rimasfile rimas_sjd.nii.gz

# Lesex
cp $produccionfile produccion_sjd.nii.gz
cp $semanticafile semantica_sjd.nii.gz
cp $haylingfile hayling_sjd.nii.gz
# cp $cmetfile cmet_sjd.nii.gz #Already done


