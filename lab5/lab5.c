/*********************************************************************
 * Lab 5
 * Author:       Martin Mueller
 * Description:  Performs various bit shifting operations on one or
 *               two 8-bit binary numbers.
 * Known bugs:   The isDoubleOf() function incorrectly returns 1
 *               for a handful of inputs.
 *********************************************************************/

#include "stdio.h"   // needed for printf

/* return 1 if n is odd, 0 otherwise
*/
int isOdd(char n) {
  return n & 1;
}// isOdd function

/* return 1 if n is negative, 0 otherwise
*/
int isNegative(char n) {
  return (n >> 7) & 1;
}// isNegative function

/* return n with its least significant bit flipped
*/
int lsbToggle(char n) {
  return n ^ 1;
}// lsbToggle function

/* return 1 if n is equal to zero, 0 otherwise
*/
int isZero(char n) {
  return ((~n) & 1)
         & (((~n) >> 1) & 1)
         & (((~n) >> 2) & 1)
         & (((~n) >> 3) & 1)
         & (((~n) >> 4) & 1)
         & (((~n) >> 5) & 1)
         & (((~n) >> 6) & 1)
         & (((~n) >> 7) & 1);
}// isZero function

/* return the value of -(n + 1)
*/
int negativeNplus1(char n) {
  return ~n;
}// negativeNplus1 function

/* return 1 if n1 and n2 have the same sign, 0 otherwise
*/
int sameSign(char n1, char n2) {
  return (~(isNegative(n1) ^ isNegative(n2))) & 1;
}// sameSign function

/* return 1 if n1 and n2 have the same parity, 0 otherwise
*/
int sameParity(char n1, char n2) {
  return (~(isOdd(n1) ^ isOdd(n2))) & 1;
}// sameParity function

/* return 1 if n1 and n2 are one's complements of each other, 0 otherwise
*/
int are1sComplement(char n1, char n2) {
  return (n1 ^ n2)
         & ((n1 >> 1) ^ (n2 >> 1))
         & ((n1 >> 2) ^ (n2 >> 2))
         & ((n1 >> 3) ^ (n2 >> 3))
         & ((n1 >> 4) ^ (n2 >> 4))
         & ((n1 >> 5) ^ (n2 >> 5))
         & ((n1 >> 6) ^ (n2 >> 6))
         & ((n1 >> 7) ^ (n2 >> 7)) & 1;
}// are1sComplement function

/* return 1 if the value of n1 is equal to twice the value of n2, 0 otherwise
*/
int isDoubleOf(char n1, char n2) {
  return (~((n1 >> 1) ^ n2))
         & (~((n1 >> 2) ^ (n2 >> 1)))
         & (~((n1 >> 3) ^ (n2 >> 2)))
         & (~((n1 >> 4) ^ (n2 >> 3)))
         & (~((n1 >> 5) ^ (n2 >> 4)))
         & (~((n1 >> 6) ^ (n2 >> 5)))
         & sameSign(n1, n2) & sameSign(n1, n2 << 1) & 1;
}// isDoubleOf function

/**********************************************************************
  Do not modify the code below this line
 **********************************************************************/

/* print table header 
 */
void printHeader(short int t[], int n) {
  printf("                ");
  for(int i = 0; i< n; i++) {
    printf("%4d ", t[i]);
  }
  printf("\n");  
}

/* print the table row where f is applied to each element of t 
 */
void printRow(int (*f)(char), char fname[], short int t[], int n) {
  printf("%15s ", fname);
  for(int i = 0; i < n; i++) {
    printf("%4d ", f(t[i]));
  }
  printf("\n");
}// printRow function

/* print the table where f is applied to each pair of elements of t 
 */
void printTable(int (*f)(char, char), char fname[], short int t[], int n) {
  for(int r = 0; r < n; r++) {
    printf("%10s %4d ", fname, t[r]);
    for(int c = 0; c < n; c++) {    
      printf("%4d ", f( t[r], t[c] ));
    }
    printf("\n");
  }
  printf("\n");  
}// printTable function

int main(void) {
  short int n1, n2;
  short int tests[] =
     {-128, -127, -64, -4, -3, -2, -1, 0, 1, 2, 3, 4, 63, 126, 127};
  int NUM_TESTS = 15;

  printHeader(tests, NUM_TESTS);
  printRow(isOdd,          "odd:",       tests, NUM_TESTS);
  printRow(isNegative,     "negative:",  tests, NUM_TESTS);
  printRow(lsbToggle,      "lsbToggle:", tests, NUM_TESTS);
  printRow(isZero,         "isZero:",    tests, NUM_TESTS);
  printRow(negativeNplus1, "-(n+1):",    tests, NUM_TESTS);

  printf("\n");
  printHeader(tests, NUM_TESTS);
  printTable(sameSign, "sameSign", tests, NUM_TESTS); 

  printHeader(tests, NUM_TESTS);
  printTable(sameParity, "sameParity", tests, NUM_TESTS); 

  printHeader(tests, NUM_TESTS);
  printTable(are1sComplement, "1's compl.", tests, NUM_TESTS);

  printHeader(tests, NUM_TESTS);
  printTable(isDoubleOf, "is double", tests, NUM_TESTS); 

  return 0;  
}// main function
