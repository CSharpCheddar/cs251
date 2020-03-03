/***********************************************************************
 * Lab 3
 * Author:      Martin Mueller
 * Description: Converts a decimal number into the equivalent number in bases 2-9
 * Known bugs:  
 ***********************************************************************/

#include <stdio.h>

int main(void) {
  short unsigned int num;  // user input
  int digits[16];          // digits of the converted number
  
  /* declare ALL of your variables below (integers only) */

  unsigned int carryNum;        // keeps track of when to stop successive division
  short unsigned int numDigits; // keeps track of the number of digits in the converted base
  short unsigned int maxDigit;  // keeps track of the largest digit in the converted number

  /* declare ALL of your variables (but write NO code) above this point */
  
  // display an input prompt in the terminal window
  printf("Enter an integer between 0 and 65535: ");

  // wait for the user to input an integer and press return
  scanf(" %hu", &num);

  /* Write your code below this comment block. 
     The only parts you are allowed to modify above are:
     + the top comment block and
     + the variable declarations section.
     For full credit, your code below MUST meet ALL of the requirements listed
     in the lab handout.
   */

  // print the column headers
  printf("base converted number # of digits max digit\n");
  // print out each row from base 2 to base 9
  for (int i = 2; i <= 9; i++) {
    // print the base
    printf("%4d", i);
    // convert the number into base i and...
    // ...collect information about the converted number
    carryNum = num;
    numDigits = 0;
    maxDigit = 0;
    for (int j = 0; j < 16; j++) {
      digits[j] = carryNum % i;
      carryNum /= i;
      numDigits++;
      if (maxDigit < digits[j]) {
        maxDigit = digits[j];
      }
      if (carryNum == 0) {
        break;
      }
    }
    // print the converted number with correct spacing
    for (int j = numDigits; j < 17; j++) {
      printf(" ");
    }
    for (int j = numDigits - 1; j >= 0; j--) {
      printf("%d", digits[j]);
    }
    // print the number of digits
    printf("%12d", numDigits);
    // print the largest digits, end with a newline
    printf("%10d\n", maxDigit);
  }

  /* your code goes above this line; do NOT modify the code below */

  return 0;
}// main 
