#!/bin/bash
# if interactive session & fish is installed, then use fish
if [[ $- == *i* ]] && command -v fish &> /dev/null; then
    exec fish
fi
