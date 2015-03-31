#!/bin/bash -ex
./make_patterns.m
for F in *.pbm; do
    B=$(basename $F .pbm)
    convert $F $B.gif
done
