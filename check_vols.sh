#!/bin/bash


for i in $(cat "subjects.txt"); do
	
	analyzedir=/media/store/image/ANALYZE/$i
	
	cd $analyzedir
	
	echo $i
	
	if test -f t1_sjd/t1_sjd.nii.gz; then
    		echo "T1 OK"
	else
		echo "Warning: T1 not found"
	fi

	if test -f t2_sjd/t2_sjd.nii.gz; then
    		echo "T2 OK"
	else
		echo "Warning: T2 not found"
	fi

	if test -f flair_sjd/flair_sjd.nii.gz; then
    		echo "FLAIR OK"
	else
		echo "Warning: FLAIR not found"
	fi

        if test -f t1cara_sjd/t1cara_sjd.nii.gz; then
    		echo "T1cara OK"
	else
		echo "Warning: T1cara not found"
	fi
        echo "Resting = $(fslnvols resting_sjd/resting_sjd.nii.gz)"
	echo "NBACK = $(fslnvols nback_sjd/nback_sjd.nii.gz)"
	echo "RLT = $(fslnvols reward2rlt_sjd/reward2rlt_sjd.nii.gz)"
	echo "CMET = $(fslnvols cmet_sjd/cmet_sjd.nii.gz)"
	echo "DTI = $(fslnvols dti_36d_sjd/dti36d_sjd.nii.gz)"

	if [ $(fslnvols resting_sjd/resting_sjd.nii.gz) -lt 266 ]
	then
		echo "Warning: Resting seems to be incomplete"
	fi

	if [ $(fslnvols nback_sjd/nback_sjd.nii.gz) -lt 266 ]
	then
		echo "Warning: NBACK seems to be incomplete"
	fi

	if [ $(fslnvols reward2rlt_sjd/reward2rlt_sjd.nii.gz) -lt 443 ]
	then
		echo "Warning: RLT seems to be incomplete"
	fi

	if [ $(fslnvols cmet_sjd/cmet_sjd.nii.gz) -lt 245 ]
	then
		echo "Warning: CMET seems to be incomplete"
	fi
 	
	if [ $(fslnvols dti_36d_sjd/dti36d_sjd.nii.gz) -lt 39 ]
	then
		echo "Warning: DTIs seems to be incomplete"
	fi

	echo ""
	
done
