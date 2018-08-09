#!/bin/sh

changeImage(){

    img=$1
    imgType=$2

    sips \
    --matchTo '/System/Library/ColorSync/Profiles/sRGB Profile.icc' \
    "$img" \
    --out "$img"

    path=$projectPath

    launchimagePath=`find $path -name $imgType -type d`

    for obj in `find $launchimagePath -name "*.png"`
    do

    imgName=${obj##*/}

    imgH=`sips -g pixelHeight $obj`
    iH=${imgH##*:}

    imgW=`sips -g pixelWidth $obj`
    iW=${imgW##*:}

    sips -z $iH $iW $img --out $obj

    done
}

iPhoneIcon() {
    sips -Z $1 $icon --out ./AppIcon/icon_$1x$1.png
}

iPadIcon() {
    sips -Z $1 $icon --out ./AppIcon/iPad_$1x$1.png
}

newIcon(){

    sips \
    --matchTo '/System/Library/ColorSync/Profiles/sRGB Profile.icc' \
    "$icon" \
    --out "$icon"

    currentPath=`pwd`
    p=${currentPath}/AppIcon/

    if [ ! -d p ]
    then
    cd $currentPath
    mkdir AppIcon
    fi

    for iPhoneSize in  40 58 60 80 87 120 180 1024
    do
    iPhoneIcon $iPhoneSize
    done

    for iPadSize in  20 29 40 58 76 80 152 167
    do
    iPadIcon $iPadSize
    done

}

shPath=`pwd`

projectPath=
icon=
launch=
new=
imageset=

while getopts ":c:i:p:l:nh" opt
do
    case $opt in
    h)
        echo "-h Help"
        echo "-i [icon]"
        echo "-p [project path]"
        echo "-l [launch image]"
        echo "-n new iPhone iPad icons"
        echo "-c custom change images imageset eg: AT-1024.imageset -c AT-1024"
    exit 1;
    ;;

    i)
        icon=$OPTARG
    ;;

    p)
        projectPath=$OPTARG
    ;;

    l)
        launch=$OPTARG
    ;;

    n)
        new="yes"
    ;;

    c)
        imageset=$OPTARG
    ;;

    ?)
        echo "未知参数"
    exit 1;
    ;;
    esac
done

if [ ! $projectPath ] && [ ! $new ]
then
    echo "The project path is null"
exit 1;
fi

if [ $projectPath ] && [ $icon ]
then

    if [ $imageset ]
    then
        changeImage $icon "${imageset}.imageset"
        echo "-----------------edit ${imageset}.imageset success-----------------"
    else
        changeImage $icon "AppIcon.appiconset"
        echo "-----------------edit AppIcon.appiconset success-----------------"
    fi


fi

if [ $projectPath ] && [ $launch ]
then
    changeImage $launch "*.launchimage"
    echo "-----------------edit $launch success-----------------"
fi


if [ $new ] && [ $icon ]
then
    newIcon
    echo "-----------------edit $icon success-----------------"
fi




