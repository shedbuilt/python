#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
SHED_PKG_LOCAL_DOCDIR="/usr/share/doc/${SHED_PKG_NAME}-${SHED_PKG_VERSION}"
# Permit installation of the SSL module
sed -i '/#SSL/,+3 s/^#//' Modules/Setup.dist &&
# Configure
./configure --prefix=/usr \
            --enable-shared \
            --with-system-expat \
            --with-system-ffi \
            --with-ensurepip=yes \
            --enable-unicode=ucs4 &&
# Build and Install
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install &&
chmod -v 755 "${SHED_FAKE_ROOT}/usr/lib/libpython2.7.so.1.0" || exit 1
# Install Documentation
if [ -n "${SHED_PKG_LOCAL_OPTIONS[docs]}" ]; then
    wget https://docs.python.org/ftp/python/doc/2.7.15/python-2.7.15-docs-html.tar.bz2 &&
    install -v -dm755 "${SHED_FAKE_ROOT}${SHED_PKG_LOCAL_DOCDIR}/html" &&
    tar --strip-components=1  \
        --no-same-owner       \
        --no-same-permissions \
        -C "${SHED_FAKE_ROOT}${SHED_PKG_LOCAL_DOCDIR}/html" \
        -xvf python-2.7.15-docs-html.tar.bz2
fi
