__project_under_construction_flag__
# Walkthrough of `secretProgram`

We will work through every line of the `secretProgram` and will instruct you how it all works. You should have already completed the first tutorial and downloaded the code. Open up the following two directories at the same time in your text editor program, Windows Explorer, or Finder:
1. Location of this program `T2\step-1-code-gen`
1. Location of C system library.
	1. In Cygwin 64 Bit this is `C:\cygwin64\usr\include`
	1. On *nix this is `usr/include`

## Intro to Arrays, Strings and Pointers

On to the programming. We will first need to cover some quirks of the C language and talk about arrays, strings, and pointers.

In C, when you write a line of text to be printed you can have either characters or a group of characters that as a group are called C strings. What is important about these C strings is that they always made up of ASCII characters which are binary representations of all the letters, numbers, symbols, and other important commands that you will use when coding. 

_The ASCII Code is a specific character set (also included in the common character set known as UTF-8 <https://en.wikipedia.org/wiki/UTF-8>). Today, most computers and programs know how to interpret many different character sets which is why you can have emojis! For more detail, see Wikipedia for the codes <https://en.wikipedia.org/wiki/ASCII>._

Back to C strings, they will always end in a 0-bit encoding. This is known as the terminating zero or `\0`. So how does this relate to an array or pointer?

We need to back up a little bit and talk about how computers store things. We can say disk, hard drive, RAM, ROM, or memory, but when you get down to it, the processor accesses a location called a register to perform a code step. Each register has a unique location or memory address. Many common computer systems store both data and programming instructions in these registers.

### Registers Analogy to Gym Lockers 

A good way to think about registers and addresses to use the analogy of a gym with lockers: 
1. Each locker can store a fixed amount of stuff. 
1. All of the lockers are the same size. 
1. All lockers have a number so that you can assign them to everyone. 
1. Some people will have more stuff and need more lockers.

Back to C strings, each character will 'fill a locker spot' and each spot filled has a unique address. When we deal with creating strings, C will guarantee that all of the letters take sequential spots in the locker or register, and the last spot will be filled with the `\0` character.

Fortunately for us, this is exactly how pointers and arrays work. 

A pointer is the locker number.

An array is a guarantee from C that we will get as many locker spots as we ask for (as long as there is enough space in the computer).

The first spot in the array is the same exact thing as a pointer. The first spot in the C string is the same exact thing as pointer.

This is why we can do the following:
```
char *c_string = "foo"; // declare my c_string, or my pointer to point to the text "foo"
printf("%c",c_string[0]); // will print the letter 'f'
char c[4] c_string_with_array; // note we need a length of one more than the word we enter
c[0] = 'f'; // we use index counting numbers that start from 0 and go until length minus 1
c[1] = 'o';
c[2] = 'o';
c[3] = '\0';
printf("%c",c_string_with_array[0]); // will print the letter 'f'
```
We will come back to this later in the functions section. There is a sample program for you to run in `T2/step-1-pointers` that will output different examples of locker numbers and the stuff stored in the lockers.

## Headers

Open `main.c`. You will see following the license header that we have the line:

```
#include "lib.h"
```

This is what as known as a header file. When we have the text following `#include` in `""`'s we know we are trying to access a file that is in the same project directory.

Locate the file `lib.h` and open it up.

We will see that it points to additional files! These files contain code that we will use throughout the `main.c` program to 'black-box' parts of the program which both helps us reduce the amount of text we need to read in each file and helps organize things. There is a best practice to keep files with code that humans need to read to a couple hundred lines of code each. Beyond that you will start annoying the humans who will at some point look at your code.

Again, after the license we have the following lines:
```
// basic C functions including write, and printf
#include <stdio.h>
// includes the exit function along with others
#include <stdlib.h>
// some basic operations working with ASCII text
#include <ctype.h>
// for processInputArguments
#include <getopt.h>
// for use with getting the time
#include <time.h>
// use a logger instead of printf everywhere to
// save you from printing everything in release mode
#include "macrologger.h"
```

The lines with the `<>` means that we are trying to access system library files. Notice that we have a bunch of these. We will reference them throughout the rest of the tutorial so you should now practice trying to open them up and look at them.  If you forgot where that is, go to the top of this tutorial to find the location for the system files.

__DO NOT EDIT THE SYSTEM FILES! If you change them you may end up breaking other programs that require them.__

Notice the last included file is a header file named `macrologger.h`. This is a third-party library that is used to help set the logging levels for information that are printed during the program. This is needed so that there can be two versions of the program. One that outputs a lot of information for testing of the program. The other is a `release` version that will run without a lot of output so that the program runs more quickly and also doesn't bother the person using the program with needless information. The makefile is used to compile a debug version where the `LOG_LEVEL` is implicitly set, or set using the code in `macrologger.h` to the default `DEBUG_LEVEL`. In the release version it is explicitly set to not log output using the compile flag `-D LOG_LEVEL=0`.

## C Macros

```
// note the style of UPPER_CASE_SNAKE_CASE, or SCREAMING_SNAKE
// this is to indicate that this is a macro,
// note that sometimes lower_case_snake is also used
// this is a style convention
#define STRING_NOT_SET 			NULL
#define INT_NOT_SET 			-1
#define CORRECT_CODE 			EXIT_SUCCESS
#define INCORRECT_CODE 			EXIT_FAILURE
#define INVALID_USER_INPUT 		2
#define EXIT_CODE_NOT_SET 		-1
#define ATOI_NO_NUMBER_CODE 	0
```

These are our C Macros. In C, macros are a type of variable in C that will be set when you compile your code. They start with `#define`. The way they work is that the compiler or the program that converts you code into machine readable 0's and 1's will replace very instance of `STRING_NOT_SET` to `NULL`, `INT_NOT_SET` to `-1`, and so on. This is done before the code is converted from C into machine code.

We do this because humans can understand words and are less likely to remember cryptic messages after 5 years. As a best practice, if you are writing code for a project, assume that you will need to come back to it when you no longer remember what it does.

```
// in a header file we declare functions in the corresponding .c file
int generateSecretCode(char * secret_key);
void processInputArguments(int argc, char* const argv[],
                           char **user_input_attempt_s, char ** user_input_override_s);
```

Lastly we have function declarations. This is so that our `main.c` file will know when it uses these functions what information these functions expect. Note that we will usually have the declarations of functions in our `.h` file and the actual code for the functions in a `.c` file with the same name. You can open up `lib.c` and see that we have the details in there. We will get into those details later in this tutorial. 

## Variables including global and local variables

We now go back to the `main.c` file. We are going past the `int main ( int argc, char* const argv[] )` header which was covered in tutorial 1 and start with the variables or the information that we will need in our program. 

This is:
1. A way to notify the user of the program whether they got the right code
1. A place to hold the code that the user enters into the program
1. A place to hold the optional override code that is used during testing

_My style of coding is very verbose and the reason for this is that after a while, I got used to chunking the information. If you are new to this, you will take more time reading the information, but given time you too will start chunking the information just like you no longer look at the words `every time` and read `ev-er-y ti-me`. Your brain will do this automatically if you focus on the mental images or think about what the code is doing when you see the text. Let the words themselves fade into the background._

```
   int	exit_code = EXIT_CODE_NOT_SET;
   char *user_input_attempt_s = STRING_NOT_SET;
   char *user_input_override_s = STRING_NOT_SET;
```

The way to read this is: "An integer 'exit code' is assigned the value 'exit code not set'. The string 'user input attempt' is assigned the value 'string not set'. The string 'user input override' is assigned the value 'string not set'."

Always pronounce `=` as "assigned the value of" or "the variable is set to". It will help avoid the homophone confusion of equals which is reserved to mean when two values are the same.
 
The integer value is set with text and not a number? How is that accomplished? Where and what is `EXIT_CODE_NOT_SET`?

The answer to that is you will need to search the project file for where `EXIT_CODE_NOT_SET` is first used. Because the standard C convention for the font is used the SCREAMING_SNAKE_CASE text is understood to be a C Macro and will be a stand in value that is declared at the top of a file somewhere.

_Guide to programming case types - <https://www.chaseadams.io/most-common-programming-case-types/>_

The first place to always look is in files located in the project directory which in this case was `T2\step-1-code-gen`. The second place to look is in the header files that we included throughout our project. Fortunately, the computer is a lot quicker at searching for text than we are.

Open up your terminal to the project directory and type:
```
$ grep -r "EXIT_CODE_NOT_SET" .
```

What this does is use the `grep` program with the parameter `-r` which means search the directory recursively, the text between the quotes will be exact text, and lastly we pass in a location or `.` which is the current directory. We can search a specific file if we changed the `.` to the filename in the current directory or we can also pass in the absolute path or the path including the directory information from the base directory `/` until the file.

You should see:
```
./Programming-Tutorial/T2/step-1-code-gen/lib.h:#define EXIT_CODE_NOT_SET -1
./Programming-Tutorial/T2/step-1-code-gen/main.c:   int    exit_code = EXIT_CODE_NOT_SET;
```

This shows that we have a C macro or `#define` to set the text `EXIT_CODE_NOT_SET` to `-1`.

The next two variables are C strings or pointers that will hold our user input.

We will gloss over the functions and come back to them later on, but the next line is:
```
   processInputArguments(argc, argv, &user_input_attempt_s,
                         &user_input_override_s);
```

As a black box, we are sending in our `argc`, which you should remember is the number of arguments supplied to the program, `argv`, the array of strings that are our input arguments. The next two parameters or variables that we want to pass to this are our pointers, but we have a special symbol in front of them, the ampersand `&`. Keep note of this and we'll come back to it when we talk about functions.

We always need to consider how long we want our variables to exist and when we want to access them. If we declare simple variables in functions they will be destroyed after the function exits. The exception to this is if we tell C to grab a bunch of memory for a variable using special functions called `malloc` or `calloc` which allocate memory. In that situation we will need to keep track of the pointer even after the function exits or we will have created a memory leak. That means that we have information allocated by the program, but there is no longer any way to access the information or to tell C that we no longer want it. There is a lot more in this topic of memory management that will not be covered here. Please see the Internet or take a course that covers memory management for more details.

The last bit of information is about global variables. __DON'T USE THEM.__ It is important to know that there are system programs that will make use of them, but the current best practice in coding is to never worry about the state of variables that are outside of your function. If you need to change something make sure that you are passing the information into your current block of code. Keeping track of global variables is a sure way to forget about an obscure variable that you have to hunt down.

Global variables are the primary reason why we have Murphy's Law of Programming Variables _"constants aren't and variables won't"_.

## Branch including If Else / Switch

We not come the point in our program where we want to create some sort of logic so we can tell our computers what to do. Fortunately for us, computers will do exactly what we instruct it to do. Nothing more, nothing less. When ever there is an 'unexplained' behavior in our programs there is a reason. Often it is our lack of understanding of how the system works overall or what we inadvertently told the computer to do.

```
   if(user_input_attempt_s == STRING_NOT_SET) {
      LOG_ERROR("%s", "You must pass in a code. (e.g.'./main -c 1234') .");
      abort();
   }
```

The way to read this line is: "If the user input attempt is equal to 'string not set', then I log an error and then abort."

We have a block of code. This is indicated by the curly braces `{}`. All of the text in between these braces will be executed if we satisfy our condition. In C, we will have these conditions with (1) the `switch case` statement or (2) the `if`, `else if` and `else`. We will show an example of the case when we look into functions. For now, know that if you are using the `if`, it must always start with an `if`. The other two are optional. The `else if` must always come after the `if`'s curly braces and you may have as many of these as you want. Finally, the `else`, if included will always come last and does not have any condition attached.

The `if` and `else if` have conditions that must be true for the block of code to execute. In C, true means any value that is not `0`, or `NULL` will allow the block to execute.

```
   LOG_DEBUG("Found code %s", user_input_attempt_s);
   LOG_DEBUG("We will set our magic sting!");
   int secret_code = INT_NOT_SET;
```

At this point you should be reading the lines of code and expecting what the English says. We log some debug messages and then create a variable and initialize it to the value of `INT_NOT_SET`. Try to find where this macro was declared and what value it is.

```
   if(user_input_override_s == STRING_NOT_SET) {
      secret_code = generateSecretCode("1214 Benedum");
   } else {
      printf("Used Override!!\n");
      secret_code = atoi(user_input_override_s);
   }
```
Can you find the `atoi` function in our code or the system libraries (hint: use `grep`)?

After using grep with the `-r` argument we see a lot of documents! Lets simplify that by searching the files we know are included in our project by the `lib.h` file.
```
$ grep 'atoi' stdio.h stdlib.h ctype.h
stdlib.h:int    atoi (const char *__nptr);
stdlib.h:int    _atoi_r (struct _reent *, const char *__nptr);
```

This isn't much information about this function, so we turn to the Internet. Google: `standard lib c atoi`. This should return good information about this. Manly we want to know what happens when there is an error. The program is expected to return 0 when there is an error. This will affect our program because we will want to make sure that our secret code is never 0.

Here we use the `atoi` function that takes in a C string and outputs a number. 

```
   int input = atoi(user_input_attempt_s);
```

The last block will handle the checking of the input to see that it matched the secret code. 

```
   if(input == 0) {
      LOG_ERROR("Invalid input: %s", user_input_attempt_s);
      exit_code = INVALID_USER_INPUT;

   } else if (input == secret_code) {
      exit_code = EXIT_SUCCESS;
      printf("Congrats! You entered in the right code!\n");

   } else {
      LOG_ERROR("Your attempt %d was incorrect. Try again.\n", input);
      exit_code = INCORRECT_CODE;
   }
```

The English of this is: "If the input is 0 then log an error and assign the exit code to invalid user input. Otherwise, if the input is equal to the secret code then set the exit code to success and print the message. Otherwise, log an error and set the exit code to 'incorrect code'."

Finally we finish our program with:
```
exit (exit_code);
```

The `exit` function is a special function that will make sure that we gracefully exit our program with the value passed into the function.

## Function declaration, function call, parameters passing

We now get into the second layer of our program and look into the functions `processInputArguments` and `generateSecretCode`.

You may also look at the example in the pointer's program `T2/step-1-pointers` for passing pointers.

## `generateSecretCode`

We start with the more simple function `generateSecretCode`. From the `lib.h`

```
int generateSecretCode(char * secret_key)
```

The function header tells us that we are going to be returning an integer value and require a string as input.

```
   LOG_DEBUG("Secret Key %s", secret_key);
```

Next, we log a debug message about what the secret key was.

```
   int secret_code = 0;
```

### Structures including declaration and deference

This is the secret code that we will generate using some 'secret' math.

```
   // for more info on this time functionality look at
   // https://www.tutorialspoint.com/c_standard_library/time_h.htm
   time_t my_time;
```

Starting with some English: "We create a type `time_t` variable named `my_time`."

In this section, we are interested in getting time information. We get that by declaring the variable of type `time_t`. Where is this? It is in the `time.h` header file.

_Can you find this using grep? It is buried in the sytem files._
```
time.h:				#include <sys/_timeval.h>
sys/_timeval.h:		typedef  _TIME_T_        time_t;
sys/_types.h:		#define    _TIME_T_ long
```

So from our `time.h` file it goes two layers deep for us to find what this actually is...

This is a special way of saying that we have a `long` type variable to hold the time information.  We would like a cleaner way to access the time information from a `long` type so we convert it to a C `struct`. 

```
   time (&my_time);
   struct tm * time_info = localtime (&my_time);
```

The English: "We pass a pointer to the `my_time` variable to the function `time`. We then create a `struct tm` pointer with the value returned from the function `localtime` with the pointer of `my_time` passed into it."

The following is taken from the `time.h` file:

```
struct tm
{
  int	tm_sec;
  int	tm_min;
  int	tm_hour;
  int	tm_mday;
  int	tm_mon;
  int	tm_year;
  int	tm_wday;
  int	tm_yday;
  int	tm_isdst;
#ifdef __TM_GMTOFF
  long	__TM_GMTOFF;
#endif
#ifdef __TM_ZONE
  const char *__TM_ZONE;
#endif
};
```

This `struct` is a group of information that we would like to know when dealing with time. The author of this code decided that the `tm` name would be the best struct name.

You can see that we pass the locker location of the `my_time` variable to the `time` and `localtime` functions. This is necessary for the computer to set the information in the `tm` struct `time_info`.

Again, we reformat from time in the `long` type to this struct `tm` type using the `localtime` function:
```
struct tm * time_info = localtime (&my_time);
```

The following is an important rule with structs: You usually want to work with pointers (locker number). 

Based on the `localtime` api we are told that when this function is called it will convert from the `long` type and return to us a pointer of the `tm` type that stores the time information. With a struct pointer we will use arrows to access the information `->`.  

```
   LOG_DEBUG("year->%d", time_info->tm_year + 1900);
   LOG_DEBUG("month->%d", time_info->tm_mon + 1);
   LOG_DEBUG("date->%d", time_info->tm_mday);
   LOG_DEBUG("hour->%d", time_info->tm_hour);
   LOG_DEBUG("minutes->%d", time_info->tm_min);
   LOG_DEBUG("seconds->%d", time_info->tm_sec);
```

The English: "We use the `LOG_DEBUG` macro to log a message of the year by adding 1900 to the `tm_year` variable..."

### Bit-wise Operations

The next few steps will cover some bit-wise operations to ensure that our code is in the hundreds range. Can you think about how many bits we would want to keep to have an integer number in the hundreds range (up to 999)?

The answer is from binary arithmetic.  If we have 1 bit we can store the value 0 and 1 or two numbers, 2 bits will allow us to store 0, 1, 2, and 3 or 4 numbers, etc. In equation form, the highest decimal number 'd' for binary numbers or base 2 is `d=2^(n)-1` where `n` is the number of bits.  Using logarithms we can solve for `n=log_base2(d+1)`.  Since bits are a complete unit we round `n` up.

The design of this program is to change the code every 20 seconds and to be unique for every hour. To do this, the bit-wise operations are used on the minute and time information from the `time_info` struct. To make the code a little more obfuscated we use some `XOR` operations with 'magic' numbers in this case this is the number `1214` and using a bit shift that was masked with a psudo-random shift of at-most 2 bits.

In C, we can declare bit variable using the `0b` prefix:
```
('b' & 0b11)
```

This will mask the binary value of `'b'` with two bits using the bit-wise `AND` operation. Looking at the ASCII chart you can find that the binary value of `b` is `110 0010`. Masking it with `0b11` will result in `0b10`. 

```
secret_code ^= time_info->tm_min << ('b' & 0b11);
```

We then shift the binary value of the minutes by at least 2 positions to the left. This will increase the number. The following steps we continue to `XOR` and bit shift our secret number.

### For, While, and Do While loop

Next, the program loops through the C string passed in and `XOR` the current secret number with each character. We want to go from the first character of the string, to the last character. Note that this could be accomplished with either a `while` or `for` loop.

We will cover the `while` loop when we look at the `processInputArguments` function. Our example does not include the use of a `do while`, but see the example of how it is used in the brute force solution to finding the code. It is important to recognize that it is possible to create each one of these looping structures with the other.  We leave it to you to explore after completing this tutorial.

If at any specific time we wish to stop our loop we simply use the `break;` command.

Going over the `for` loop. There are always three steps:
1. The step to initialize your counting variable
2. The condition your variable must satisfy to run the block again
3. The step that will be run after each block is run

Usually we have step 1 to initialize the value of our variable to 0 or 1.

The next step is used to bound the number, so if we have a C string, this is the length of the text found for us with the system function `strlen`. 

Lastly, we increment the variable to keep track of where we were in counting from the beginning to the end.

In our block here, we access the character by using the array accessing method:
```
secret_code = secret_key[i] ^ secret_code;
```

The variable `i` is a long because the `strlen` function returns a long. We count from `0` or the first place of the C string or array until the length of the string minus 1. The 'length of string minus 1' is achieved by using a less than operator `<` instead of an equal to or less than operator `<=`.

Next, we mask the secret code with 10 bits to ensure that we have a number in the 1000's range.
```
secret_code &= 0b1111111111;
```

We then output a debug message with our secret code and return the value to the caller. The caller is the `main.c` line that was `secret_code = enerateSecretCode("1214 Benedum");`

## `processInputArguments`

We move on to the next function. First, we look at the header of the function:
```
void processInputArguments(int argc, char* const argv[],
                           char **user_input_attempt_s, char ** user_input_override_s)
```

### Passing Arrays, Strings and Pointers to Functions

We have the `argc` and `argv` that we've seen a couple times before, but next we have some weird looking variables with the `char **`. Remember in the beginning we talk about arrays and pointers being similar concepts? It turns out that the `char **` is semantically the same thing as the `char * argv[]`. While the `argv` has a `const` in front of it which tells our function that we will not be modifying the contents of anything that our locker number points to, we will be changing the information in the locker that are the input attempt and input override variables.

Remember the `&` symbol we used with `processInputArguments` in `main.c`? The reason we do this is because we want to pass the locker number to the function and not the information that is in the locker. If we didn't use the dereference operator `&` we would be passing in the `STRING_NOT_SET` value.

```
   static struct option long_options[] =
   {
      /* These options set a flag. */
      // each one of these lines is an option struct
      /* These options don’t set a flag.
         We distinguish them by their indices. */
      // required_argument is a macro in the getopts.h
      {"code",  required_argument, 0, 'c'},
      {"force",    required_argument, 0, 'f'}
   };
```

We want to use the `option` struct in order to take advantage of the `getopt_long` function which helps us pass in arguments to our program. We have a couple options so we will create an array of structs. See to see the details we will need to go to the `getopt.h` file:
```
struct option {
	const char *name;
	int  has_arg;
	int *flag;
	int val;
};
```

To see the details we again need to look to the Internet. Google `standard c lib getopts option` or see the information and example here <https://www.gnu.org/software/libc/manual/html_node/Getopt-Long-Options.html#Getopt-Long-Options>.

If you open up the `getopts.h` file you can notice that even the system library sometimes does not follow convention. This library uses both global variables and does not use SCREMING_SNAKE_CASE for its macros!

When the function finds an argument in this case with `-c 1234` or `--code=1234` it will store the C string result in `optarg`. We leave you to read the documentation online to learn more about how to use `getopt_long`.

We go back to the looping code with a `while` loops. This type of loop will execute an operation and check to see if the result is `true` and then execute the block of code. The block of code here will look at the result of the input arguments and store the result `optarg` in the locker. 


```
   /* getopt_long stores the option index here. */
   int option_index = 0;

   /* value to hold the short argument returned by getopt_long */
   int c;
   /* Detect the end of the options. */
   while ((c = getopt_long (argc, argv, "c:f:", long_options,
                            &option_index)) != -1)
   {
      switch (c)
      {
      case 'c':
         LOG_DEBUG ("option -c with value `%s'\n", optarg);
         *user_input_attempt_s = optarg;
         break;

      case 'f':
         LOG_DEBUG ("option -f with value `%s'\n", optarg);
         *user_input_override_s = optarg;
         break;

      case '?':
         LOG_DEBUG ("unknown with value `%s'\n", optarg);
         break;

      default:
         LOG_DEBUG ("In default with value `%c'\n", c);
      }
   }
```

To look at the options efficiently we use the `switch` logic. We could use the `if`, `if else`, `else` logic, but that would end up being more lines of code. We read this as we would like to look at the integer value `c`. Switch only works with simple types and will not work with C strings.

In the `switch` block we have the `case` followed by the value we want to execute on, followed by a colon `:`. When we want to group cases together we put multiple `case` statements. When we have finished defining our case we end it with the `break;` statement. Notice we mentioned in the loops that we would exit the loop with the `break;`? That will happen if we have the `break;` outside of the `switch` block. The way `break` works is that it will find the parent block and identify the break with the first switch or loop that it sees.

We use the `*` operator to say that we don't want to overwrite the locker number, but rather we want to overwrite what that locker number points to.

There are debugging messages throughout for us to look at the information passed in.

Lastly, we debug output if the `getopts` function didn't process some of the input to our program and tell C that we are finished.
```
   /* Print any remaining command line arguments (not options). */
   if (optind < argc)
   {
      LOG_DEBUG ("non-option ARGV-elements: ");

      while (optind < argc)
         LOG_DEBUG ("%s ", argv[optind++]);

      LOG_DEBUG ("\n");
   }

   return;
```

## Summary

Congratulations! You've made it through to understanding how the `secretProgram` works! There are more files in the directory to test and a makefile that supports a debug and release version. We will not cover this in detail. Please use the Internet to learn more about makefiles and Expect to help you along the way. The test file was used throughout the development of this tutorial to ensure that any changes made to the code along the way resulted in a complete, working program.

## References

1. Code - <{{}}__project_repo_source_root__{{}}/T2/step-1-code-gen>
1. Google style guide - <https://developers.google.com/style/>
1. Stackoverflow discussion on malloc and strings - <https://stackoverflow.com/questions/41830461/allocating-string-with-malloc/41830820>

# Updates
* Jan 1, 2021 - Generated from m4 template

[[Previous Page|T2-00]] | [[Next Page|T2-02]]