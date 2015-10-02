#!/bin/bash -ex
BIN_DIR=/usr/bin
SHARE_DIR=/usr/share
USER=root
GROUP=root

# install program files:
for BIN in alex alex-init alex-manual; do
    install -o ${USER} -g ${GROUP} -m 0755 ${BIN} ${BIN_DIR}
done

if [ ! -d ${SHARE_DIR}/alex ]; then
    mkdir -p ${SHARE_DIR}/alex
fi

# copy files to SHARE_DIR and set their permissions:
for FILE in README.md Examples Library; do
    cp -r ${FILE} ${SHARE_DIR}/alex
    chmod 0644 ${SHARE_DIR}/alex/${FILE}
    chown ${USER}.${GROUP} ${SHARE_DIR}/alex/${FILE}
done

cd Docs
for FILE in AlexManual.pdf AlexManual.html Roadmap.md; do
    cp -r ${FILE} ${SHARE_DIR}/alex
    chmod 0644 ${SHARE_DIR}/alex/${FILE}
    chown ${USER}.${GROUP} ${SHARE_DIR}/alex/${FILE}
done
cd -

# set ownership and permissions on all directories in SHARE_DIR:
for DIR in $(find ${SHARE_DIR}/alex -type d); do
    chown ${USER}.${GROUP} ${DIR}
    chmod 0755 ${DIR}
done

# create R package and install it
cd R
R CMD build alex
R CMD INSTALL alex_*.tar.gz
cd -
