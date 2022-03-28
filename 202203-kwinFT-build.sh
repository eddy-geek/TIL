#!/usr/bin/env bash
 
# Code by raba https://www.phoronix.com/forums/forum/software/desktop-linux/1308039?p=1308547#post1308547
# This script is for building KWinFT on a Debian system.
#
# It:
# - downloads everything necessary for building the project
# - checks out FDBuild and KWinFT from their Git HEAD
# - installs all build dependencies of KWinFT
# - creates nasty symlinks for python/python3 and fdbuild
# - removes some small and optional projects from the KDE build list, which currently fail to configure or compile
# - finally builds KWinFT
#
# It has some "TODO"s and comments which you should probably read before executing it,
# although it runs fine out of the box on a recent system.
#
# It also needs Debian's "experimental" release for wlroots >= 0.15.0
# The necessary packages are called "libwlroots-dev" and "libwlroots10", so you can whitelist them specifically.
#
#
# This script is released under the Public Domain "CC0" "No Rights Reserved".
# See: https://creativecommons.org/share-your-work/public-domain/cc0/
#
# +------------------------------------------------+
# | THIS SCRIPT COMES WITH ABSOLUTELY NO WARRANTY! |
# |             USE AT YOUR OWN RISK!              |
# +------------------------------------------------+
#
# Today is 2022-02-11.
# Have fun.
#
 
 
 
# Wrong user?
if [ "$(id -u)" -eq "0" ]; then
  echo "Please do not run this as root. Exiting now..."
  exit
fi
 
 
 
 
 
echo
echo "--- Set some environment variables ---"
 
echo
echo "Setting some environment variables..."
 
FDBUILD_CLONE_ROOT=~
KWINFT_CLONE_ROOT=~
 
BUILD_DIR=~/k
 
FDBUILD_EXECUTABLE=${FDBUILD_CLONE_ROOT}/fdbuild/fdbuild.py
 
TEMPLATE_NAME_KWINFT=kwinft-plasma-meta
 
 
 
 
 
# Enable if desired (you probably should):
# ----------------------------------------
#
# echo
# echo "--- Update the package cache ---"
#
# echo
# echo "Updating the package cache..."
# sudo apt-get update || exit 1
 
 
 
 
 
# Enable if desired (you probably should):
# ----------------------------------------
#
# echo
# echo "--- Upgrade the system ---"
#
# echo
# echo "Upgrading the system..."
# sudo apt-get --yes upgrade || exit 1
 
 
 
 
 
echo
echo "--- Clone FDBuild ---"
 
echo
echo "Going to correct directory but first making sure it exists..."
mkdir --parents "${FDBUILD_CLONE_ROOT}" || exit 1
cd "${FDBUILD_CLONE_ROOT}" || exit 1
 
echo
echo "Cloning FDBuild..."
if [ ! -d "fdbuild" ]; then
  git clone "https://gitlab.com/kwinft/fdbuild.git" || exit 1
else
  echo "Skipping clone, target directory already exists..."
fi
 
 
 
 
 
echo
echo "--- Clone KWinFT ---"
 
echo
echo "Going to correct directory but first making sure it exists..."
mkdir --parents "${KWINFT_CLONE_ROOT}" || exit 1
cd "${KWINFT_CLONE_ROOT}" || exit 1
 
echo
echo "Cloning KWinFT..."
echo "See: https://gitlab.com/kwinft/kwinft/-/blob/master/README.md"
if [ ! -d "kwinft" ]; then
  git clone "https://gitlab.com/kwinft/kwinft.git" || exit 1
else
  echo "Skipping clone, target directory already exists..."
fi
 
 
 
 
 
echo
echo "--- Prepare the environment for FDBuild ---"
 
echo
echo "Installing Python 3 and toolkits necessary for compilation..."
echo "See: https://gitlab.com/kwinft/fdbuild/-/blob/master/README.md"
sudo apt-get install --yes \
  python3 python3-yaml \
  git cmake autoconf meson make ninja-build \
  || exit 1
 
echo
echo "Creating symlink from python to python3..."
echo "See: https://gitlab.com/kwinft/fdbuild/-/issues/47"
if [ ! -f "/usr/bin/python" ]; then
  sudo ln -s "/usr/bin/python3" "/usr/bin/python" || exit 1
else
  echo "Skipping symlinking, target file already exists..."
fi
 
echo
echo "Creating symlink from fdbuild to fdbuild.py..."
if [ ! -f "/usr/bin/fdbuild" ]; then
  sudo ln -s "${FDBUILD_EXECUTABLE}" "/usr/bin/fdbuild" || exit 1
else
  echo "Skipping symlinking, target file already exists..."
fi
 
 
 
 
 
# TODO: needs libwlroots-dev:0.15.0 from experimental, sid just has 0.14.x
 
echo
echo "--- Install necessary packets for compilation of KWinFT ---"
 
echo
echo "Installing necessary packets for compilation of KWinFT..."
echo "See: https://gitlab.com/kwinft/kwinft/-/blob/master/CONTRIBUTING.md"
# Found out by hours of trial and error during compilation... structured by project
sudo apt-get install --yes \
  qtbase5-dev qtdeclarative5-dev qtbase5-private-dev \
  libpolkit-gobject-1-dev libpolkit-agent-1-dev \
  gperf \
  libxslt1-dev \
  libqt5x11extras5-dev libqt5waylandclient5-dev libkf5wayland-dev \
  qttools5-dev \
  libxcb-keysyms1-dev libxcb-res0-dev libxfixes-dev libxcb*-dev \
  libqt5svg5-dev \
  flex bison \
  libgpgmepp-dev libgcrypt-dev libgpgme-dev \
  libboost-all-dev \
  libx11-xcb-dev \
  qtquickcontrols2-5-dev \
  qtscript5-dev \
  wayland-protocols \
  libattr1-dev \
  kscreenlocker-dev \
  mesa-common-dev libgl1-mesa-dev libglu1-mesa-dev \
  liblmdb-dev \
  libsm-dev \
  libnm-dev \
  libzxingcore-dev libqrencode-dev \
  qtwayland5-private-dev \
  libjpeg-dev libgif-dev \
  libpam0g-dev \
  liblzma-dev \
  libgbm-dev libpipewire-0.3-dev liblcms2-dev libcap-dev libqaccessibilityclient-qt5-dev libepoxy-dev \
  libpcap-dev libsensors-dev \
  libqalculate-dev \
  libappstream-dev libpackagekitqt5-dev libappstreamqt-dev libappmenu-gtk2-parser-dev libappmenu-gtk3-parser-dev \
  libpulse-dev \
  modemmanager-dev \
  intltool libaccounts-qt5-dev libkaccounts-dev liboauth2-dev signon-plugins-dev signon-plugin-oauth2-dev xserver-xorg-input-libinput-dev xserver-xorg-input-evdev-dev xserver-xorg-input-synaptics-dev libibus-1.0-dev libscim-dev xserver-xorg-dev \
  qtmultimedia5-dev \
  libxxf86vm-dev \
  libcanberra-dev \
  libcups2-dev \
  libqt5sensors5-dev \
  || exit 1
 
 
 
 
 
echo
echo "--- Initialize project from template with FDBuild ---"
 
echo
echo "Going to correct directory but first making sure it exists..."
mkdir --parents "${BUILD_DIR}" || exit 1
cd "${BUILD_DIR}" || exit 1
 
# TODO: Modify installation target path if desired
 
echo
echo "Initializing project from template with FDBuild..."
if [ ! -d "${TEMPLATE_NAME_KWINFT}" ]; then
  # TODO: "sudo" necessary because some built items get stored into the local system; maybe fixable?
  sudo "${FDBUILD_EXECUTABLE}" --init-with-template "${TEMPLATE_NAME_KWINFT}" || exit 1
else
  echo "Skipping --init-with-template, target directory already exists..."
fi
 
 
 
 
 
echo
echo "--- Disable some KDE projects from the build file, which are not buildable yet ---"
 
echo
echo "Roman Gilg, 2022-02-10: \"Some of the KDE repos are not possible to being built at the moment.\""
 
# This is the filename
filenameKdeFdbuild=${BUILD_DIR}/${TEMPLATE_NAME_KWINFT}/kde/fdbuild.yaml
filenameExt=.bak
 
echo
echo "Patching ${filenameKdeFdbuild}..."
 
# Comment out the following entries ("- something" -> "#- something"):
# TODO: "sudo" necessary because some built items get stored into the local system; maybe fixable?
sudo sed --in-place=${filenameExt} --expression='s/\(^- kuserfeedback\)/#\1/'        "${filenameKdeFdbuild}" || exit 1
sudo sed --in-place=${filenameExt} --expression='s/\(^- breeze-grub\)/#\1/'          "${filenameKdeFdbuild}" || exit 1
sudo sed --in-place=${filenameExt} --expression='s/\(^- breeze-gtk\)/#\1/'           "${filenameKdeFdbuild}" || exit 1
sudo sed --in-place=${filenameExt} --expression='s/\(^- breeze-plymouth\)/#\1/'      "${filenameKdeFdbuild}" || exit 1
sudo sed --in-place=${filenameExt} --expression='s/\(^- kde-gtk-config\)/#\1/'       "${filenameKdeFdbuild}" || exit 1
sudo sed --in-place=${filenameExt} --expression='s/\(^- kscreen\)/#\1/'              "${filenameKdeFdbuild}" || exit 1
sudo sed --in-place=${filenameExt} --expression='s/\(^- ksystemstats\)/#\1/'         "${filenameKdeFdbuild}" || exit 1
sudo sed --in-place=${filenameExt} --expression='s/\(^- plasma-systemmonitor\)/#\1/' "${filenameKdeFdbuild}" || exit 1
sudo sed --in-place=${filenameExt} --expression='s/\(^- plymouth-kcm\)/#\1/'         "${filenameKdeFdbuild}" || exit 1
sudo rm "${filenameKdeFdbuild}${filenameExt}" || exit 1
 
unset filenameKdeFdbuild
unset filenameExt
 
 
 
 
 
echo
echo "--- Build it! ---"
 
echo
echo "Going to correct directory but first making sure it exists..."
cd "${BUILD_DIR}/${TEMPLATE_NAME_KWINFT}" || exit 1
 
echo
echo "Building it..."
# TODO: "sudo" necessary because some built items get stored into the local system; maybe fixable?
sudo "${FDBUILD_EXECUTABLE}" || exit 1
 
# This is the command to continue the building process of the projects again from where it failed:
# sudo fdbuild --resume-from <project-that-failed>
 
 
 
 
 
echo
echo "--- Done ---"
 
echo "You're all set!"
echo "See https://gitlab.com/kwinft/kwinft/-/blob/master/CONTRIBUTING.md how to start a desktop session in different ways."
 
