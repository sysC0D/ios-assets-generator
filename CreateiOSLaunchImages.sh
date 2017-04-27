#!/bin/bash
# Generate Lanchscreen for IOS

VERSION="Version 1.O"
AUTHOR="2017 by sysC0D"
STATE_OK=0
STATE_WARN=1
STATE_CRIT=2
STATE_UNKN=3

function print_help {
        echo "Usage: ./CreateiOSIcons.sh [-v] [-h] [-l -p]
        -h, --help
        print this help message
        -v, --version
	print version program
	-l, --landscapeimg
        name or path of lanscape img
	use size 2208px x 1656px
	-p, --portraitimg
	name or path of portrait img
	use size 1656px x 2208px
	-c, --clean
	clean last generated png" 
}

function print_version {
	echo "$VERSION $AUTHOR"
	echo "Forked from danielpovlsen/ios-icons-launch-images-generator"
}

function clean_assets {
	echo "Clean last generated png..."
	rm -f Images.xcassets/LaunchImage.launchimage/*.png 
	echo "Done"	
}

function landscape_generation () {
	local nameimg="$1"

	# iPhone 5.5" @3x - landscape
	sips -Z 2208 -c 1242 2208 $nameimg --out Images.xcassets/LaunchImage.launchimage/Default2208x1242.png

	# iPad @2x - landscape
	sips -Z 2048 $nameimg --out Images.xcassets/LaunchImage.launchimage/Default2048x1536.png
	# iPad @1x - landscape
	sips -Z 1024 Images.xcassets/LaunchImage.launchimage/Default2048x1536.png --out Images.xcassets/LaunchImage.launchimage/Default1024x768.png
}

function portrait_generation () {
	local nameimg="$1"
	echo $nameimg
	
	# iPhone 3.5" @2x
	sips -Z 960 -c 960 640 $nameimg --out Images.xcassets/LaunchImage.launchimage/Default640x960.png
	# iPhone 3.5" @1x (no rotate)
	sips -Z 480 Images.xcassets/LaunchImage.launchimage/Default640x960.png --out Images.xcassets/LaunchImage.launchimage/Default320x480.png
	# iPhone 4.0" @2x
	sips -Z 1136 -c 1136 640 $nameimg --out Images.xcassets/LaunchImage.launchimage/Default640x1136.png

	# iPhone 5.5" @3x - portrait
	sips -Z 2208 -c 2208 1242 $nameimg Images.xcassets/LaunchImage.launchimage/Default1242x2208.png
	# iPhone 4.7" @2x
	sips -Z 1334 -c 1334 750 $nameimg --out Images.xcassets/LaunchImage.launchimage/Default750x1334.png
	
	# iPad @2x - portrait
	sips -Z 2048 -c 2048 1536 $nameimg --out Images.xcassets/LaunchImage.launchimage/Default1536x2048.png
	# iPad @1x - portrait
	sips -Z 1024 -c 1024 768 $nameimg --out Images.xcassets/LaunchImage.launchimage/Default768x1024.png	
}

#
##MAIN
#

arg_landscapeimg=""
arg_portraitimg=""

while test -n "$1"; do
    case "$1" in
	-h|--help)
	    print_help
	    exit "$STATE_OK"
            ;;
	-v|--version)
            print_version
	    exit "$STATE_OK"
	    ;;
	-l|--landscapeimg)
	    arg_landscapeimg=$2
	    shift
	    ;;
	-p|--portraitimg)
	    arg_portraitimg=$2
	    shift
	    ;;
	-c| --clean)
	    clean_assets
	    exit "$STATE_OK"
	    ;;	
	*)
	    echo "Unknown argument: $1"
	    print_help
	    exit $STATE_UNKN
	    ;;
     esac
     shift
done

if [ ! -z $arg_landscapeimg ] || [ ! -z $arg_portraitimg ]
then
	if [ ! -z $arg_landscapeimg ] && [ -f $arg_landscapeimg ]
	then
		landscape_generation $arg_landscapeimg
		echo "Landscape generation done"
	fi	

	if [ ! -z $arg_portraitimg ] && [ -f $arg_portraitimg ]
	then
		portrait_generation $arg_portraitimg	
		echo "Portrait generation done"
	fi	

	if [ -f $arg_landscapeimg ] && [ -f $arg_portraitimg ]
	then
		echo "File not found"
		exit $STATE_UNKN
	fi
	 
else
	echo "Please use param for landcape and/or portrait image generation"
	print_help
	exit $STATE_UNKN  
fi

exit $STATE_OK
