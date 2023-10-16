## Basic

# Package owning file
dpkg -S $path

# packages (un)install
dpkg --get-selections

# installed Manually (not just as dependency)
aptitude search '~i!~M'

# Reverse dependencies
aptitude why $package

## Cleanup

# Packages installed "manually" ie from `dpkg -i foo.deb`, or orphans not matching any upstream repo anymore.
aptitude search ~i -F "%?p %v %O" | rg 'installed locally'

## Other

# Packages installed from a given repository (here "neon")
aptitude search '?narrow(?installed, ~Oneon)' -F "%p %v %O" | column -t
#appstream 1.0.0+p22.04+vunstable+git20231016.0120-0 KDE  neon  -  Unstable  Edition:jammy  [amd64]


## Python packages

# list packages
pip freeze
mamba list

# update
mamba update --all
pip install -U $package

