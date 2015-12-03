#!/bin/bash -ex
BIN_DIR=/usr/local/bin
SHARE_DIR=/usr/local/share
PEBL_OSX=/Applications/pebl.app/Contents/MacOS/pebl
USER=$(whoami)
GROUP=wheel

# change interpreter directives to default PEBL path:
if sed -i.backup "1s@.*@#!$PEBL_OSX --fullscreen@" alex; then
    rm alex.backup
fi

for BIN in alex-init alex-manual; do
    if sed -i.backup "1s@.*@#!$PEBL_OSX@" ${BIN}; then
        rm ${BIN}.backup
    fi
done

# restore permissions (OS X 10.11 stuff):
sudo chown -R ${USER}:admin /usr/local
# install program files:
for BIN in alex alex-init alex-manual; do
    sudo install -o ${USER} -g ${GROUP} -m 0755 ${BIN} ${BIN_DIR}
done

if [ ! -d ${SHARE_DIR}/alex ]; then
    mkdir -p ${SHARE_DIR}/alex
fi

# copy files to SHARE_DIR and set their permissions:
for FILE in README.md Examples Library; do
    cp -r ${FILE} ${SHARE_DIR}/alex
    chmod 0644 ${SHARE_DIR}/alex/${FILE}
    sudo chown ${USER}:${GROUP} ${SHARE_DIR}/alex/${FILE}
done

cd Docs
for FILE in AlexManual.pdf AlexManual.html Roadmap.md; do
    cp -r ${FILE} ${SHARE_DIR}/alex
    chmod 0644 ${SHARE_DIR}/alex/${FILE}
    sudo chown ${USER}:${GROUP} ${SHARE_DIR}/alex/${FILE}
done
cd -

# set ownership and permissions on all directories in SHARE_DIR:
for DIR in $(sudo find ${SHARE_DIR}/alex -type d); do
    sudo chown ${USER}:${GROUP} ${DIR}
    chmod 0755 ${DIR}
done

# create R package and install it
cd R
R -e 'setwd("alex"); library(devtools); document()'
R CMD build alex
R CMD INSTALL alex_*.tar.gz
cd -
