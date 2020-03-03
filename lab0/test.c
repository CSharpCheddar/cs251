#include "stdio.h"
int main(void) {
   // variable declaration
   unsigned short int num;

   // display a prompt
   printf("Enter a valid unsigned short: ");

   // read an unsigned short int into the variable num
   scanf("%hu", &num);

   // print the value of "num"
   printf("You entered %d\n", num);

   // exit the program with normal termination (i.e., no error) code
   return 0;
}
