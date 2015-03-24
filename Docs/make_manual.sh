#!/bin/bash -ex
pandoc --template Manual.tpl -V geometry="margin=1in" -V fontsize=12pt -s --toc Manual.md -o Manual.pdf
pandoc -s Manual.md -o Manual.html
