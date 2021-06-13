#!/bin/bash

# x000, x001 ...
split -l 1000000 -a 3 -d $1
