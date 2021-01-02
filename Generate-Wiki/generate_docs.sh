#! env sh
# filename: generate_docs.sh

# This command must be executed with the following:
#   1. run inside the "Generate-Wiki" directory
#   2. have the wiki repository cloned at ../../Programming-Tutorial.wiki
#

# TODO: validate assumptions here...

# version 1 of the command:
# find . -name "*.md" -exec sh -c 'm4 definitions.m4 "$0" > "../../Programming-Tutorial.wiki/$0"' {} \;

# find the md.m4 files
# for each file, 
# run the m4 command
# to do this we need to rename the files from *.md.m4 to *.md
# and place these files in the wiki directory

# we call the realpath command here so that it fails fast
# if the wiki directory does not exist

find . -name "*.md.m4" -exec sh -c 'rename=$(echo "$0" | perl -lane "print /(.*)[.]m4/"); echo "m4 definitions.m4 \"$(realpath "$0")\" > \"$(realpath "../../Programming-Tutorial.wiki/$rename")\""' {} \;