/*********************************************************************
 * Lab 6
 * Author:       Martin Mueller
 * Description:  Takes user entered floting point numbers and outputs
 *               the numbers which share the same bit pattern in their
 *               significands and/or exponents.
 *********************************************************************/

#include "stdio.h"   // needed for our use of printf and scanf
#include "stdlib.h"  // needed for memory allocation functions

/* given two integer pointers and two bit indices, return 1 if and
   only if the substring of bits from leftIndex to rightIndex
   (inclusive) in the first integer is equal to the substring defined
   by the same indices in the second integer. Return 0 otherwise. 
   Note that each bit in an integer is indexed from 0 (least significant
   bit) to 31 (most significant bit). The caller guarantees that
   leftIndex >= rightIndex and that each index is in range.
*/
int sameBits(int leftIndex, int rightIndex, int *p1, int *p2) {
  int result = 1;
  for (int i = rightIndex; i <= leftIndex; i++) {
    result = (~((*p1 >> i) ^ (*p2 >> i))) & result;
  }
  return result;
}// sameBits function

int main(void) {

  /* declare and allocate space for an array (called floats) of ONE float */

  float *floats = (float *) malloc(sizeof(float));
  if (floats == NULL) {
    printf("Error: Failed to allocate memory for the float array\n");
    return 1;
  }
  unsigned int floatsSize = 1;

  /* prompt the user to enter a sequence of floats ending in 0.
     Add each number to the floats array, each time increasing the array size
     just enough to store all of the numbers entered by the user.
   */

  printf("Enter any number of numbers (ending with 0): ");
  scanf("%g", &floats[0]);
  if (floats[0] == 0) {
    floatsSize = 0;
  } else {
    while (1) {
      floats = (float *) realloc(floats, (floatsSize + 1) * sizeof(float));
      if (floats == NULL) {
        printf("Error: Failed to allocate memory for the float array\n");
        free(floats);
        return 1;
      }
      scanf("%g", &floats[floatsSize]);
      if (floats[floatsSize] == 0) {
        floats = (float *) realloc(floats, (floatsSize) * sizeof(float));
        if (floats == NULL) {
          printf("Error: Failed to allocate memory for the float array\n");
          free(floats);
          return 1;
        }
        break;
      }
      floatsSize++;
    }
  }

  /* print the number of numbers entered by the user */

  if (floatsSize == 1) {
    printf("You entered 1 number.\n");
  } else {
    printf("You entered %u numbers.\n", floatsSize);
  }

  /* go over all pairs of numbers in the array and compare their significands
     and then their exponents 
  */

  if(floatsSize == 1) {
    printf("Not enough numbers to compare.\n");
  } else if (floatsSize > 1) {
    for (int i = 0; i < floatsSize - 1; i++) {
      for (int j = i + 1; j < floatsSize; j++) {
        if (sameBits(22, 0, (int *) &floats[i], (int *) &floats[j])) {
          printf("%g and %g have the same significand.\n", floats[i], floats[j]);
        }
        if (sameBits(30, 23, (int *) &floats[i], (int *) &floats[j])) {
          printf("%g and %g have the same exponent.\n", floats[i], floats[j]);
        }
      }
    }
  }

  /* clean up and exit */

  free(floats);

  return 0;
}// main
