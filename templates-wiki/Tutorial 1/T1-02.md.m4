__project_under_construction_flag__
# Step 2: Command Line 101

We will get started by opening up a shell or terminal window. Find the <kbd>meta</kbd> key on your keyboard as the key with the Windows logo on standard PC keyboards, or as the <kbd>command</kbd> key on Mac keyboards. We will refer to both these keys as the <kbd>meta</kbd> key for the rest of this guide.

Welcome to the command line. Things will look a little scary here if this is the first time you’ve opened up what is called a command-line interface (CLI) shell. Usually, modern systems will open a graphical user interface (GUI) shell that operates with icons, apps, clicks, swipes, etc. A CLI shell is a text-based or keyboard-only interface to your computer. Throughout the rest of this guide we will simply refer to the CLI shell as the Shell. **We will be using the word shell to mean the Windows Command Prompt and \*nix CLI shells.** The Shell is a simple text interface to your computer and will open up a new world of commands for you to run on your machine. 

_On the Internet you may sometimes see the *nix system. This is shorthand meaning Unix and Linux systems. These two systems while often similar in many respects for the shell language, there are difference in the commands available to the two systems. In the early 2000s, Apple decided to adopt the POSIX standard of Unix for their operating system so that their shell or Terminal provides a standard set of commands that you can expect without any additional or special software installed._

On Linux, you open the Shell by opening up the terminal, konsole, shell or prompt (depending on your specific flavor of Linux like Red Hat, Ubuntu, SUSE, Fedora etc.). Each flavor has it's preferred name for the Shell.

On Mac, you open the Shell through the Terminal App by pressing <kbd>meta</kbd>+<kbd>space</kbd> and typing in `Terminal`.

On Windows operating systems, you open up the Shell through the regular command line by pressing <kbd>meta</kbd>+<kbd>R</kbd> and typing in `cmd`, or the Power-Shell by pressing <kbd>meta</kbd>+<kbd>R</kbd> and typing in `powershell`.

Your computer will know about the commands available to the Shell because there is a global variable called `PATH` that stores a list of locations for all the programs that the Shell can use. You may have noticed that in the Windows script example we modified this variable with the `setx` command to ensure that Cygwin was added. What this did was add all of the new programs that Cygwin installed so that we can more easily access them in the Shell. On Linux and Mac, these commands are by default installed in a directory ( `/usr/bin` or `/usr/local/bin` ) that is being watched by the Shell so that all new commands are added.

<!--TODO: add some historical information about the shell and 80x24, classic green, the console lives on even in a web browser.-->

In this first tutorial we will compile our code from the command line we will walk you through some basic commands to navigate around the Shell. Since this guide is meant more to focus on C code we will only show you the commands needed to run this step and point you to a couple of good tutorials already available on the Internet in the references section of this step. 

## So what do commands in the Shell look like?
In the following code snippets we show installing a program on Linux, and on Windows using a file copy program to backup a folder. 

On the Internet you will often see instructions to run code in the command line for \*nix systems like:
`$ sudo apt-get install gcc`

Note that there is a `$` character as the first character on the line. This is sometimes the `#` character or another symbol, and it is not typed when you enter the command in the shell.

For Windows you will often see only:
`Robocopy C:\UserFolder C:\FolderBackup`

Many \*nix programs will have instructions that are very technical, but can be displayed by typing the word `man` before the command. For example:
`$ man ls`

On Windows, the convention for displaying the help information about a program is to include a help argument or to type `/?`. For example:
`dir /?`

In this guide, we will display all commands from now on with the `$` character at the start of the line so that you know that this is a command that was run in the Shell and not just a line of code. You don't include the `$` character or the space after it when you enter the text in the shell.

<!-- Why don't we just use the programming language like C or Python itself?  Because it is better to  -->

<!-- TODO: history of TCL/Expect, story about why it saved my butt in a class with the automated uploading and compiling step
 -->

## Hello World with TCL or Your First Program in TCL

Back to the using the Shell for this tutorial, we've installed the following scripting languages that will help with testing our code. The language are called TCL (pronounced tickle) and Expect. These are very powerful languages that allow you to script any input to a shell and work with responses.

TCL/Expect can be used in conjunction with command-line programs whether they are written in C, MatLab, Python, or any other program already available to you in the Shell.

We will output "Hello from TCL!" and use TCL/Expect to verify this from the terminal. 

1. Open up a Shell.
1. Go to your home directory:
   ```
   $ cd ~
   $ ls
   ```
1. If your directory is empty create a `Documents` folder:
   ```
   $ mkdir Documents
   ```
1. Run the commands:
   ```
   $ cd Documents
   $ mkdir Code
   $ cd Code
   $ touch hello-world.tcl
   ```

   You have just changed directories to your `Documents` folder, created a folder named `Code`, changed directories to the new folder, and used the `touch` command to create an empty file named `hello-world.tcl` in the new folder `Code` in your `Documents` directory. 
  1. On Windows, you can open the current directory in Explorer using the command:
     ```
     $ explorer .
     ```
  1. On Mac, you can open the current directory in Finder using the command:
     ```
     $ open .
     ```
1. Open the file `hello-world.tcl` in a plain text editor (Notepad, Sublime, Nano, etc.) and copy-paste the following. Again, it is very important to keep the white space exactly as is shown in the code:
   ```
esyscmd({{sed -n 24,33p ../src/T1/step-2-command-line-101/hello-world.tcl | sed 's/^/   /g' | ghead -c -1}})
   ```
1. To run this program open up a shell and change directories to the saved file. To do this you should type:
   ```
   $ cd ~/Documents/Code
   $ ls
   ```
   And see the file `hello-world.tcl`.

1. Next, run:
   `$ expect hello-world.tcl`

You should see the following displayed on your command line screen:
```
$ esyscmd({{expect ../src/T1/step-2-command-line-101/hello-world.tcl | sed -n 1,3p | ghead -c -1}})
```

## Troubleshooting Errors

What is going on with this program? Why did it output that there was an error?

Let's walk through the program line by line.  The first line of the program contains what is called a shebang (Sha-Bang). This will tell the Shell and you as the programmer which program it needs to use to execute this script file. 

Next, with the `spawn` command we tell it to start the `echo` program with the argument `"Hello World from TCL/Expect!"`

At this point, Expect will be monitoring the output of the `echo` program because of the `expect` command. In the following lines, we tell it how to handle the output. First, if we see the exact text `"Hello world."` then print to the screen using the `puts` command and exit the program with the value 0. 

If it doesn't see the text after a default amount of time, then print that we have an error and exit the program with a value of 1.

What can we do to modify the program to have the following output without changing the code on the line with `"Error!"` to `"Success!"` (change what Expect is expecting)?

```
$ esyscmd({{expect ../src/T1/step-2-command-line-101/hello-world-fixed.tcl | ghead -c -1}})
```

## Summary

Congrats on modifying your first program and fixing a bug! With the TCL/Expect testing tool, you will be able to develop automated tests for your programs and will jump ahead of many coders who don't write tests for their programs.

## References

1. Online Command line reference - https://ss64.com
1. Windows Command Prompt tutorial - https://www.digitalcitizen.life/command-prompt-how-use-basic-commands
1. \*nix Systems Shell tutorial - https://www.tutorialspoint.com/unix/unix-what-is-shell.htm 
1. Additional Windows Shell CMDs - https://ss64.com/nt/ 
1. TCL/Expect main wiki - http://wiki.tcl.tk/ 
1. Expect tutorials - https://wiki.tcl.tk/11584 
1. Answer - <{{}}__project_repo_source_root__{{}}/T1/step-2-command-line-101>

# Updates
* Jan 1, 2021 - Generated from m4 template
* Nov 11, 2020 - Added good command line reference to ss64.

[[Previous Page|T1-01]] | [[Next Page|T1-04]]