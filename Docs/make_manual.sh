#!/bin/bash -ex
pandoc -V geometry:"margin=1in" -V fontsize=12pt -s --toc Manual.md -o Manual.pdf

pandoc -V -s --toc Manual.md -o Manual.html
