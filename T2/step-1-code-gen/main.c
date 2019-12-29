/*
** The author disclaims copyright to this source code.  In place of
** a legal notice, here is a blessing:
**
**    May you do good and not evil.
**    May you find forgiveness for yourself and forgive others.
**    May you share freely, never taking more than you give.
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

