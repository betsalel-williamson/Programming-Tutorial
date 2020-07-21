/*
** The author disclaims copyright to this source code.  In place of
** a legal notice, here is a blessing:
**
**    May you do good and not evil.
**    May you find forgiveness for yourself and forgive others.
**    May you share freely, never taking more than you give.
*/

/*
 * Welcome to your first program in C. This program will output "Hello World" to
 * the shell when run.
 *
 * In this program you will see code, and comments about the code.
 *
 * Multi-line comments are text written between a leading `/*` and ending with
 * the reverse.
 *
 * Single line comments are written after double forward slashes `//`
 */
int main ( ) {

  // Programming language of C requires a function named `main` that returns
  // an integer value. The reason for needing `main` is because the compiler
  // that converts this program needs to know where to start.
  //
  // The reason for returning an integer or `int` is for you to report back to
  // the person running the program how things went. It is the adopted
  // practice to use the value 0 when all has gone well and to use other
  // values to indicate that something went wrong.
  //
  // We will leave the ( ) blank for now and will come back to this later. C
  // does not care about the white space or number of spaces between different
  // lines of code.
  //
  // We could have written it like () or (                 ).
  //
  // Finally, the code that we want this function to have is between the curly
  // braces { } . The code between these two braces is also called a block of
  // code.

  write( 1, "Hello World", 12 );

  // The second function in this program will print the words Hello World to
  // the shell. This function is called an implicitly declared function
  // because we did not write where it comes from.
  // There are a selection of implicit functions that C knows about. We will
  // therefore ignore the warning with the `-w` option when we compile.
  //
  // This function takes 3 arguments:
  // `1` - indicates that we would like to write to Standard Out or the main
  //		 shell (in contrast with standard error, used when we output errors
  // 		 to the shell)
  // `"Hello World"` - is the information that we want to print to the shell
  // `12` - is the size of the information in bytes we want to print, or in
  //		 other words the number of letters between the quotes

  // In C, all lines of code must end with the `;` character. One of the
  // biggest issues that people run into during their first program is not
  // paying attention to this detail and turning away in frustration.

  // Finally, the `return` keyword will tell the function that are finished
  // and would like to indicate our program ran successfully by returning the
  // value of 0.
  return 0;
}
