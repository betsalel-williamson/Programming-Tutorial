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

int generateSecretCode(char * secret_key) {
   LOG_DEBUG("Secret Key %s", secret_key);
   int secret_code = 0;
   // for more info on this time functionality look atUpdated
   // https://www.tutorialspoint.com/c_standard_library/time_h.htm
   time_t my_time;
   time (&my_time);
   struct tm * time_info = localtime (&my_time);
   LOG_DEBUG("year->%d", time_info->tm_year + 1900);
   LOG_DEBUG("month->%d", time_info->tm_mon + 1);
   LOG_DEBUG("date->%d", time_info->tm_mday);
   LOG_DEBUG("hour->%d", time_info->tm_hour);
   LOG_DEBUG("minutes->%d", time_info->tm_min);
   LOG_DEBUG("seconds->%d", time_info->tm_sec);
   int second_info = (time_info->tm_sec / 20);
   LOG_DEBUG("seconds divide: %d", second_info);
   // this will demonstrate bit-wise operations
   secret_code ^= time_info->tm_min << ('b' & 0b11);
   secret_code ^= 1214 << ('h' & 0b11) ;
   secret_code >>= ('w' & 0b11);
   secret_code ^= second_info << ('7' & 0b11);
   
   unsigned long i;
   for (i = 0; i < strlen(secret_key); i++)
   {
      secret_code = secret_key[i] ^ secret_code;
   }

   secret_code &= 0b11111111;

   LOG_DEBUG("secret_code %d", secret_code);
   return secret_code;
}

void processInputArguments(int argc, char* const argv[],
                           char **user_input_attempt_s, char ** user_input_override_s) {
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

   /* Print any remaining command line arguments (not options). */
   if (optind < argc)
   {
      LOG_DEBUG ("non-option ARGV-elements: ");

      while (optind < argc)
         LOG_DEBUG ("%s ", argv[optind++]);

      LOG_DEBUG ("\n");
   }

   return;
}