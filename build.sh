#!/bin/bash
./configure --prefix=/usr \
            --enable-shared \
            --with-system-expat \
            --with-system-ffi \
            --with-ensurepip=yes \
            --enable-unicode=ucs4
make -j $SHED_NUM_JOBS
make DESTDIR=${SHED_FAKE_ROOT} install
chmod -v 755 ${SHED_FAKE_ROOT}/usr/lib/libpython2.7.so.1.0
