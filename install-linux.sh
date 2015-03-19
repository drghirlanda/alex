#!/bin/bash -ex
BIN_DIR=/usr/bin
SHARE_DIR=/usr/share
USER=root
GROUP=root

# install program files:
for BIN in alex alex-init; do
    install -o ${USER} -g ${GROUP} -m 0755 ${BIN} ${BIN_DIR}
done

if [ ! -d ${SHARE_DIR}/alex ]; then
    mkdir -p ${SHARE_DIR}/alex
fi

# copy files to SHARE_DIR:
for FILE in README.md Docs Examples Library; do
    cp -r ${FILE} ${SHARE_DIR}/alex
    chmod 0644 ${FILE}
    chown ${USER}.${GROUP} ${FILE}
done

# set ownership and permissions on all directories in SHARE_DIR:
for DIR in $(find ${SHARE_DIR}/alex -type d); do
    chown ${USER}.${GROUP} ${DIR}
    chmod 0755 ${DIR}
done

