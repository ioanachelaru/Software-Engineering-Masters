#!/bin/bash

set -evx

if [ $# -ne 1 ]; then
	REPO=`pwd`/scopy/src
else
	REPO=$1
fi

OUT_FILE=../../data.csv
OUT_FILE_NAME=data.csv


gather_data() {
	pushd $REPO
    
    # create output file
    touch $OUT_FILE

    for FILE in *; do

        # check that $FILE is a header
        if [[ $FILE == *".h"* ]] ; then

            # write filename to output file
            printf $FILE >> $OUT_FILE
            
            # iterate file line by line
            while IFS= read -r line; do

                if [[ $line == *"#include"* ]] ; then
                    printf ",$line" >> $OUT_FILE
                fi
            
            done < $FILE


            # find corresponding source file
            FILE_NAME=`echo $FILE | cut -d . -f 1`
            SOURCE_FILE=`find -name $FILE_NAME.cpp`
            
            # check if source file exists, not all headers have souce files
            if [[ ! -z $SOURCE_FILE ]]; then

                # iterate file line by line
                while IFS= read -r line; do

                    if [[ $line == *"#include"* ]] ; then
                        printf ",$line" >> $OUT_FILE
                    fi
                
                done < $SOURCE_FILE
            
            fi

            # start new line
            printf "\n" >> $OUT_FILE

        fi
    done

	popd
}


cleanup_data() {
    
    # remove foreign includes
    sed -i 's/,#include <[^>]*>//g' $OUT_FILE_NAME

    # remove all #include 
    sed -i 's/#include //g' $OUT_FILE_NAME

    # remove all commas 
    sed -i 's/\"//g' $OUT_FILE_NAME
    
    # remove all paths to files
    sed -i 's/,[^/]*\//,/g' $OUT_FILE_NAME
}

# gather_data
# cleanup_data