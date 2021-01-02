#! env sh
find . -name "*.md" -exec sh -c 'm4 definitions.m4 "$0" > "../../Programming-Tutorial.wiki/$0"' {} \;