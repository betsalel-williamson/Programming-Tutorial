#!/usr/bin/env expect
# This first line is called a shebang (pronounced Sha-Bang) and
# will tell the shell what program to use for the following text.

# The author disclaims copyright to this source code.  In place of
# a legal notice, here is a blessing:
#    May you do good and not evil.
#    May you find forgiveness for yourself and forgive others.
#    May you share freely, never taking more than you give.

# Our first line of code we tell the expect program to run a program!
# The program to run is `echo`.
# The echo program will display text to the shell, in this case
# that is "Hello World from TCL/Expect!"
spawn echo "Hello World from TCL/Expect!"

# This next command `expect` (which is the same name as the program)
# will look at the shell and follow a command that you tell it to.
# We are looking to see the words "Hello world." and if we do
# then we output "Success!" to the shell and exit with the
# value 0.
# If we don't see the words "Hello world." then we will output
# "Error!" and exit with the value 1.
expect {
	"Hello world from." {
		puts "Success!"
		exit 0
	}
	default {
		puts "Error!"
		exit 1
	}
}

# What can we do to make this command exit with success?
# There are multiple ways to go about this.
# Method one, is to simply change the text in the expect
# command from "Hello world." to "Hello World from TCL/Expect!"
# Method two is to change the text to be more flexible
# and replace "Hello world." with the text between the
# `` characters `-nocase "hello world"`.

# Method two:
# expect {
# 	-nocase "hello world" {
# 		puts "Success!"
# 		exit 0
# 	} 
# 	default {
# 		puts "Error!"
# 		exit 1
# 	}
# }
