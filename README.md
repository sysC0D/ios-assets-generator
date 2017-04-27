## What is?
Scripts to automatically generate iOS icons and launch images in the correct sizes. Also contains optimal asset catalogs with reused images for identical sizes.

Tested with Xcode 7 and iOS 6-9.

No dependencies.

## Usage

`Default-Input-Landscape.png` & `Default-Input-Portrait.png`  & `Icon-Input.png` contain the initial graphics for the launch image and icons respectively.

From Terminal run:

`./CreateiOSLaunchImages.sh -l Default-Input-Landscape.png -p Default-Input-Portrait.png`

and

`./CreateiOSIcons.sh`

and

`./CreateiOSToolbarNavigationIcons.sh`

to create all necessary size variants.

### Optional

Remove variants that are not needed (e.g. iPad Portrait) from the catalogs to optimize app size.

## For best results

`Default-Input-*.png`:
* Landscape / Portrait
* Aspect ratio 4:3 (with content croppable to 16:9)
* Highest quality if at least 2208px wide

`Icon-Input.png`:

* Square (1:1 aspect ratio)
* Highest quality if at least 1024x1024px

`ToolbarNavigationIcon-Input.png`:

* Square (1:1 aspect ratio)
* Highest quality if at least 1024x1024px


## Credits
Rasmus Makwarth / Opbeat for the fisi graphics.
