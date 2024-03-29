# HEIC Image support

Unfortunately support is till not as widespread as I'd like.

AVIF reused the same container format from HEIF: HEIC, itself based on [this ISO format](https://en.wikipedia.org/wiki/ISO/IEC_base_media_file_format)
So a *.heic* can have both HEIF or AVIF! and [libheif](https://github.com/strukturag/libheif) supports both. Not confusing at all.

* HEIF: 2015. from VCEG/MPEG, video codec HEVC/H265 (2013), patent encumbered -> no browser support
* AVIF: 2019. from AOM (WebP/VP9), video codec AV1 (2018), free -> supported in Chrome, FF, Android 12+, MacOS 13+ Ventura, ios 16+, but not Edge (106, NOV22)

While AVIF will eventually have wider support, it is late to the party, and Apple/Samsung already committed to HEIF especially on mobile.

Resources for support include https://avif.io and [wikipedia](https://en.wikipedia.org/wiki/AVIF)

Eg [Android 12 added built-in AVIF support](https://developer.android.com/about/versions/12/features#avif) it's still abit rough:
* ✕ Android API [doc](https://developer.android.com/reference/android/graphics/ImageFormat) needs an update
* ✓ thumbnailing *.avif* is now supported in Google *Files* app and Samsung *Gallery*
* ✕ Samsung *Camera* only records heif
* ✕ Samsung *My Files* will not thumbnail *.avif*. Renaming works.
* No apps is registered to open *.avif*. Again, rename to work-around.

Cloud support is even worse:

| Cloud         | HEIF | AVIF                         |
| ------------- | ---- | ----                         |
| Google Photos | ✓    | ✓ as .avif only              |
| Dropbox       | ✓    | ✕ (AVIF in .heic looks gray) |
| pCloud        | ✕    | ✕ [soon][1]                           |

[1][https://twitter.com/pcloudapp/status/1304039310497320962?lang=fr]

The best resource for linux support is [askubuntu](https://askubuntu.com/a/965306/220798).

## ImageMagick

#### ImageMagick 6

`imagemagick-6.q16`, version `6.9.11.60+dfsg-1ubuntu1~ppa1~focal3` from ppa https://launchpad.net/~bleedingedge/+archive/ubuntu/focal-bleed

It is built with HEIC support but unfortunately it [needs](https://github.com/ImageMagick/ImageMagick/issues/1511) special option `-colorspace sRGB` to open HEIC.


#### ImageMagick 7

Also, almost 2 years after release, ImageMagick7 is still not included in ubuntu, so I got the *AppImage* installed from [instructions](https://askubuntu.com/a/1309857/220798) ; 
It got built-in HEIC support [added](https://github.com/ImageMagick/ImageMagick/issues/4666) in March 2023, (somewhere between versions 7.1.0-19 and 7.1.1-6).
