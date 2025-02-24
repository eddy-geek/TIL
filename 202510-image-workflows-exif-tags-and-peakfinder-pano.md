## General image metadata tips

Here is a way to get what "important" tags an image has:

```sh
for f in *.jpg
do
    exiftool -FileName -ImageSize -FileSize -OriginalFileSize -TotalFileSize\
             -DateTimeOriginal -CreateDate -ModifyDate -FileCreateDate -FileModifyDate \
             -Model -LensModel -ExposureTime -FNumber -ISO -FocalLength \
             -GPSPosition -GPSAltitude \
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
