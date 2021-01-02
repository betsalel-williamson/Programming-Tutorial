#!/usr/bin/env expect

__code_license_header_hash_style__

# package require platform

# create a repository folder in your documents directory
# If using Cygwin
switch $::tcl_platform(os) {
  CYGWIN_NT-10.0 {
     set homeDirectory $env(HOMEDRIVE)$env(HOMEPATH)
  }
  default {
     set homeDirectory ~/
  }
}

# make directory Documents/Code/
# change to
set dir [file join $homeDirectory Documents\\Code\\]

if {[file exists $dir]} { 
    puts "Directory exists!"
} else {
	file mkdir $dir
}

cd $dir
puts [pwd]

# dangerous command to clear out the directory before download
if {[file exists SERC-Pitt-C-Programming-Tutorial]} { 
	puts "Do you want to clear out the directory first? (Y/N)"
	gets stdin someVar

	if {[string match Y $someVar]} {
		exec rm -rf SERC-Pitt-C-Programming-Tutorial
	}
} 

if { [catch { spawn git clone https://github.com/betsalel-williamson/C-Programming-Tutorial.git } msg] } {
   puts "Something seems to have gone wrong:"
   puts "Information about it: $::errorInfo"
}

expect {
	eof {
		puts "Finished downloading."		
	}
}

puts [spawn ls -la SERC-Pitt-C-Programming-Tutorial]

expect {
	eof {
		puts "Finished listing directory."		
	}
} 
# git clone

## make change to file
## git add change
## git commit with comment
## git revert commit
