#!/usr/bin/env expect
#
#   Copyright (c) 2018 Betsalel "Saul" Williamson
#  
#   Permission is hereby granted, free of charge, to any person obtaining a
#   copy of this software and associated documentation files (the "Software"),
#   to deal in the Software without restriction, including without limitation
#   the rights to use, copy, modify, merge, publish, distribute, sublicense,
#   and/or sell copies of the Software, and to permit persons to whom the
#   Software is furnished to do so, subject to the following conditions:
#  
#   The above copyright notice and this permission notice shall be included
#   in all copies or substantial portions of the Software.
#  
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
#   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
#   IN THE SOFTWARE.
#  

proc testMustProvideCode args {

    spawn ./debug/secretPassword -f "Hello World"
	expect {
		-nocase "you must pass in a code" {
			puts "\n[lindex [info level 0] 0] passed\n"
		}
		default {
			puts "\n!! [lindex [info level 0] 0] test failed !!\n"
			exit 1
		}
	}
}

proc testProvidedCode args {

    spawn ./debug/secretPassword -c 1234
	expect {
		-nocase "Found code 1234" {
			puts "\n[lindex [info level 0] 0] passed\n"
		}
		default {
			puts "\n!! [lindex [info level 0] 0] test failed !!\n"
			exit 1
		}
	}
}

proc testProvidedInvalideCode args {

    spawn ./debug/secretPassword -c 1234
	expect {
		-nocase "was incorrect. Try again." {
			puts "\n[lindex [info level 0] 0] passed\n"
		}
		default {
			puts "\n!! [lindex [info level 0] 0] test failed !!\n"
			exit 1
		}
	}
}

proc testForceCode args {

    spawn ./debug/secretPassword -c 1234 -f 1234
	expect {
		-nocase "Congrats! You entered in the right code!" {
			puts "\n[lindex [info level 0] 0] passed\n"
		}
		default {
			puts "\n!! [lindex [info level 0] 0] test failed !!\n"
			exit 1
		}
	}
}

proc testInvalidInput args {

    spawn ./debug/secretPassword -c foo -f 1234
	expect {
		-nocase "Invalid input" {
			puts "\n[lindex [info level 0] 0] passed\n"
		}
		default {
			puts "\n!! [lindex [info level 0] 0] test failed !!\n"
			exit 1
		}
	}
}

if {[catch {exec make debug} result] == 0} { 
    testMustProvideCode
    testProvidedCode
    testProvidedInvalideCode
    testInvalidInput
    testForceCode

    puts "\n\nAll tests passed\n\n"
} else { 
    puts "Error: $result" 
    exit 1
} 


