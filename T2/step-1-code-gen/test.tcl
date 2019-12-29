#!/usr/bin/env expect
# The author disclaims copyright to this source code.  In place of
# a legal notice, here is a blessing:
#    May you do good and not evil.
#    May you find forgiveness for yourself and forgive others.
#    May you share freely, never taking more than you give.

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


