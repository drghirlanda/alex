#!/bin/bash -ex
# we use sed to replace longtable with table... 
cd Docs
pandoc --template AlexManual.tpl -V geometry="margin=1in" -V fontsize=11pt -s --toc AlexManual.md -t latex -o - | sed -re 's/\\begin\{longtable\}\[c\]/\\begin\{table\*\}\[t\]\\begin\{center\}\\small\\begin\{tabular\}/g' | sed -re 's/\\end\{longtable\}/\\end\{center\}\\end\{table\*\}/g' | sed -re 's/\\caption\{/\\end\{tabular\}\\caption\{/g' > AlexManual.tex
pdflatex AlexManual.tex
pdflatex AlexManual.tex
pdflatex AlexManual.tex
pandoc -s AlexManual.md -o AlexManual.html
cd ..
