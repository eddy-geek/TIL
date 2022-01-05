# HEIC Image support

Unfortunately support is till not as widespread as I'd like.

The best resource for linux support is [askubuntu](https://askubuntu.com/a/965306/220798).

## ImageMagick

#### ImageMagick 6

`imagemagick-6.q16`, version `6.9.11.60+dfsg-1ubuntu1~ppa1~focal3` from ppa https://launchpad.net/~bleedingedge/+archive/ubuntu/focal-bleed

It is built with HEIC support but unfortunately it [needs](https://github.com/ImageMagick/ImageMagick/issues/1511) special option `-colorspace sRGB` to open HEIC.


#### ImageMagick 7

Also, almost 2 years after release, ImageMagick7 is still not included in ubuntu, so I got the *AppImage* latest version (`7.1.0-19 Q16-HDRI x86_64 2021-12-18`) installed from [instructions](https://askubuntu.com/a/1309857/220798) ; 
but is [does not have HEIC](https://github.com/ImageMagick/ImageMagick/issues/4666) built-in.
