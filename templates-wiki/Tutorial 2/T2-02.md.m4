__project_under_construction_flag__
# Crack the Code

Now that we have an understanding of come C programs it is up to you to devise a solution written in C to crack the code! 

## Requriements
1. You don't steal your algorithm to your solution
1. You use C
1. You only use the unmodified release version of `secretProgram` from `step-1-code-gen` in your code to crack the code.

## Tips

Use `system` command to execute the program. If you need to see how this works see the solution for a working example.

Think like an engineer! You can either brute force the 256 options or you can try to crack how the program generates the code.

Here's a hint. It will be quicker to use a brute force approach.

Your program may take as input the absolute path to the guess program. 

What about letting us know the results? Will it output a simple rotating status icon while it is running and then when it is complete it will output the pass code? Or just output the code that works for the next 20 seconds?

You may want to copy the makefile to compile your code that is in the solutions or the first tutorial.

Again, the way the `secretProgram` works is that it takes the current date and time down to the minute, `XOR`s this number with a hash and then that is the password. If the correct password was entered then it outputs success message and exits with the code `0`. If not, then the program displays exits with the code `1`. You can try and work out the hash and compute things manually, but in this case it will be easier to build a C program that will run the program as long as it takes to get the correct answer.

# Updates
* Jan 1, 2021 - Generated from m4 template

[[Previous Page|T2-01]] | [[Next Page|T2-03]]