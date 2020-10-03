#!/bin/sh

SAVEIFS=$IFS # Save the File separator to restore it later
IFS=$(echo -en "\n\b") # New file separator
arr=(`find -type d`)
dir=`pwd`
IFS=$SAVEIFS

for ((i = 0 ; i < "${#arr[@]}" ; i++)) ; do
    arr[i]="'${dir}${arr[i]:1}/'"
done

videoFormats=("mp4" "webm" "mkv" "mov" "ogv")

for dir in "${arr[@]}" ; do
    eval "cd $dir"
    echo "Current Folder is $dir"

    if [[ ! -d "new" ]]; then
        sudo mkdir "new"
    fi

    for format in "${videoFormats[@]}" ; do
        count=`ls -1 *.$format 2>/dev/null | wc -l`
        
        if [[ $count != 0 ]]; then

            for file in *.$format ; do
                nameWithoutExtension=`echo $file | sed "s/.$format//g"`
                sudo ffmpeg -i "$file" -c:v libx265 -crf 28 -c:a copy "./new/$nameWithoutExtension.mp4"
                sudo rm "$file"
                sudo mv "./new/$nameWithoutExtension.mp4" .
                echo "________________________________________________________________"
            done

        fi
    done

    sudo rmdir "./new"

done

