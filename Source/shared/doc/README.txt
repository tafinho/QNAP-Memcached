QDK Build Instructions
======================
QDK is meant for you to be able to create a customized packages for QNAP Tubro NAS and this is based on micke's new QPKG develotment kit (QDK).
[1]micke http://forum.qnap.com/memberlist.php?mode=viewprofile&u=54331
[2]QDK http://forum.qnap.com/viewtopic.php?f=131&t=36132
[3]QPKG http://wiki.qnap.com/wiki/QPKG_Development_Guidelines

Prepare:
    cd ~/; svn co svn://192.168.72.101/repos/QPKG/trunk/QDK
    cd /bin; ln -sf /usr/bin/awk awk; ln -sf /usr/bin/cut cut; ln -sf /usr/bin/md5sum md5sum
    mkdir /usr/lib/qpkg; cd /usr/lib/qpkg; tar xvf ~/QDK/doc/qpkg_bin_lib.tar.gz; mv sbin ~/; cd /sbin; ln -sf ~/sbin/qpkg qpkg

Usage:
    cd YOUR_QDK_PATH
    ./bin/qbuild --create-env YOUR_QPKG_NAME
    cd YOUR_QPKG_NAME
    LD_LIBRARY_PATH=/usr/lib/qpkg ../bin/qbuild --build-arch arm-x19
    LD_LIBRARY_PATH=/usr/lib/qpkg ../bin/qbuild --extract build/YOUR_QPKG_NAME.qpkg YOUR_EXTRACT_DIR

NOTES
=====
Default shell:
Check your /bin/sh isn't dash (recommend bash)
To make it link to /bin/bash, execute below commands:
rm /bin/sh
ln -s bash /bin/sh

Get QPKG libs:
\\192.168.72.100\Public\SW_Environment\QDK\qpkg_bin_lib.tar.gz
or
svn://192.168.72.101/repos/QPKG/trunk/QDK/qpkg_bin_lib.tar.gz

Support ARCH:
                arm-x09)                         cpu_arch="armv5tejl"
                ;;
                arm-x19)                         cpu_arch="armv5tel"
                ;;
                x86)                             cpu_arch="i.86\|x86_64"
                ;;
                x86_64)                          cpu_arch="x86_64"
                ;;

Md5sum:
Make sure /bin/md5sum exists in your building environment.

Added Features by SW7
=====
* Add QPKG_BUILT_VERSION in qpkg.conf
* SYS_QPKG_CONF_FIELD_DISPLAY_NAME (可以參考 rev. 1077)
* Sys_App (可以參考 rev 407)
* QDK_DATA_PACKAGE_ADAPTOR (可以參考 rev 65)
