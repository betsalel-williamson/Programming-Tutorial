#! env sh
# filename: generate_docs.sh

# TODO: validate assumptions here...

# ensure that we start executing in
# the script's location
pushd $(dirname $0) > /dev/null 2>&1 

# TODO: check that there are no arguments...

# TODO: check for Programming-Tutorial.wiki
#       find ../ -name .git
#       get the different names ...
#       config should download the wiki 
#       Possibly:  basename -s .git `git config --get remote.origin.url`
#       https://stackoverflow.com/questions/15715825/how-do-you-get-the-git-repositorys-name-in-some-git-repository
#
#       $ find ../ -name .git -exec sh -c 'basename $(cat $0/config | perl -lane "print /= (.*)[.]git/")' {} \;
#       Programming-Tutorial.wiki
#       Programming-Tutorial
#       

# TODO: have the wiki repository cloned at ../../Programming-Tutorial.wiki
#       we don't need to worry about the name, just that it should
#       be there...

pushd ./templates-code > /dev/null 2>&1

# format code
astyle "./*.c.m4" "./*.h.m4" \
--indent=spaces=2 \
--indent-switches \
--indent-after-parens \
--break-blocks \
--pad-oper \
--pad-comma \
--pad-paren-in \
--break-one-line-headers \
--add-braces \
--add-one-line-braces \
--max-code-length=80 \
--mode=c \
--recursive \
--verbose

# find the md.m4 files
# for each file, 
# run the m4 command
# to do this we need to rename the files from *.md.m4 to *.md
# and place these files in the result directory

find . -name "*.m4" -exec sh -c 'rename=$(echo "$0" | perl -lane "print /(.*)[.]m4/"); mkdir -p $(dirname "../src/$rename"); m4 ../definitions.m4 "$(realpath "$0")" > "../src/$rename"' {} \;
mv ../src/README.md ../
popd > /dev/null 2>&1

pushd ./src > /dev/null 2>&1

# ensure that tcl scripts can be executed
find . -name "*.tcl" -exec chmod +x {} \;

# run test files
find . -name "test*.tcl" -exec sh -c 'echo "Running test: ($(basename "$0")) in ($(dirname "$0"))"; pushd "$(dirname "$0")" > /dev/null 2>&1; ./$(basename "$0"); popd > /dev/null 2>&1' {} \;

# TODO: clean up output format of test files

popd > /dev/null 2>&1

# we call the realpath command for the wiki so that it fails fast
# if the wiki directory does not exist
pushd ./templates-wiki > /dev/null 2>&1

# TODO: replace '../../Programming-Tutorial.wiki' with location of wiki
#       it may not be 'Programming-Tutorial.wiki' because the user can
#       clone a repo into any folder...

find . -name "*.m4" -exec sh -c 'rename=$(echo "$0" | perl -lane "print /(.*)[.]m4/"); m4 ../definitions.m4 "$(realpath "$0")" > "$(realpath "../../Programming-Tutorial.wiki/$rename")"' {} \;
popd > /dev/null 2>&1

# TODO: check all links to see that they are valid...
# print a list of links and basic context (from file, line)
# output to MD file and save to a temp file

# TODO: comb through and add all "todo's" to the Notes file.
# TODO: remove todo's from output

popd > /dev/null 2>&1 # go back to where ever...