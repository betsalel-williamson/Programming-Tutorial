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
# and place these files in the result directory

# echo "Making directory for: ($(dirname $0))";

pushd ./templates-code > /dev/null 2>&1
find . -name "*.m4" -exec sh -c 'rename=$(echo "$0" | perl -lane "print /(.*)[.]m4/"); mkdir -p $(dirname "../src/$rename"); m4 ../definitions.m4 "$(realpath "$0")" > "../src/$rename"' {} \;
mv ../src/README.md ../
popd > /dev/null 2>&1

# we call the realpath command for the wiki so that it fails fast
# if the wiki directory does not exist
pushd ./templates-wiki > /dev/null 2>&1
find . -name "*.m4" -exec sh -c 'rename=$(echo "$0" | perl -lane "print /(.*)[.]m4/"); m4 ../definitions.m4 "$(realpath "$0")" > "$(realpath "../../Programming-Tutorial.wiki/$rename")"' {} \;
popd > /dev/null 2>&1

