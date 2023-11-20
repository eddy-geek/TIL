```
pip3 install git+https://github.com/Linux4/samloader.git
samloader -m SM-G998U1 -r TMB download -v $(samloader -m SM-G998U1 -r TMB checkupdate) -D -O .
unzip SM-G998U1_3_20231003151051_ljfvxhjji2_fac.zip
#reboot into download mode (press all 3 keys)
odin4 -l
odin4 \                                                                                                                                                ⏎
 -b BL_G998U1*_user_low_ship_MULTI_CERT.tar.md5\
 -a AP_G998U1*_user_low_ship_MULTI_CERT_meta_OS13.tar.md5\
 -c CP_G998U1*_user_low_ship_MULTI_CERT.tar.md5\
 -s HOME_CSC_OYM_G998U1*_user_low_ship_MULTI_CERT.tar.md5
```
