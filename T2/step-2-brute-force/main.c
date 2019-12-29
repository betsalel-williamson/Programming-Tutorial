/* Trivial way to crack the code */

/*
** The author disclaims copyright to this source code.  In place of
** a legal notice, here is a blessing:
**
**    May you do good and not evil.
**    May you find forgiveness for yourself and forgive others.
**    May you share freely, never taking more than you give.
*/

#include <stdlib.h>
#include <stdio.h>

int main ( ) {
   
   char str[80];
   char* debug_location = "./../step-1-code-gen/debug/";
   char* location = "./../step-1-code-gen/release/";
   char* exe_name = "secretPassword";
   char* args = "-c";

   int i = 1;
   do {
      sprintf(str, "%s%s %s %d", location, exe_name, args, i);
      int exit_code = system(str);

      if (exit_code == 0) {
         printf("The code is %d\n", i);

         sprintf(str, "%s%s %s %d", debug_location, exe_name, args, i);
         int exit_code = system(str);
         
         break;
      }

      i++;
   } while(i < 1000);

   exit(EXIT_SUCCESS);
}
