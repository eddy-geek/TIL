# Ultra HDR

## TL;DR

I wanted to diplay ultrahdr 

## Context

### Image formats

* The mess with [HEIF/AVIF support](./202201-heif-avif-support.md) is still not over:
    * despite Apple and Samsung still saving camera pictures with HEIF, it's not supported by browsers.
    * while AVIF is supported by browsers. But anyway both formats are ccnsidered quite "heavy"/slow.
* JXL is promising and supported in Safari, but Google Chrome killed support, and FF is in no hurry.
* Now Google is introducing "Ultra HDR" which is backward-compatible Jpeg with HDR gain map as metadata.
* ... and [jpegli](https://opensource.googleblog.com/2024/04/introducing-jpegli-new-jpeg-coding-library.html) which may also help if more widely supported, with its 10+ bits color coding support.

### Gain map

Very well explained in [“Gain maps” make HDR look great on any screen - Greg Benz Photography](https://gregbenzphotography.com/hdr-photos/jpg-hdr-gain-maps-in-adobe-camera-raw/).

As Adobe puts it in their 2021 [Gain map specification](https://helpx.adobe.com/camera-raw/using/gain-map.html)'

> Using new file formats and codecs (10-bit HEIC, AVIF, JPEG XL, ...)
> (instead of JPEG, PNG, etc.) and higher bit-depth encoding provides
> the highest quality at the smallest file sizes. However, it has two major disadvantages:
> * System- and app-dependent behavior when viewing HDR content on different devices across viewing conditions
> * Incompatible with older software

and

> Gain Maps are currently undergoing standardization in ISO/TC 42 Photography
> (actually the Adobe-published proposal is what's in the ISO draft).

The JPG gain maps (aka "Ultra HDR JPG"), now have a widespread implementation in Google' [libultrahdr](https://github.com/google/libultrahdr) presumably used in Chrome and Android.

> After the gain map is stored in a secondary image, it is appended to a primary image with MPF and GContainer XMP metadata.
> The primary image GContainer directory must contain an item for the gain map image.

Also relevant is Apple's [EDR](https://www.digit.in/features/general/apple-edr-how-is-it-different-from-regular-hdr-59940.html) format:

Apple HDR images seem to use a proprietary format that relies on [EXIF metadata](https://developer.apple.com/forums/thread/709331?answerId=726119022#726119022) and an embedded HDR gain map image in the HEIC format, for displaying the HDR effect in Photos.<br>
More precisely it uses two private {MakerApple} EXIF tags:  0x21 ("HDRGamma", global boost to brightness) and 0x30 (how much the embedded gain map adds to the effect, from smallest=8 to 0).<br>
Relevant thread: [Extracting HDR Gain Map from iOS 14.1+ (iPhone 12+) photos](https://gist.github.com/kiding/fa4876ab4ddc797e3f18c71b3c2eeb3a).

> gregbenz commented on Nov 20, 2023:
> I believe the Apple implementation is not compliant with the ISO spec (ISO 21496-1). Last I checked, it was using slightly different metadata and a 1D map (the ISO spec uses a 3D spec which should enable better color adaptation from HDR to SDR).

> It seems support for Apple's format was added together with the support for Adobe's format to the Chrome engine. Very nice!

Do not confise the EDR gain map format with the display technology or hacks like [Apple’s “EDR” Brings High Dynamic Range to Non-HDR Displays — Prolost](https://prolost.com/blog/edr).

## Ultra HDR Producers

* Google (all pixels updated to Android 14+)
* Samsung Galaxy S24+, under name [Super HDR](https://9to5google.com/2024/04/02/samsungs-super-hdr-on-older-galaxy/).
* (Apple, with own format, see above)

## Ultra HDR consumers

* Google Chrome on Windows and MacOS (v116+), MS Edge (v116+), Brave (v1.58+), and Opera (v102+) all support it by default.
* Adobe Camera RAW v15.5+
* Google Photos
* Google Messages
* Instagram and Threads
* ImageMagick, soon, with [#6377](https://github.com/ImageMagick/ImageMagick/issues/6377)
* not Firefox, and no in any hurry when it comes to HDR in general...
  tracked in [1539685 - \[meta\] Add HDR support to Gecko](https://bugzilla.mozilla.org/show_bug.cgi?id=hdr)
  and specifically [1793091 - HDR images are rendered extremely dark](https://bugzilla.mozilla.org/show_bug.cgi?id=1793091)

## Linux display color management

* GPU
   * AMD OK since late 2023
   * Nvidia OK sinec early 2024
   * Intel HDR support OK merged in April 2024 (Linux 6.9 ? Ubuntu 24.04 has Linux 6.8)
* Window manager: [wayland-protocols#14](https://gitlab.freedesktop.org/wayland/wayland-protocols/-/merge_requests/14) to be in staging by Feb 2025. But only KDE imlementation so far.
* No browser support. Only games, and mpv for HDR video.
