## General image metadata command-line tips

To get **all** tags (exif and others) of file path `foo.jpg` sorted by group:

```sh
exiftool -a -u -g1 foo.jpg
```

To select a few of the more relevant (to me) tags:

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

Notes:

* imagemagick copies some more tags than exiftool but also some less
* neither copies MPF (Multi Picture Format) data, which excludes gain map

### Install more recent exiftool on ubuntu

Luckily exiftool seems compatible across ubuntu versions, so to install the latest stable build:

```sh
wget https://launchpad.net/ubuntu/+archive/primary/+files/libimage-exiftool-perl_13.10+dfsg-1_all.deb
sudo dpkg -i ~/Downloads/dwnlinux/libimage-exiftool-perl_13.10+dfsg-1_all.deb
```

### Date tips

Dates set in google photo will be lost on downlod.

Missing dates can be filled with a sample one like so:

```sh
exiftool -overwrite_original -writeMode cg -AllDates='2025:03:16 12:12:12' .
```

And the file mtime can be set to ease sorting:

```sh
exiftool "-filemodifydate<datetimeoriginal" .
```

## Peakfinder tips

A workflow for adding peak names to an existing picture using PeakFinder can be:

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

## Mobile Panorama builder

On Android, the app "Bimostitch" gives great results but:

* beware the file size. See below for compression.
* It removes some metadata. especially, it sets gps coordinates to 0. This can be copied back with exiftoiol as above.
* It adds some specific [XMP GPano](https://developers.google.com/streetview/spherical-metadata) panorama metadata like *Use Panorama Viewer = True*. This makes PeakFinder or Google Magic Editor refuse to use the picture ; and it makes it weird to zoom in Google Photo. To remove the whole metadata group:

```sh
exiftool -XMP-GPano:all= foo.jpg
```

## Desktop Panorama builder

Hugin will need the metadata provided above (FOV).

Right now even for pictures taken within PeakFinder (not imported), some metadata is missing for both hugin and exiftool to compute FOV.

The issue is the *Focal Length* is correct (eg 6.9mm) but *Focal Length In 35mm Format* is set to 0 mm.
This is fixed with:

```sh
exiftool -FocalLengthIn35mmFormat='24 mm' -file foo.jpg
```

In case it's useful, details on the Pixel 8 Pro cameras - I had to change FOV to 61° in PeakFinder:

* Primary: 50MP 1/1.31″ sensor, 1.2μm pixels, f/1.68 lens, 82° fov, 24 mm
* UW:      48MP 1/2.0"  sensor, 0.8µm pixels, f/1.95 lens, 125.5° fov, 13 mm, 0.65x
* Tele:    48MP 1/2.55" sensor, 0.7µm pixels, f/2.8  lens, 21.8° fov, 112 mm, 4.7x

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

## Reduce file size before upload

Make a copy of the folder and re-compress in-place only the images above 2 MB:

```sh
mkdir -p low && cp * low/ && \ 
find . -maxdepth 1 -type f -name "*.jpg" -size +2M -exec convert {} -quality 72 low/{} \;
```

The quality "72" tends to give sizes below 2 MB for my camera & pictures.
