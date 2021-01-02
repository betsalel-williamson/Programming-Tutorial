#!/bin/env expect

__code_license_header_hash_style__

# delete the executable file
exec rm main
# compile the file
exec gcc -w main.c -o main

### Test 1 ###
#
# Given that we provide a single text input to our program,  
# When we run it, 
# Then the program will print the text to the Shell 
#    and exits with the value 0
#

spawn ./main "Hello World"
expect {
	-nocase "hello world" {
		puts "\nFound output of: Hello World\n"
	}
	default {
		puts "\nTest failed. Expected Hello world\n"
	}
}

expect eof
catch wait result
if {[lindex $result 3] == 0} {
	puts "Exited successfully.\n"
} else {
	puts "Test failed with code [lindex $result 3].\n"
}

### Test 2 ###
#
# Given that we don't provide a single text input to our 
#    program, 
# When we run it,
# Then the program exits without printing the input and 
#    has the value 1
#

spawn ./main
expect eof
catch wait result

if {[lindex $result 3] == 1} {
	puts "Exited successfully.\n"
} else {
	puts "Test failed with code [lindex $result 3].\n"
}

# What happens when we try calling main 
# with more than 1 parameter?
# $ ./main Hello World
# Hello world must be in quotes in order for this
# to be considered a single parameter
