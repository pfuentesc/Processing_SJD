#!/bin/bash

for f in `find ./ -iname "*.nii"`;
do
    echo $f
    gzip $f 
    rm -f $f
    fslreorient2std $f.gz $f.gz	

done


