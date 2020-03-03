/*********************************************************************
 * Lab 4
 * Description: Main (or driver) program for Lab 4
 * Author:      David Furcy
 *********************************************************************/

#include <stdio.h>
#include "lab4.h"
 
int main(void) {
  char input[MAX_LENGTH + 1];  // string entered by the user
  char fractional[MAX_LENGTH]; // fractional part of number entered by user
  int inputLength;             // number of characters entered by the user  

  printf("Enter a binary floating-point number: ");
  inputLength = getInputString(input);

  if (inputLength == 0) {
     printf("No number to convert\n");
     return 0;
  }

  getFractionalPart(input, fractional);
  printf("%s = %g\n", fractional, convertToDecimal(fractional));

  return 0;
}// main 
