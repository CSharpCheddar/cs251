/*********************************************************************
 * Lab 4
 * Author:       Martin Mueller
 * Description:  Converts the fractional part of a binary floating
                 point number into decimal.
 *********************************************************************/

#include <stdio.h>
#include "lab4.h"

/* Wait for the user to enter between 0 and MAX_LENGTH characters
   followed by a newline character, and store these characters (NOT
   including the newline character) in the input array as a null-
   terminated string.  You can assume that the argument is large
   enough to store the input string.
   Return the length of the input string, while the latter is stored in 
   the argument upon return.
   Example:  input: an empty array
             the user types in: cs251\n
             the function returns the integer 5 and the string 
                        'c' 's' '2' '5' '1' '\0'
                 is stored in the argument
 */
int getInputString(char input[]) {

  int length = 0;
  for (int i = 0; i <= MAX_LENGTH; i++) {
    char c = getchar();
    if (c == '\n' || i == MAX_LENGTH) {
      input[i] = '\0';
      break;
    }
    input[i] = c;
    length++;
  }
  return length;

}// getInputString


/* Given an input string representing a binary number containing a binary point
   return (in the second argument) the fractional part of that number preceded
   by "0."
   You can assume that the first argument always contains exactly one point.
   Examples:  number = 101.01    fractional = 0.01
              number = .001      fractional = 0.001
              number = 1010.0    fractional = 0.0
              number = 1010.00   fractional = 0.00
              number = 1010.     fractional = 0.
 */
void getFractionalPart(char number[], char fractional[]) {

  fractional[0] = '0';
  fractional[1] = '.';
  int offset = 0;
  for (int i = 0; i < MAX_LENGTH; i++) {
    offset++;
    if (number[i] == '.') {
      break;
    }
  }
  for (int i = 0; i < MAX_LENGTH; i++) {
    if (number[i + offset] == '\0' || i == MAX_LENGTH - 1) {
      fractional[i + 2] = '\0';
      break;
    }
    fractional[i + 2] = number[i + offset];
  }
  
}// getFractionalPart

/* Given an input string representing a binary number whose format is given
   by the output of the previous function, return the decimal value of this
   binary number.
   Examples:    fractional = 0.01   return 0.25
                fractional = 0.0    return 0
                fractional = 0.     return 0
 */
float convertToDecimal(char fractional[]) {

  float decimalFraction = 0.0;
  for (int i = 2; i < MAX_LENGTH; i++) {
    if (fractional[i] == '\0') {
      break;
    }
    if (fractional[i] == '1') {
      float decimalPlace = 1;
      for (int j = 1; j < i; j++) {
        decimalPlace /= 2;
      }
      decimalFraction += decimalPlace;
    }
  }
  return decimalFraction;
  
} // convertToDecimal
