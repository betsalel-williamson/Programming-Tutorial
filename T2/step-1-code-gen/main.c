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

#include "lib.h"

int main ( int argc, char* const argv[] ) {
   int	exit_code = EXIT_CODE_NOT_SET;
   char *user_input_attempt_s = STRING_NOT_SET;
   char *user_input_override_s = STRING_NOT_SET;

   processInputArguments(argc, argv, &user_input_attempt_s,
                         &user_input_override_s);

   if(user_input_attempt_s == STRING_NOT_SET) {
      LOG_ERROR("%s", "You must pass in a code. (e.g.'./main -c 1234') .");
      abort();
   }

   LOG_DEBUG("Found code %s", user_input_attempt_s);
   LOG_DEBUG("We will set our magic sting!");
   int secret_code = INT_NOT_SET;

   if(user_input_override_s == STRING_NOT_SET) {
      secret_code = generateSecretCode("1214 Benedum");
   } else {
      printf("Used Override!!\n");
      secret_code = atoi(user_input_override_s);
   }

   int input = atoi(user_input_attempt_s);

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

   exit (exit_code);
}

