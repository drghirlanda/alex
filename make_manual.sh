#!/bin/bash -ex
# we use sed to replace longtable with table... 
cd Docs
pandoc --template AlexManual.tpl -V geometry="margin=1in" -V fontsize=11pt -s --toc AlexManual.md -t latex -o - > AlexManual.tex
pdflatex AlexManual.tex
pdflatex AlexManual.tex
pdflatex AlexManual.tex
pandoc -s AlexManual.md -o AlexManual.html
cd ..
