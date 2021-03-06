#!/usr/bin/env expect
# Test the tutorial
# run from the 'src' directory

__code_license_header_hash_style__

# test files
set t1step1file "./T1/step-1-setup/windows-setup.cmd"
if {[file exists $t1step1file]} {
  puts "Success! T1 Step 1 file check"
} else {
  puts "Error (file $t1step1file missing)!"
  exit 1
}

puts "\nSuccess! T1 Step 1\n"

set t1step2file "./T1/step-2-command-line-101/hello-world.tcl"
set outputT1Step2 { "spawn echo Hello World from TCL/Expect!\n" "Hello World from TCL/Expect!\n" "Error!\n" }

if {[file exists $t1step2file]} {
  puts "Success! T1 Step 2 file check"
} else {
  puts "Error (file $t1step2file missing)!"
  exit 1
}

spawn $t1step2file

# puts [expr [llength $outputT1Step2]]
for {set index 0} {$index < [expr [llength $outputT1Step2]]} {incr index +1} {
  # puts [lindex $outputT1Step2 $index]
  expect {
    "\n" {
      puts "Success (line $index)!"
    }
    default {
      puts "Error (line $index)!"
      puts [lindex $outputT1Step2 $index]
      exit 1
    }
  }
}

puts "\nSuccess! T1 Step 2\n"

set t1step3fileList { "./T1/step-3-version-control-101/download-repository.tcl" "./T1/step-3-version-control-101/hello-world.tcl" }
set outputT1Step3 { "spawn echo Hello World from TCL/Expect!\n" "Hello World from TCL/Expect!\n" "Error!\n" }

for {set index 0} {$index < [expr [llength $t1step3fileList]]} {incr index +1} {
  if {[file exists [lindex $t1step3fileList $index]]} {
    puts "Success! T1 Step 3 file check"
  } else {
    puts "Error (file [lindex $t1step3fileList $index] missing)!"
    exit 1
  }
}

spawn [lindex $t1step3fileList 1]

for {set index 0} {$index < [expr [llength $outputT1Step3]]} {incr index +1} {
  expect {
    "\n" {
      puts "Success (line $index)!"
    }
    default {
      puts "Error (line $index)!"
      puts [lindex $outputT1Step3 $index]
      exit 1
    }
  }
}

puts "\nSuccess! T1 Step 3\n"
