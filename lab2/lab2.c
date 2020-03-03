/***********************************************************************
 * Lab 2
 * Author:      Martin Alexander Mueller
 * Description: 
 * Known bugs:  
 ***********************************************************************/

#include <stdio.h>

int main(void) {
  short unsigned int num;  // user input

  /* declare ALL of your variables below */
  
  int carryNum;
  int numDigits;
  int maxDigit;
  
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

  //print the column names
  printf("base converted number # of digits max digit\n");
  //print each row
  for (int i = 2; i <= 9; i++) {
    //initialize/reset variables
    carryNum = num;
    numDigits = 0;
    maxDigit = 0;
    //print the base
    printf("%-5d", i);
    //print the converted number backwards
    do {
      printf("%d", carryNum % i);
      if (carryNum % i > maxDigit) {
        maxDigit = carryNum % i;
      }
      carryNum /= i;
      numDigits++;
    } while (carryNum > 0);
    //fill in extra whitespace if needed
    for (int j = numDigits; j < 16; j++) {
      printf(" ");
    }
    //print the number of digits
    printf(" %-12d", numDigits);
    //print the max digit
    printf("%-9d\n", maxDigit);
  }

  /* your code goes above this line; do NOT modify the code below */
  
  return 0;
}// main 
