# Filter for .csv.gz files

## Overview

A Ruby script that recursively finds all `.csv.gz` files in a given directory (also works with single files) and filters lines based on a hardcoded regex.

I needed something like this for my [csvScatterplot](https://github.com/TheMichaelHu/csvScatterplot). I Googled for a good 20 seconds and couldn't find anything, so here we are.

## Execution
** Warning: Consider backing up data beforehand as this script is data destructive **

Assign a regex to filter to `$FILTER_REGEX`
Run `./filter [target file or dir]`