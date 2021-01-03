__project_under_construction_flag__
# Step 3: Your First C Program

We will move quickly through this next step, but will show you how to download the Git repository with the answers. 

Open your Shell and navigate to a good location to store the code and run the following:
```Bash
$ git clone __project_repo__
$ cd Programming-Tutorial
$ ls
```

You should see the folders `T1` and `T2` with all of the code files and answers. You can now follow along and use the tutorials folder as a good location to store your code.

This step has the following parts:
* [Part 1 Hello World](#part-1-hello-world)
* [Part 2 Test Hello World](#part-2-test-hello-world)
* [Part 3 Compile Flags](#part-3-compile-flags)
<!-- * [Part 4 Introduction to Functions](#part-4-introduction-to-functions) -->

## Part 1 Hello World
Create a file named `main.c` in the directory `tutorials/step-3-hello-world/1-Hello-World` and copy the following code to it.

```C
int main ( ) {
  write( 1, "Hello World", 12 );
  return 0;
}
```

Open up a shell and change directories so that when you list the files you see the file `main.c`. Type the following command to compile your code:

```
$ gcc -w main.c -o main
```

The `-w` option will ignore all warnings, which for now is ok. The `-o` option tells gcc that the output should be named `main`.  On windows you will see a file `main.exe` on \*nix you will see a file `main`. They are equivalent files.

On Windows you can run the following:

```
$ main.exe
```

On \*nix and Windows systems with Cygwin you can run the following:

```
$ ./main
```

There is a lot more going on here than can be explained in shorthand, and there are much better resources and classes to go through all of the details. We leave you to the references and the Internet if you would like to learn more about what just happened to go from code to a program. 

Some good Google search terms that may help you along your way:
* Keywords reserved words
* Main function
* Macros
* Variables
* Types
* Compile warning and compile errors
* Linking and compiling
* Seg faults
* Addresses and pointers

## Part 2 Test Hello World

We will first write our tests:
1. **Given** that we provide a single text input to our program; 

    **When** we run it; 

    **Then** the program will print the text to the Shell and exits with the value 0
1. **Given** that we don't provide a single text input to our program; 

    **When** we run it; 

    **Then** the program exits without printing the input and has the value 1

To execute these tests we create a file `test.tcl`. This file must be in the same directory as our `main.c` file. We will want to remove the old program first. We already know that our program is going to compile with `gcc -w main.c -o main`.

We can run these using the `exec` function in TCL and the programs `rm` and `gcc`.

Next is the code to run our program `main`. For our first test we will `spawn` our program with the argument `"Hello World"`. We can use the `expect` command like in the first step to see that we output the text "Hello World". Finally, we get the exit code of our program with the following code:

```Tcl
esyscmd({{sed -n '33,38p' ../src/T1/step-4-hello-world/2-Test-Hello-World/test.tcl | sed 's/^/   /g' | ghead -c -1}})
```

For our second test we only need to test that the exit code is 1.

Once your tests are complete, see that when you run them that they both fail. If test one doesn't fail, it may be because your program is already printing "Hello world". Write another test to see that when you run the main program with "Another test" that the test fails.

Here is a version of the `test.tcl` file you can base your code off of:

```Tcl
esyscmd({{sed -n '9,57p' ../src/T1/step-4-hello-world/2-Test-Hello-World/test.tcl | sed 's/^/   /g' | ghead -c -1}})
```

Now that we have failing tests, we will now modify the main function to accept what is called an input argument and to output this to the Shell. 

Modify your `main.c` file with the following:
```C
esyscmd({{sed -n '10,25p' ../src/T1/step-4-hello-world/2-Test-Hello-World/main.c | sed 's/^/   /g' | ghead -c -1}})
```

We've left an error in the code for you to fix. Once it is correct, you should see that your tests now all pass!

How does this all work? We will go through this program line by line.

We change the main function from `int main()` to `int main ( int argc, const char* argv[] )` so that it will accept input arguments or parameters. The variable `argc` is the number of length of the array `argv`. The `const char* argv[]` is an array of the arguments. In C, we call `char*` C strings, and the square brackets let us know that this variable is what we call an array. An array is a group of items that we can access. In C, arrays are accessed using the set of numbers that we call index numbers. Index numbers start at 0 and go until the number of items minus one. If we have a group of 5 numbers and want to access the first one we use the first index value of 0. This is a topic that you should work out on pen and paper. So wrapping up the function arguments, the variable `argv` is an array of strings.

<!-- TODO Add picture back

Fig 1: This is a depiction of an array. If this is the first time you've heard about this concept or the 5th time, it can be confusing to understand about accessing arrays when they go from one dimension to two or more dimensions. The line shown in the figure could represent a 1 dimensional array, 2 dimensional array of two elements with five sub-elements or of 5 elements with 2 sub-elements. The only difference you care about is when you need to perform matrix operations or other advanced access techniques. Even if you declare this as a two dimensional array, you can still access the information as if it was a single dimension.  -->


With `int exit_value = -1;` we next declare a variable to hold our exit code and initialize it with a value of `-1` so we can tell if our program exited unexpectedly. 

Next, we check with `if ( argc == 2 )` that we only have 2 arguments. __We'll come back to this point of 2 arguments in a bit.__

If we have two arguments, then we find the length of the text passed in with the following lines. First we create a variable to hold our place, then while the current character in the string passed in isn't the null character or `\0` (this is how C lets you know that you've reached the end of your string) we increment `i`:

```C
    while( argv[1][i] != '\0' ) {
      i = i + 1;
    }
```

Next we can output the string in `argv` to the Shell with `write(1, argv[1], i);`.

We then set the `exit_value` variable which holds our exit code to 0 now that we've finished outputting the information to the Shell. 

In the `else` block we set the exit code to 1 because any time the program doesn't perform the print there is an assumption of error. 

Finally, we return from our main function, or end our program and return the exit value with `return exit_value;`.

What is in the first index location of `argv`? What would happen if you set the while loop to access `argv[0][i]` instead?

## Part 3 Compile Flags
In the previous parts we added the `-w` flag in our compile step and even ran the program from within our test file. In this part we will go through the warnings and error system for gcc, and introduce makefiles. In the following tutorial we will show an example project with our code set so we can have a version of it that will output a lot of information for development purposes and a version that will hide this information for a production ready copy of our program.

Before we get into this, we need to have a talk about why it is important to have a development and production or release version of your code. Say that you're handing in a copy of your assignment in your class and the professor asks that you output something very specific. During your process, you would like to output many different things when the program is running like the state of a certain variable, or the inclusion of a specific mode of your program. It is very important to be able to quickly remove this information and by default not include it in your compiled code. You can comment the lines of code out manually, but doing so runs the risk of forgetting a line or worse having to spend your time manually commenting and then uncommenting the lines of code back in when you want to look at it later. Why should the default mode should always be the production mode? This avoids the accident of including too much information for people that do not need it.

Welcome to GNU make or the makefile! There is a scripting language called `makefile` which keeps track of all of the information that you want to tell gcc and other compiler programs to be able to convert your code or compile it into an executable. We will gloss over the details of compile and linking steps and leave it to you to learn more about this process on the Internet. For now, just copy this code.

### Makefile introduction

```Makefile
esyscmd({{sed -n '7,28p' ../src/T1/step-4-hello-world/3-Makefile-Hello-World/makefile | sed 's/^     /   /g' | ghead -c -1}})
```

Notice that we are now failing the build process as is shown:

```
$ make
esyscmd({{pushd ../src/T1/step-4-hello-world/3-Makefile-Hello-World > /dev/null 2>&1 && make clean > /dev/null 2>&1 && make > temp-output.log 2>&1 && popd > /dev/null 2>&1}})dnl
esyscmd({{pushd ../src/T1/step-4-hello-world/3-Makefile-Hello-World > /dev/null 2>&1 && cat temp-output.log && popd > /dev/null 2>&1}})dnl
```

Lets walk through this step by step:
1. `$ make` is the command we typed in the Shell
1. `esyscmd({{pushd ../src/T1/step-4-hello-world/3-Makefile-Hello-World > /dev/null 2>&1 && cat temp-output.log | sed -n '1p' | ghead -c -1 && popd > /dev/null 2>&1}})` is the command that make will run to compile our program
1. The following is a chunk that tells us there's something up with the `main` function.
   ```
esyscmd({{pushd ../src/T1/step-4-hello-world/3-Makefile-Hello-World > /dev/null 2>&1 && cat temp-output.log | sed -n '2p' | sed 's/^/   /g' && popd > /dev/null 2>&1}})dnl
   ```
pushdef({{__err_line_num__}}, {{esyscmd({{pushd ../src/T1/step-4-hello-world/3-Makefile-Hello-World > /dev/null 2>&1 && cat temp-output.log | perl -lane 'print /main[.]c:(\d+):\d+/' | tr -d '\n' && popd > /dev/null 2>&1}})}})dnl
pushdef({{__err_col_num__}}, {{esyscmd({{pushd ../src/T1/step-4-hello-world/3-Makefile-Hello-World > /dev/null 2>&1 && cat temp-output.log | perl -lane 'print /main[.]c:\d+:(\d+)/' | tr -d '\n' && popd > /dev/null 2>&1}})}})dnl

   The file that we need to look at is `main.c`, we then need to look at `esyscmd({{pushd ../src/T1/step-4-hello-world/3-Makefile-Hello-World > /dev/null 2>&1 && cat temp-output.log | perl -lane 'print /(main[.]c:\d+:\d+)/' | tr -d '\n' && popd > /dev/null 2>&1}})` that means the file `main.c`, line `{{}}__err_line_num__{{}}`, column `{{}}__err_col_num__{{}}`. 
   <!-- `warning` means that if we wanted to compile, it will work, but this is not recommended by the compiler.  -->
   `implicit declaration of function 'write'` means that it found a function that we didn't explicitly tell the compiler where to find it. System functions like `printf`, `write`, are assumed to be available if you don't list them with an `include` directive. Lastly the part `[-Werror,-Wimplicit-function-declaration]` is the computer code for the type of error.
1. The next few lines are the pretty version of what is at line `{{}}__err_line_num__{{}}`, column `{{}}__err_col_num__{{}}`.
   ```
esyscmd({{pushd ../src/T1/step-4-hello-world/3-Makefile-Hello-World > /dev/null 2>&1 && cat temp-output.log | sed -n '3,4p' && popd > /dev/null 2>&1}})dnl
   ```
<!-- 1. We then see that as the last step gcc will be compiling the program to make sure any warnings are treated as compile errors and should stop any further compilation progress.
   ```
   gcc -o main main.o -Wall -Werror -Wextra
   ``` -->

We now need to add the information in our code for where the compiler should find the write function. In the next part we will get into more detail about C functions. For now, we can tell gcc where to explicitly find the `write` function with an include statement at the head of our `main.c` file. The include statement will tell the compiler that there are additional code files that we want to include when we make our executable.

```
esyscmd({{sed -n '18p' ../src/T1/step-4-hello-world/3-Makefile-Hello-World/main-fixed.c | ghead -c -1}})
```

<!-- In the next tutorial we will show a finished example of a makefile that has both debug and release modes. -->

<!-- We do this with:

Create macro for testing debug
Compile flags
Compile production -->

<!-- ## Part 4 Introduction to Functions

Move write to function
Move process args to function, then to get opts as is there later
Need to start the moving to subroutines, functions, methods, all the same thing.
Astyle -- as things start getting bigger better to not have to worry about the way your code looks and let a program do that for you
Practice moving write to a new function and taking parameters
VarArgs
Introduce additional functions
Now that we've written a more complicated version of print
We need options
Introduce getopts
Next we don't need this anymore because we have a bunch of libraries in C to use
Printf
Macros for lists -- move this to an advanced tutorial
Scanf testing -- advanced tutorial

Why we have these two levels? Often you will want to have a version of your code that outputs a lot of information for helping you walk through the execution of your code without using the more advanced tools of a debugger. The following tutorial after Hello World will walk you through a GDB tutorial.
 -->
## Summary

Congrats on finishing this last step and for completing the first tutorial! You've now successfully written a tested program in C. Thank you for sticking with it. In the next tutorial we will look at a more complete project in C and make sure we cover all of the basic keywords and functionality of the language.

## References

1. Introduction to C - https://www.tutorialspoint.com/cprogramming/index.htm 
1. Another introduction to C - https://www.w3schools.in/c-tutorial/ 
1. An explanation of the usual "Hello World!" using the printf function - http://osteras.info/personal/2013/10/11/hello-world-analysis.html 
1. About the write function - https://linux.die.net/man/2/write 
1. StackOverflow about makefiles - https://stackoverflow.com/questions/2481269/how-to-make-a-simple-c-makefile#2481326
1. StackOverflow about makefiles 2 - https://stackoverflow.com/questions/1079832/how-can-i-configure-my-makefile-for-debug-and-release-builds#1080180 
1. Answers - <{{}}__project_repo_source_root__{{}}/T1/step-4-hello-world>

# Updates
* Jan 1, 2021 - Generated from m4 template

[[Previous Page|T1-02]] | [[Next Page|T2-00]]