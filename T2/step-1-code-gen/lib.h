/*
 * Copyright (c) 2018 Betsalel "Saul" Williamson
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
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
#define STRING_NOT_SET 			NULL
#define INT_NOT_SET 			-1
#define CORRECT_CODE 			EXIT_SUCCESS
#define INCORRECT_CODE 			EXIT_FAILURE
#define INVALID_USER_INPUT 		2
#define EXIT_CODE_NOT_SET 		-1
#define ATOI_NO_NUMBER_CODE 	0

// in a header file we declare functions in the corresponding .c file
int generateSecretCode(char * secret_key);
void processInputArguments(int argc, char* const argv[],
                           char **user_input_attempt_s, char ** user_input_override_s);