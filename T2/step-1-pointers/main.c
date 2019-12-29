/* Simple program to demonstrate pointers and arrays */

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

void myPointerFunction(int * pointer, int value) {
   *pointer = value;
}

void myPointerToPointerFunction(char ** pointer_to_pointer, char* c_string) {
   *pointer_to_pointer = c_string;
}

int main ( ) {

   char *c_string = "foo"; // declare my c_string, or my pointer to point to the text "foo"
   printf("%-35s%c\n", "First letter of c_string:", c_string[0]); // will print the letter 'f'
   char c_string_with_array[4]; // note we need a length of one more than the word we enter
   c_string_with_array[0] = 'f'; // we use index counting numbers that start from 0 and go until length minus 1
   c_string_with_array[1] = 'o';
   c_string_with_array[2] = 'o';
   c_string_with_array[3] = '\0';
   printf("%-35s%c\n", "First letter, string as array:", c_string_with_array[0]); // will print the letter 'f'
   printf("%-35s%c\n", "First letter, pointer access:", *c_string_with_array); // will print the letter 'f'
   

   // with the cubby example 
   // each variable will be assigned a cubby spot
   int x = 1234;
   printf("%-35s%d\n","Information in cubby:", x); // Look up the different print codes online for
   // more detail. In short we tell `printf` how we want to display
   // the variable `x`

   // We store the information `x` in a cubby.
   // If we want to find out where that `x` was stored and get the
   // cubby number we will dereference `x` with the `&` operator
   printf("%-35s%x\n","Address of information:", &x); // %x will print the cubby number or memory
   // address using hex values.

   long cubby_number_of_x_as_long = (long) &x;
   printf("%-35s%x\n",  "Cubby number in long variable:", cubby_number_of_x_as_long); 
   // %x will print the cubby number or memory

   int* pointer = (int*) cubby_number_of_x_as_long; // we now declare a pointer
   // This variable will hold the cubby number of `x`.
   printf("%-35s%d\n",  "Cubby number as a pointer:",*pointer); 
   printf("%-35s%x\n",  "Cubby number of pointer:", &pointer); 
   printf("%-35s%x\n",  "Cubby number of x:", pointer); 
   // to see the information stored in the cubby
   // we use the pointer operator `*` to access that information
   // You must only use the `*` operator with a pointer or array

// We can't use a `*x` because the `x` variable is not a pointer.
// If we want to use `*`, we must declare a pointer.
// error: invalid type argument of unary '*' (have 'int')
    // printf("%u\n", *x);

   int array[2];
   *array = x; // same as array[0] = x;
   *(array+1) = 4321; // same as array[1] = 4321;

   printf("%-35s%d\n",  "Array index 0 with pointer access:",*array); 
   // to see the information stored in the cubby
   printf("%-35s%d\n",  "Array index 0 with array access:",array[0]); 
   // to see the information stored in the cubby
   printf("%-35s%x\n",  "Address of index 0 (as hex):", array); 
   printf("%-35s%ld\n",  "Address of index 0 (as long):", &(array[0])); 

   printf("%-35s%d\n",  "Array index 1 with pointer access:",*(array+1)); 
   // to see the information stored in the cubby
   printf("%-35s%d\n",  "Array index 1 with array access:",array[1]); 
   // to see the information stored in the cubby
   printf("%-35s%x\n",  "Address of index 1 (as hex):", (array+1)); 
   printf("%-35s%ld\n",  "Address of index 1 (as long):", &(array[1])); 

   printf("%-35s%d\n",  "Array index 2 with pointer access:",*(array+2)); 
   // You will be able to access this information
   // but is not guarenteed to be filled with anything, it may be zero
   // it may be some other information that was in memory
   printf("%-35s%d\n",  "Array index 2 with array access:",array[2]); 
   // to see the information stored in the cubby

   printf("%-35s%d\n",  "Array index 80 with pointer access:",*(array+80)); 
   // You will be able to access this information
   // but is not guarenteed to be filled with anything, it may be zero
   // it may be some other information that was in memory
   printf("%-35s%d\n",  "Array index 80 with array access:",array[80]); 
   // to see the information stored in the cubby

   // note that C will allow you to access and overwrite 
   // locations that you may not understand
   // this technique is used by hackers to exploit buffer overruns

   // the following line make crash the program or currupt another program
   myPointerFunction((array+2), 1217);
   printf("%-35s%d\n",  "After changeing index 2:",*(array+2)); 

   myPointerFunction(&(array[80]), 1214);
   printf("%-35s%d\n",  "After changeing index 80:",*(array+80)); 

   myPointerToPointerFunction(&c_string, "Benedum");
   printf("%-35s%s\n", "New c_string:", c_string); 
   
   // what happens if we try to change the c_string_with_array?
   // because arrays are allocated at compile time there is no way to get past the initial length
   myPointerToPointerFunction((char**)&c_string_with_array, "SERC");
   printf("%-35s%s\n", "New c_string_with_array:", c_string_with_array); 

   return EXIT_SUCCESS;
}
