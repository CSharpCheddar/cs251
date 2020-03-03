/***********************************************************************
 * Lab 1
 * Author:      Martin Alexander Mueller
 * Description: Convert a non-negative decimal number to its 16-bit binary representation.
 * Known bugs:  
 ***********************************************************************/

#include <stdio.h>

int main(void) {
  short unsigned int num;
  
  printf("Enter an integer between 0 and 65535: ");
  scanf(" %hu", &num);
  
  /* Write your code below this comment block. 
     Do NOT modify anything between the top comment block and this one. 
     For full credit, your code below MUST meet ALL of the requirements 
     listed in the lab handout.
   */

  printf("%5u = 2 * %5u + %u\n", num, num / 2, num % 2);
  num /= 2;
  printf("%5u = 2 * %5u + %u\n", num, num / 2, num % 2);
  num /= 2;
  printf("%5u = 2 * %5u + %u\n", num, num / 2, num % 2);
  num /= 2;
  printf("%5u = 2 * %5u + %u\n", num, num / 2, num % 2);
  num /= 2;
  printf("%5u = 2 * %5u + %u\n", num, num / 2, num % 2);
  num /= 2;
  printf("%5u = 2 * %5u + %u\n", num, num / 2, num % 2);
  num /= 2;
  printf("%5u = 2 * %5u + %u\n", num, num / 2, num % 2);
  num /= 2;
  printf("%5u = 2 * %5u + %u\n", num, num / 2, num % 2);
  num /= 2;
  printf("%5u = 2 * %5u + %u\n", num, num / 2, num % 2);
  num /= 2;
  printf("%5u = 2 * %5u + %u\n", num, num / 2, num % 2);
  num /= 2;
  printf("%5u = 2 * %5u + %u\n", num, num / 2, num % 2);
  num /= 2;
  printf("%5u = 2 * %5u + %u\n", num, num / 2, num % 2);
  num /= 2;
  printf("%5u = 2 * %5u + %u\n", num, num / 2, num % 2);
  num /= 2;
  printf("%5u = 2 * %5u + %u\n", num, num / 2, num % 2);
  num /= 2;
  printf("%5u = 2 * %5u + %u\n", num, num / 2, num % 2);
  num /= 2;
  printf("%5u = 2 * %5u + %u\n", num, num / 2, num % 2);
  num /= 2;

  return 0;
}
