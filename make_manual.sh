#!/bin/bash -ex
MAN="Docs/Manual"
pandoc --template $MAN.tpl -V geometry="margin=1in" -V fontsize=12pt -s --toc $MAN.md -o $MAN.pdf
pandoc -s $MAN.md -o $MAN.html
