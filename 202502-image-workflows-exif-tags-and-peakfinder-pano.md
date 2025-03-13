## General image metadata tips

Here is a way to get what "important" tags an image has:

```sh
for f in *.jpg
do
    exiftool -FileName -ImageSize -FileSize -OriginalFileSize -TotalFileSize\
             -DateTimeOriginal -CreateDate -ModifyDate -FileCreateDate -FileModifyDate \
             -Model -LensModel -ExposureTime -FNumber -ISO -FocalLength -Aperture -composite:FieldOfView -Orientation \
             -GPSPosition -GPSAltitude -GPSImgDirection \
             -ProfileDescription -ColorSpaceTags \
             -MPF:NumberOfImages -MPF:MPImageLength -XMP:DirectoryItemLength -XMP:HdrPlusMakernote -file "$f"
    exiftool $f | wc -l
    echo
done
```

Note: Profile, MPF and XMP tags are to identify various HDR formats (can use -MPF:* -XMP:* for more UltraHDR gain map data)

if needed the tags can be copied with

```sh
exiftool -TagsFromFile "$source_jpg" "-all:all>all:all" "$dest_jpg"
```

Note that 
* imagemagick copies some more tags than exiftool but also some less
* neither copies MPF (Multi Picture Format) data, which excludes gain map

### Install more recent exiftool on ubuntu

Luckily exiftool seems compatible across ubuntu versions, so

```sh
wget https://launchpad.net/ubuntu/+archive/primary/+files/libimage-exiftool-perl_13.10+dfsg-1_all.deb
sudo dpkg -i ~/Downloads/dwnlinux/libimage-exiftool-perl_13.10+dfsg-1_all.deb
```

## Peakfinder tips

A workflow for adding peak names to an  existing picture using PeakFinder can be:

* import in peakfinder, edit and export. Make sure to "move up" as much as possible the viewport when editing.
* since peakfinder will crop it, use Image Magick to get back the original picture size:
  * Consider the original picture as background and peakfinder as foreground
  * crop the bottom 200px (image title) and merge with any image editor. You can automate with Linux Shell and ImageMagick:


```sh
background="PXL_2025nnnn_nnnnnnnnn.jpg"
foreground="${background%.*}_peakf.${background##*.}"
result="${background%.*}_peaked.${background##*.}"
magick "$background" \( "$foreground" -gravity south -chop 0x200 \) -gravity north -composite "$result"
```

## Panorama builder

Hugin will neef the metadata provided above (FOV).

Right now even for pictures taken within PeakFinder (not imported), some metadata is missing for both hugin and exiftool to compute FOV.

The issue is the *Focal Length* is correct (eg 6.9mm) but *Focal Length In 35mm Format* is set to 0 mm.
This is fixed with:

```sh
exiftool -FocalLengthIn35mmFormat='24 mm' -file foo.jpg
```

(In case it's useful, DxOMark says for Pixel 8 Pro Primary: 50MP 1/1.31″ sensor, 1.2μm pixels, f/1.68-aperture lens)

### With panostart

panostart was installed with:

```
cpan
install B/BP/BPOSTLE/Panotools-Script-0.29.tar.gz
```

Then

```
panostart --output Makefile --projection 0 --fov 50 --nostacks --loquacious *.JPG
make
```

(but this give a bery bright picture, need to tweak exposure)
