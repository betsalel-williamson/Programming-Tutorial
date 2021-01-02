#!/usr/bin/env expect
# This first line is called a shebang (pronounced Sha-Bang) and
# will tell the shell what program to use for the following text.

__code_license_header_hash_style__

spawn echo "Hello World from TCL/Expect!"

# What can we do to make this command exit with success?
# There are multiple ways to go about this.
# Method one, is to simply change the text in the expect
# command from "Hello world." to "Hello World from TCL/Expect!"
# Method two is to change the text to be more flexible
# and replace "Hello world." with the text 
# "Hello World from TCL/Expect!" or with `-nocase "hello world"`.
# The '-nocase' argument allows the check to ignore the
# case of the text so it could be upper or lower case.

# Method two:
expect {
	-nocase "hello world" {
		puts "Success!"
		exit 0
	} 
	default {
		puts "Error!"
		exit 1
	}
}
