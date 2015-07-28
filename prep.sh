#!/bin/bash

# Get the names of all executables in $PATH
function getnames() {
    for p in "$(echo $PATH | tr ':' '\n')"; do
        for f in "$(find $p -executable -print)"; do
            echo "$(basename -a $f)"
        done
    done
}

NAMES="$(getnames)"
LIST="$(echo $NAMES)"
./hmenu $LIST

