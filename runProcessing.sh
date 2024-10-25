#!/bin/bash


pendingfolder=pending/


for i in $(ls $pendingfolder); do
    echo $i
    pushd .
    
    # Create tmp subject directory
    mkdir tmp/$i
    
    # Create ANALYZE subject directory
    analyzedir=/media/store/image/ANALYZE/$i
    mkdir $analyzedir
    
    # Compress and copy DICOM folder
    cd $pendingfolder
    dicomzipfile=../tmp/$i.zip
    echo Creating $dicomzipfile 
    zip -r $dicomzipfile $i
    mv $dicomzipfile /media/store/image/DICOM/$i.zip
    
    
    # Convert DICOM to NIFTI
    mcverter -o ../tmp/$i -f nifti -v -x -d -n -F PR $i/
    
    
    # Rename and reorganize files
    cd ../tmp/$i
    ../../test_rename.sh
    
    # Common files
    # The directory is created only if the file exists
    if [ -f t1_sjd.nii.gz ]; then
        mkdir $analyzedir/t1_sjd
        mv t1_sjd.nii.gz $analyzedir/t1_sjd/
    fi
    
    if [ -f t2_sjd.nii.gz ]; then
        mkdir $analyzedir/t2_sjd
        mv t2_sjd.nii.gz $analyzedir/t2_sjd/
    fi
    
    if [ -f flair_sjd.nii.gz ]; then
        mkdir $analyzedir/flair_sjd
        mv flair_sjd.nii.gz $analyzedir/flair_sjd/
    fi
    
    if [ -f b0_sjd.nii.gz ]; then
        mkdir $analyzedir/b0_sjd
        mv b0_sjd.nii.gz $analyzedir/b0_sjd/
    fi
    
    if [ -f resting_sjd.nii.gz ]; then
        mkdir $analyzedir/resting_sjd
        mv resting_sjd.nii.gz $analyzedir/resting_sjd/
    fi
    
    if [ -f t1cara_sjd.nii.gz ]; then
        mkdir $analyzedir/t1cara_sjd
        mv t1cara_sjd.nii.gz $analyzedir/t1cara_sjd/
    fi


    # Tasks
    # FEPs/Cannabis/Mania
    if [ -f reward1mid_sjd.nii.gz ]; then
        mkdir $analyzedir/reward1mid_sjd
        mv reward1mid_sjd.nii.gz $analyzedir/reward1mid_sjd/
    fi
    
    if [ -f reward2rlt_sjd.nii.gz ]; then
        mkdir $analyzedir/reward2rlt_sjd
        mv reward2rlt_sjd.nii.gz $analyzedir/reward2rlt_sjd/
    fi
    
    if [ -f cmet_sjd.nii.gz ]; then
        mkdir $analyzedir/cmet_sjd
        mv cmet_sjd.nii.gz $analyzedir/cmet_sjd/
    fi
    
    if [ -f nback_sjd.nii.gz ]; then
        mkdir $analyzedir/nback_sjd
        mv nback_sjd.nii.gz $analyzedir/nback_sjd/
    fi
    
    if [ -f iaps_sjd.nii.gz ]; then
        mkdir $analyzedir/iaps_sjd
        mv iaps_sjd.nii.gz $analyzedir/iaps_sjd/
    fi
    
    if [ -f metro_sjd.nii.gz ]; then
        mkdir $analyzedir/metro_sjd
        mv metro_sjd.nii.gz $analyzedir/metro_sjd/
    fi
    
 
    # AVH
    if [ -f alucinaciones_sjd.nii.gz ]; then
        mkdir $analyzedir/alucinaciones_sjd
        mv alucinaciones_sjd.nii.gz $analyzedir/alucinaciones_sjd/
    fi
    
    if [ -f captura_sjd.nii.gz ]; then
        mkdir $analyzedir/captura_sjd
        mv captura_sjd.nii.gz $analyzedir/captura_sjd/
    fi
    
    if [ -f memoria_sjd.nii.gz ]; then
        mkdir $analyzedir/memoria_sjd
        mv memoria_sjd.nii.gz $analyzedir/memoria_sjd/
    fi
    
    if [ -f rimas_sjd.nii.gz ]; then
        mkdir $analyzedir/rimas_sjd
        mv rimas_sjd.nii.gz $analyzedir/rimas_sjd/
    fi
    
    
    # Lesex
    if [ -f produccion_sjd.nii.gz ]; then
        mkdir $analyzedir/produccion_sjd
        mv produccion_sjd.nii.gz $analyzedir/produccion_sjd/
    fi
    
    if [ -f semantica_sjd.nii.gz ]; then
        mkdir $analyzedir/semantica_sjd
        mv semantica_sjd.nii.gz $analyzedir/semantica_sjd/
    fi
    
    if [ -f hayling_sjd.nii.gz ]; then
        mkdir $analyzedir/hayling_sjd
        mv hayling_sjd.nii.gz $analyzedir/hayling_sjd/
    fi
    

    # Conversion of DWI sequences (added by Paola 11/11/2021)
    # The code above does not convert DWI sequences correctly, it needs
    # to be done with dicom2nii

    mkdir DWI
    cd ../../
    dcm2niix  -f "%f" -p y -z i -b n -o "tmp/$i/DWI" "pending/$i/DWI_36DIR_3bo"
    dcm2niix  -f "%f" -p y -z i -b n -o "tmp/$i/DWI" "pending/$i/B0_DWI_36_DIR"
    #dcm2niix -f "%f" -p y -z i -b n -o <output> <input>


    # Rename DWI sequences
    cd tmp/${i}/DWI
    mv *.bval dti36d_sjd.bval
    mv *.bvec dti36d_sjd.bvec
    mv DWI*.nii.gz dti36d_sjd.nii.gz
    mv *B0_DWI*.nii.gz b0_dti36d_sjd.nii.gz
    
    if [ ! -z "$( ls -A )" ]; then 
        mkdir $analyzedir/dti_36d_sjd
        mv * $analyzedir/dti_36d_sjd
    fi    
    
    popd 
done

# Fill report
./report.sh



