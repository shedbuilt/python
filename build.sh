#!/bin/bash
./configure --prefix=/usr \
            --enable-shared \
            --with-system-expat \
            --with-system-ffi \
            --with-ensurepip=yes \
            --enable-unicode=ucs4
make -j $SHED_NUMJOBS
make DESTDIR=${SHED_FAKEROOT} install
chmod -v 755 ${SHED_FAKEROOT}/usr/lib/libpython2.7.so.1.0
