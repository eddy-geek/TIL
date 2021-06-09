As of June 9th, 2021, on Kubuntu Neon, Plasma 5.22, Ubuntu 20.04 trusty

# How to test for Wayland vs XWayland

Use `xeyes` :-)

# Google Chrome

Chrome 91+ supports wayland with:

google-chrome --enable-features=UseOzonePlatform --ozone-platform=wayland

+ chrome://flags #use-ozone-platform *Enabled*.

# Screen sharing

Testing on teams.microsoft.com, I see the 3 screens, but they are black.

(Note that it's worse on the Teams Electron app which is still X)

