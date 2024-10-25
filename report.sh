#!/bin/bash

echo --WARNING--
echo PROTOCOL is automatically detected
echo Please check that it is correctly assigned before running further analyses
echo -----------
echo

pendingfolder=/media/analysis/share/Processing_SJD/pending/
analyzedir=/media/store/image/ANALYZE

for i in $(ls $pendingfolder); do
    
    echo Checking subject $i
    
    
    # Create variables
    SUBJECT=$i
    PROTOCOL=UNKNOWN
    
    T1=NA
    T2=NA
    FLAIR=NA
    B0=NA
    RESTING=NA
    T1CARA=NA
    
    RLT=NA
    CMET=NA
    NBACK=NA
    IAPS=NA
    MID_MANIA=NA
    METRO=NA
    
    ALUCINACIONES=NA
    CAPTURA=NA
    MEMORIA=NA
    RIMAS=NA
    
    PRODUCCION=NA
    SEMANTICA=NA
    HAYLING=NA
    
    DTI=NA
    B0_DTI=NA
    DTI_BVALS=NA
    DTI_BVECS=NA
    
    
    # Assign value to variables
    cd $analyzedir/$i/
    
    # Common files
    if [ -f t1_sjd/t1_sjd.nii.gz ]; then
    	T1="OK"
	fi
	
	if [ -f t2_sjd/t2_sjd.nii.gz ]; then
    	T2="OK"
	fi
    
    if [ -f flair_sjd/flair_sjd.nii.gz ]; then
    	FLAIR="OK"
	fi
		
	if [ -f b0_sjd/b0_sjd.nii.gz ]; then
        B0="OK"
    fi
    
    if [ $(fslnvols resting_sjd/resting_sjd.nii.gz) -eq 266 ]; then
        RESTING="OK"
    elif [ -f resting_sjd/resting_sjd.nii.gz ]; then
        RESTING="INCOMPLETE"
    fi
    
    if [ -f t1cara_sjd/t1cara_sjd.nii.gz ]; then
        T1CARA="OK"
    fi
    
    
    # FEPs/Cannabis/MANIA
    if [ $(fslnvols reward2rlt_sjd/reward2rlt_sjd.nii.gz) -eq 443 ]; then
        RLT="OK"
    elif [ -f reward2rlt_sjd/reward2rlt_sjd.nii.gz ]; then
        RLT="INCOMPLETE"
    fi
    
    if [ $(fslnvols cmet_sjd/cmet_sjd.nii.gz) -eq 245 ]; then
        CMET="OK"
    elif [ -f cmet_sjd/cmet_sjd.nii.gz ]; then
        CMET="INCOMPLETE"
    fi      
    
    if [ $(fslnvols nback_sjd/nback_sjd.nii.gz) -eq 266 ]; then
        NBACK="OK"
    elif [ -f nback_sjd/nback_sjd.nii.gz ]; then
        NBACK="INCOMPLETE"
    fi
    
    if [ $(fslnvols iaps_sjd/iaps_sjd.nii.gz) -eq 390 ]; then
        IAPS="OK"
    elif [ -f iaps_sjd/iaps_sjd.nii.gz ]; then
        IAPS="INCOMPLETE"
    fi
    
    if [ $(fslnvols reward1mid_sjd/reward1mid_sjd.nii.gz) -eq 378 ]; then
        MID_MANIA="OK"
    elif [ -f reward1mid_sjd/reward1mid_sjd.nii.gz ]; then
        MID_MANIA="INCOMPLETE"
    fi
    
    if [ $(fslnvols metro_sjd/metro_sjd.nii.gz) -eq 348 ]; then
        METRO="OK"
    elif [ -f metro_sjd/metro_sjd.nii.gz ]; then
        METRO="INCOMPLETE"
    fi


    # AVH
    if [ $(fslnvols alucinaciones_sjd/alucinaciones_sjd.nii.gz) -eq 310 ]; then
		ALUCINACIONES="OK"
	elif [ -f alucinaciones_sjd/alucinaciones_sjd.nii.gz ]; then
	    ALUCINACIONES="INCOMPLETE"
	fi

	if [ $(fslnvols captura_sjd/captura_sjd.nii.gz) -eq 310 ]; then
	    CAPTURA="OK"
	elif [ -f captura_sjd/captura_sjd.nii.gz ]; then
	    CAPTURA="INCOMPLETE"
	fi

	if [ $(fslnvols memoria_sjd/memoria_sjd.nii.gz) -eq 245 ]; then
	    MEMORIA="OK"
	elif [ -f memoria_sjd/memoria_sjd.nii.gz ]; then
	    MEMORIA="INCOMPLETE"
	fi

	if [ $(fslnvols rimas_sjd/rimas_sjd.nii.gz) -eq 242 ]; then
        RIMAS="OK"
    elif [ -f rimas_sjd/rimas_sjd.nii.gz ]; then
        RIMAS="INCOMPLETE"
	fi
	
	
	# LESEX
	if [ $(fslnvols produccion_sjd/produccion_sjd.nii.gz) -eq 272 ]; then
        PRODUCCION="OK"
    elif [ -f produccion_sjd/produccion_sjd.nii.gz ]; then
        PRODUCCION="INCOMPLETE"
	fi
	
	if [ $(fslnvols semantica_sjd/semantica_sjd.nii.gz) -eq 252 ]; then
        SEMANTICA="OK"
    elif [ -f semantica_sjd/semantica_sjd.nii.gz ]; then
        SEMANTICA="INCOMPLETE"
	fi
	
	if [ $(fslnvols hayling_sjd/hayling_sjd.nii.gz) -eq 257 ]; then
        HAYLING="OK"
    elif [ -f hayling_sjd/hayling_sjd.nii.gz ]; then
        HAYLING="INCOMPLETE"
	fi
 
    
    # DTI
    if [ $(fslnvols dti_36d_sjd/dti36d_sjd.nii.gz) -eq 39 ]; then
        DTI="OK"
    elif [ -f dti_36d_sjd/dti36d_sjd.nii.gz ]; then
        DTI="INCOMPLETE"
    fi
    
    if [ -f dti_36d_sjd/b0_dti36d_sjd.nii.gz ]; then
        B0_DTI="OK"
    fi
    
    if [ -f dti_36d_sjd/dti36d_sjd.bval ]; then
        DTI_BVALS="OK"
    fi
    
    if [ -f dti_36d_sjd/dti36d_sjd.bvec ]; then
        DTI_BVECS="OK"
    fi
    
    
    
    # Detect protocol
    if [[ -f alucinaciones_sjd/alucinaciones_sjd.nii.gz || -f captura_sjd/captura_sjd.nii.gz || -f rimas_sjd/rimas_sjd.nii.gz ]]; then
        PROTOCOL="AVH"
    elif [[ -f produccion_sjd/produccion_sjd.nii.gz || -f semantica_sjd/semantica_sjd.nii.gz || -f hayling_sjd/hayling_sjd.nii.gz ]]; then
        PROTOCOL="LESEX"
    elif [[ -f memoria_sjd/memoria_sjd.nii.gz && -f iaps_sjd/iaps_sjd.nii.gz && -f nback_sjd/nback_sjd.nii.gz ]]; then
        PROTOCOL="TLP"
    elif [[ -f nback_sjd/nback_sjd.nii.gz && -f cmet_sjd/cmet_sjd.nii.gz && -f reward2rlt_sjd/reward2rlt_sjd.nii.gz ]]; then
        PROTOCOL="CANNABIS"
    elif [[ -f cmet_sjd/cmet_sjd.nii.gz && -f reward2rlt_sjd/reward2rlt_sjd.nii.gz && -f iaps_sjd/iaps_sjd.nii.gz ]]; then
        PROTOCOL="FEP"
    elif [[ -f reward1mid_sjd/reward1mid_sjd.nii.gz || -f metro_sjd/metro_sjd.nii.gz ]]; then
        PROTOCOL="MANIA"
    fi
    
    
    
    cd ../..
    echo $SUBJECT,$PROTOCOL,$T1,$T2,$FLAIR,$B0,$RESTING,$T1CARA,$RLT,$CMET,$NBACK,$IAPS,$MID_MANIA,$METRO,$ALUCINACIONES,$CAPTURA,$MEMORIA,$RIMAS,$PRODUCCION,$SEMANTICA,$HAYLING,$DTI,$B0_DTI,$DTI_BVALS,$DTI_BVECS >> report.csv
    
    
done


