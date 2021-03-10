#!/bin/bash

# change the package name to the existing PyPi package you would like to build and adjust the Python versions
pkg='eventsourcing'
array=( 3.5 3.6 3.7 3.8 )

echo "Building conda package ..."
# prepare conda build output folder
mkdir -p ./build/conda-bld

# building conda packages
for i in "${array[@]}"
do
	conda build --python $i --output-folder ./build/conda-bld .
done

# convert package to other platforms
# cd ~
# platforms=( osx-64 linux-64 linux-32 win-32 win-64 )
# find ./build/conda-bld/noarch/ -name "*.tar.bz2" | while read file
# do
#     echo $file
#     #conda convert --platform all $file  -o $HOME/conda-bld/
#     for platform in "${platforms[@]}"
#     do
#        conda convert --platform $platform $file  -o ./build/conda-bld/
#     done
    
# done

# upload packages to conda
find ./build/conda-bld/ -name *.tar.bz2 | while read file
do
    echo $file
    anaconda upload $file --user xtalpi --label main
done

echo "Building conda package done!"