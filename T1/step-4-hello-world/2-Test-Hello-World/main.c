/*
 * Welcome to your second program in C. 
 * 
 * In this program you will modify the code from your first program 
 * to accept a parameter or argument as input from the Shell.
 * 
 */

int main ( int argc, const char* argv[] ) { 

	// argc is the number of arguments passed into the program
	// argv is the array (think a list) of arguments
	// We access the items in the array by putting a number between
	// the square brackets. In C, we call this number an index. 
	// This is very important because indexes will always start 
	// with 0. You can think of this in terms of number types. 
	// In math, the natural numbers start with 1 and increase. 
	// Indexes start at 0 and will increase until the number of 
	// items in the array minus 1.
	
	int exit_value = -1;
	// we set this exit value to be -1 so we can know if the
	// program exits unexpectedly before being able to set
	// the value 0, or 1 as will be shown later on.

	// ensure the correct number of parameters are used.
	if ( argc == 2 ) {
		int i = 0; // declare a variable to count the length
		// of the text passed in as an argument

		// In C, all properly formmated strings end with 
		// the character '\0'. To get the length of the text, 
		// or string, we start at the first index value 0.
		while(argv[1][i] != '\0'){
			i = i+1;
		}

		write(1, argv[1], i); 

		// What do you think the zeroth item or element
		// in argv is?

		// i = 0; // reset i to be 0

		// while(argv[0][i] != '\0') {
		// 	i = i+1;
		// }

		// write(1, argv[0], i); 

		exit_value = 0;
	} else {
		// if the incorrect number of parameters are used
		// then report that there was an error
		exit_value = 1;
	}

	return exit_value; 
}
