/*
** The author disclaims copyright to this source code.  In place of
** a legal notice, here is a blessing:
**
**    May you do good and not evil.
**    May you find forgiveness for yourself and forgive others.
**    May you share freely, never taking more than you give.
*/

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

// note the style of UPPER_CASE_SNAKE_CASE, or SCREAMING_SNAKE
// this is to indicate that this is a macro,
// note that sometimes lower_case_snake is also used
// this is a style convention
#define STRING_NOT_SET         NULL
#define INT_NOT_SET           -1
#define CORRECT_CODE           EXIT_SUCCESS
#define INCORRECT_CODE         EXIT_FAILURE
#define INVALID_USER_INPUT     2
#define EXIT_CODE_NOT_SET     -1
#define ATOI_NO_NUMBER_CODE    0

// in a header file we declare functions in the corresponding .c file
int generateSecretCode( char * secret_key );
void processInputArguments( int argc, char* const argv[],
  char **user_input_attempt_s, char ** user_input_override_s );
